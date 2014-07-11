# File: services.coffee
#   defines angular.js services

services = angular.module 'TechGrindApp.services', []
services.value 'version', '0.1'

# Service: steam
#   wraps around the $http service to access the sTeam REST api.
#   ( http://docs.angularjs.org/api/ng.$http )
#
#   uses http://angularjs.org/object/localStorageService
#   to store data in the browsers localstorage
#
#   provides functions to handle login, get data, put new objects and post updates
#
#   functions return a promise object which expects a callback function as argument:
#
#   steam.<function>(args).then(callback_handler)
#
#   callback_handler needs to be defined before calling the service.
#   it receives the data from the server as argument:
#
#   handle_request = (data) ->
#      # do something with the data
#
#   public functions are:
#      login(username, password): 
#          take and store login data
#      logout: remove login data
#      loginp: return true if the user is logged in, false otherwise
#      user: return userdetails if logged in
#      get(resource):
#          make a GET request and return resulting JSON data
#          resource describes the path to the sTeam object within sTeam
#          returns the data of the requested object
#      post(resource, data):
#          POST data to update existing sTeam objects
#          resource describes the path to the sTeam object to be updated
#          returns the data of the updated object
#      put(resource, data):
#          PUT data to create new objects
#          resource is the parent object within which the new object is to be created
#          returns the data of the updated object
#  (not sure in how much detail get, put and post descriptions should go. their
#  semantics are defined by the REST api so this should actually be part of the
#  REST api documentation)

services.factory 'steam', ($http, localStorageService) ->
	baseurl = 'http://dev-back1.techgrind.asia/'
	restapi = baseurl+'scripts/rest.pike?request='

	# helperfunction to preprocess the returned data.
	# the sTeam server includes the current user whith which the request was made
	# because we are using basic authentication there is no seperate login step,
	# but login happens again with each request.
	# the sTeam response includes the user-data for the user of this request 
	# and we store that user data in the browser for later access.
	handle_request = (response) ->
		localStorageService.add('user', JSON.stringify(response.data.me))
		console.log(sexpr("steam-service", "response", response))
		response.data

	# test if the user is logged in.
	# this does not make a request to the server but only verifies that we have
	# received valid user-data before.
	loginp = ->
		logindata = JSON.parse(localStorageService.get('logindata'))
		user = JSON.parse(localStorageService.get('user'))
		logindata and user and user.id and user.id != "guest"

	# headers which are needed to be added to every request
	headers = (login) ->
		logindata = JSON.parse(localStorageService.get('logindata'))
		if loginp() or (login and logindata)
			headers: logindata
		else
			{}

	# store username and password in the browser and then make a login request to test them
	# handle_request will store the user-data sent by the server to complete the login. 
	login: (userid, password) ->
		console.log(sexpr("steam-service", "login:", userid, password))
		if userid != "" and password != ""
			localStorageService.add('logindata', JSON.stringify(Authorization: 'Basic '+window.btoa(userid + ":" + password)))
			$http.get(restapi+"login", headers(true)).then(handle_request)

	# wipe username and password from local storage and send a login request to
	# the server which will cause the server to respond with 'guest' user data,
	# replacing our previously stored user data
	logout: ->
		localStorageService.remove('logindata')
		localStorageService.remove('user')
		$http.get(restapi+"login", headers()).then(handle_request)

	# same as the loginp function above
	loginp: loginp

	# only return user data if we are logged in.
	user: ->
		if loginp()
			JSON.parse(localStorageService.get('user'))

	get: (request) ->
		console.log(sexpr("steam-service", "GET", request))
		$http.get(restapi+request, headers()).then(handle_request)

	post: (request, data) ->
		console.log(sexpr("steam-service", "POST", request, data))
		$http.post(restapi+request, data, headers()).then(handle_request)

	put: (request, data) ->
		console.log(sexpr("steam-service", "PUT", request, data))
		$http.put(restapi+request, data, headers()).then(handle_request)

	delete: (request) ->
		console.log(sexpr("steam-service", "DELETE", request))
		$http.delete(restapi+request, headers()).then(handle_request)

# service "user settings"
# user configurable settings are to be stored on the server.
# for now they are just stored in localstorage in the browser, so this appears
# to be just a frontend to the localStorageService
services.factory 'settings', (localStorageService) ->
        get: (key) ->
                localStorageService.get(key)
        set: (key, value) ->
                localStorageService.add(key, value)

# service "requestContext"
# Data binding for home subviews
services.factory 'listService', ($q, _) ->
	getTypes = ->
		deferred = $q.defer()
		deferred.resolve( ng.copy( cache ) )
		return deferred.promise

	getTypeByID = (id) ->
		deferred = $q.defer()
		type = _.findWithProperty( cache, "id", id );
		if type
			deferred.resolve( ng.copy( category ) )
		else
			deferred.reject()
		return deferred.promise
		
	#Setup list type data cache
	cache = [{id: "startups",name: "Startups"},{id: "investors",name: "Investors"}]
	
	return {getTypes: getTypes,getTypeByID: getTypeByID}
	
services.factory 'requestContext', (RenderContext) ->
	getAction = ->
		return action

	getNextSection = (prefix) ->
		#Make sure the prefix is actually in the current action.
		if !startsWith( prefix )
			return null

		# If the prefix is empty, return the first section.
		if prefix == ""
			return sections[ 0 ]

		# Now that we know the prefix is valid, lets figure out the depth 
		# of the current path.
		depth = prefix.split( "." ).length

		# If the depth is out of bounds, meaning the current action doesn't
		# define sections to that path (they are equal), then return null.
		if depth == sections.length
			return null

		# Return the section.
		return sections[ depth ]
				
	getParam = (name, defaultValue) ->
		if ng.isUndefined( defaultValue )
			defaultValue = null;

		return (params[ name ] || defaultValue)
			
	# I return the param as an int. If the param cannot be returned as an 
	# int, the given default value is returned. If no default value is 
	# defined, the return will be zero.
	getParamAsInt = ( name, defaultValue ) ->
		# Try to parse the number.
		valueAsInt = ( this.getParam( name, defaultValue || 0 ) * 1 )

		#Check to see if the coersion failed. If so, return the default.
		if  isNaN( valueAsInt ) 
			return (defaultValue || 0)
		else
			return valueAsInt

	
	# I return the render context for the given action prefix and sub-set of 
	# route params.
	getRenderContext = (requestActionLocation, paramNames ) ->
		# Default the requestion action.
		requestActionLocation = ( requestActionLocation || "" )

		# Default the param names. 
		paramNames = ( paramNames || [] )

		# The param names can be passed in as a single name; or, as an array
		# of names. If a single name was provided, let's convert it to the array.
		if  !ng.isArray( paramNames )
			paramNames = [ paramNames ]
		
		return (new RenderContext( this, requestActionLocation, paramNames ))
		

		# I determine if the action has changed in this particular request context.
		hasActionChanged =() ->
			return (action != previousAction)

		# I determine if the given param has changed in this particular request 
		# context. This change comparison can be made against a specific value 
		# (paramValue); or, if only the param name is defined, the comparison will 
		# be made agains the previous snapshot.
		hasParamChanged = ( paramName, paramValue ) ->
			# If the param value exists, then we simply want to use that to compare 
			# against the current snapshot. 
			if !ng.isUndefined( paramValue )
				return !isParam( paramName, paramValue )

			# If the param was NOT in the previous snapshot, then we'll consider
			# it changing.
			if !previousParams.hasOwnProperty( paramName ) && params.hasOwnProperty( paramName )
				return true

			else if previousParams.hasOwnProperty( paramName ) && !params.hasOwnProperty( paramName )
				return true

			# If we made it this far, the param existence has not change; as such,
			# let's compare their actual values.
			previousParams[ paramName ] != params[ paramName ]

			# I determine if any of the given params have changed in this particular
			# request context.
			haveParamsChanged =( paramNames ) ->
				for i in [0 ... paramNames.length]
					if ( hasParamChanged( paramNames[ i ] ) ) 
						# If one of the params has changed, return true - no need to
						# continue checking the other parameters.
						return true
				
				# If we made it this far then none of the params have changed.
				return false

			# I check to see if the given param is still the given value.
			isParam = ( paramName, paramValue ) ->
				# When comparing, using the coersive equals since we may be comparing 
				# parsed value against non-parsed values.
				if params.hasOwnProperty( paramName ) && ( params[ paramName ] == paramValue )
					return true

				# If we made it this far then param is either a different value; or, 
				# is no longer available in the route.
				return false

			# I set the new request context conditions.
			setContext = ( newAction, newRouteParams ) ->
				# Copy the current action and params into the previous snapshots.
				previousAction = action
				previousParams = params
				
				# Set the action.
				action = newAction;

				# Split the action to determine the sections.
				sections = action.split( "." );

				# Update the params collection.
				params = ng.copy( newRouteParams );



			# I determine if the current action starts with the given path.
			startsWith =( prefix ) ->
				# When checking, we want to make sure we don't match partial sections for false
				# positives. So, either it matches in entirety; or, it matches with an additional
				# dot at the end.
				if !prefix.length || ( action == prefix ) || ( action.indexOf( prefix + "." ) == 0 )
					return( true )
				
				return( false )
				
				
			# Store the current action path.
			action = ""

			# Store the action as an array of parts so we can more easily examine 
			# parts of it.
			sections = []

			# Store the current route params.
			params = {}

			# Store the previous action and route params. We'll use these to make 
			# a comparison from one route change to the next.
			previousAction = ""
			previousParams = {}


			# Return the public API.
			return({ 
				getNextSection: getNextSection,
				getParam: getParam,
				getParamAsInt: getParamAsInt,
				getRenderContext: getRenderContext,
				hasActionChanged: hasActionChanged,
				hasParamChanged: hasParamChanged,
				haveParamsChanged: haveParamsChanged,
				isParam: isParam,
				setContext: setContext,
				startsWith: startsWith
			})
