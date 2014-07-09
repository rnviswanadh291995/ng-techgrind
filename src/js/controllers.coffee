###
# 
# 	File: <name>
# 		Define file purpose: "What does this file do??? Why does it exist???"
# 
# 	Class: <name>
# 		Is this a class/object? Define its purpose: its "persona" or "role"
# 		Define its structure: what data elements, methods, etc does it need?
# 
# 	Function: <name>
# 		Is this a function? Define its purpose.
# 		Here's an example, lets say its a multiply function...
# 		Parameters/Inputs:
# 			x - The first integer.
# 		 	y - The second integer.
# 		Returns/Outputs:
# 		 	The two integers multiplied together.
# 		Example/Usage:
# 			var x = <functionName>(a,b);
# 			input.print tostring(x);
# 		 
# 	See Also:
#  		links? another file? function? webpage tutorial?
# 		anything else that can help me understand this file overall? 
# 
###

app = angular.module 'TechGrindApp.controllers', []

app.run(['$rootScope', (root) ->
	root.sexpr = sexpr
])

# COMPLETE: by Martin
app.controller 'AppCtrl', ['$scope', '$location', 'steam', (S, loc, steam) ->
	S.active = (menuItem) -> if loc.path() == menuItem then 'active'
	S.user = steam.user
	S.loginp = steam.loginp
	S.logout = steam.logout
	S.data = {}

	handle_request = (data) ->
		S.data = data

	steam.get('login').then(handle_request)
]

# COMPLETE: by Efraim
app.controller 'MenuCtrl', ['$scope', '$http', (S, http) ->
	S.menuActive = 
		name: 'Home'
		url: 'home'
		icon: 'fa-home'

	S.mainMenu = [
		name: 'Home'
		url: 'home'
		icon: 'fa-home'
	,
		name: 'Events'
		url: 'events'
		icon: 'fa-bullhorn'
	,
		name: 'Jobs'
		url: 'jobs'
		icon: 'fa-laptop'
	,
		name: 'Resources'
		icon: 'fa-cloud-download'
		submenu: [
			name: 'Guides & Tutorials'
			url: 'res-guides'
			icon: 'fa-lightbulb-o'
		,
			name: 'Docs & Templates'
			url: 'res-docs'
			icon: 'fa-file-text'
		,
			name: 'Photos & Video'
			url: 'res-media'
			icon: 'fa-film'
		]
	,
		name: 'TechGrind'
		icon: 'fa-cogs'
		submenu: [
			name: 'Startup Hubs'
			url: 'tg-hubs'
			icon: ''
		,
			name: 'Membership'
			url: 'tg-members'
			icon: ''
		,
			name: 'Community'
			url: 'tg-activities'
			icon: ''
		,
			name: 'Incubator'
			url: 'tg-incubator'
			icon: ''
		]
	];

	S.countries = [
		name: 'Cambodia'
		url: 'cambodia'
	,
		name: 'China'
		url: 'china'
	,
		name: 'Indonesia'
		url: 'indonesia'
	,
		name: 'India'
		url: 'india'
	,
		name: 'Malaysia'
		url: 'malaysia'
	,
		name: 'Philippines'
		url: 'philippines'
	,
		name: 'Singapore'
		url : 'singapore'
	,
		name: 'Thailand'
		url: 'thailand'
	,
		name: 'Vietnam'
		url: 'vietnam'
	];

	S.resources = [
		name: 'Startup Jobs'
		url: 'resources/jobs'
		icon: 'icon-laptop'
	,
		name: 'Docs & Templates'
		url: 'resources/docs'
		icon: 'icon-file-text'
	,
		name: 'Guides & Tutorials'
		url: 'resources/guides'
		icon: 'icon-lightbulb'
	,
		name: 'Photos & Video'
		url: 'resources/media'
		icon: 'icon-film'
	,
		name: 'TeamSpeak Server'
		url: 'resources/teamspeak'
		icon: 'icon-group'
	];
]

# COMPLETE: by Martin
app.controller 'RegisterCtrl', ['$scope', '$location', 'steam', (S, loc, steam) ->
	S.registerdata = {}
	S.passwordmatch = true
	tested_users = {}
	S.tested_users = () ->
		tested_users
	S.user_checking = ->
		S.registerdata.userid and typeof tested_users[S.registerdata.userid] == 'undefined'
	S.user_available = ->
		typeof tested_users[S.registerdata.userid] != 'undefined' and !tested_users[S.registerdata.userid]
	S.user_taken = ->
		typeof tested_users[S.registerdata.userid] != 'undefined' and tested_users[S.registerdata.userid]

	S.register = ->
		S.registerdata.group = 'techgrind'
		steam.post('register', S.registerdata).then(handle_request)

	handle_request = (data) ->
		S.data = data

	S.$watch('[registerdata.password, registerdata.password2]', ->
		if S.registerdata.password and S.registerdata.password2 and S.registerdata.password != S.registerdata.password2
			S.passwordmatch = false
		else
			S.passwordmatch = true
	true)

	S.$watch('registerdata.fullname', ->
		count = 0
		if S.registerdata.fullname
			S.testname = S.registerdata.fullname.toLowerCase().replace(/[^a-z ]/g, "").trim().replace(/\s+/g, ".")
		S.registerdata.userid = S.testname

		handle_user = (data) ->
			console.log(sexpr("user-result", data))
			if data.error == "request not found"
				tested_users[data.request] = false
			else
				count++
				tested_users[data.request] = true
				if data.request==S.registerdata.userid
					S.registerdata.userid = S.testname+"."+count
					steam.get(S.registerdata.userid).then(handle_user)
		if S.registerdata.userid
			steam.get(S.registerdata.userid).then(handle_user))

	S.$watch('registerdata.userid', ->
		handle_user = (data) ->
			console.log(sexpr("userid-result", data))
			if data.error == "request not found"
				tested_users[data.request] = false
			else
				tested_users[data.request] = true
		if S.registerdata.userid
			steam.get(S.registerdata.userid).then(handle_user))
]

# COMPLETE: by Paulo
app.controller 'LoginCtrl', ['$scope', '$location', '$routeParams', 'steam', (S, loc, rp, steam) ->
	S.username = ""
	S.password = ""
	S.userid  = ""

	if rp.userid
		S.userid = rp.userid

	S.loginp = steam.loginp
	S.user = steam.user

	S.showSignIn = false

	S.logout = ->
		steam.logout().then(handle_request)
	S.login = ->
		console.log(sexpr("LoginCtrl", S.userid, S.password))
		steam.login(S.userid, S.password).then(handle_request)
		S.userid = ""
		S.password = ""
	S.signUp = ->
		S.showSignIn = true
	S.goToLogin = ->
		S.showSignIn = false
	S.signUpAction = ->
		console.log('still not doing nothing...')
	S.validateFields = ->
		return S.userid.length == 0 || S.password.length == 0

	handle_request = (data) ->
		S.data = data
		console.log(sexpr("LoginCtrl", "handle_request", S.user(), data))

	steam.get('login').then(handle_request)
]

# COMPLETE: by Martin
app.controller 'ActivationCtrl', ['$scope', '$routeParams', 'steam', (S, rp, steam) ->
	handle_activation = (data) ->
		if data.result == "user is activated"
			S.activation = "activated"
		else if data.error == "user already activated"
			S.activation = "active"
		else
			S.activation = "failed"
		S.userid = rp.userid
		S.error = data.error
		S.data = data
	activationdata =
		activate: rp.activationcode
		userid: rp.userid
	steam.post('activate', activationdata).then(handle_activation)
]

# COMPLETE: by Martin
app.controller 'StartupGenomeCtrl', ['$scope', '$routeParams', 'steam', (S, rp, steam) ->
	S.countries = {}
	S.sgenome = {}
	S.debug = []

	get_countries = (data) ->
		for country in data.inventory
			S.countries[country.name] = country

	get_country = (country, filter) ->
		S.debug.push = [ "getting", country, filter ]
		if filter
				filter = "/"+filter
		else
				filter = ""
		steam.get('/home/techgrind/organizations/country/'+country+filter).then((data) ->
				S.debug.push = "got "+country
				S.sgenome[country] = data
				)

	steam.get('/home/techgrind/organizations/country').then(get_countries)
	if rp.country
		get_country(rp.country, rp.filter)

]

# this control needs to be redone
app.controller 'ContentCtrl', ['$scope', '$route', '$location', '$routeParams', (S, r, loc, rp)  ->
	S.loc = loc
	S.rp = rp
	S.articlename=rp.articlename
	S.day = rp.day
	S.month = rp.month
	S.content = rp.content
	S.tabs = [
		title: 'Articles'
	,
		title: 'Events'
	]

	S.getblog = getblog()

	S.regionblog = {}
	S.chatterbox = []
	S.addComment = -> 
		S.comments.push(print: S.commenttext)
		S.commenttext="";
	S.findarticle =(name) ->
		name=rp.articlename
		for item in S.getblog.articles
			console.log(sexpr(item))
			if(item.articlename==name)
				return item

	if rp.articlename
		S.article = S.findarticle(rp.articlename)

	S.find = (regionname) ->
		regionname=rp.region
		for item in S.getblog.articles
			console.log(sexpr(item))
			if(item.country==regionname)
				return item

	matchregion = (item) ->
		console.log(sexpr("filter", item.country==rp.region, item.country, rp.region, item))
		item.country==rp.region

	if rp.region
		S.regionblog.articles = S.getblog.articles.filter(matchregion)
		S.regionblog.events = S.getblog.events.filter(matchregion)
		S.regionblog.calendar = S.getblog.calendar.filter(matchregion)
	S.profiles = [
		role: 'Volunteers'
		icon: 'icon-group'
		type: 'volunteers'
	]
	S.regiongetdetail = regiongetdetail()
	S.regionprofile={}
	S.findprofile = (rname) ->
		rname=rp.region
		for detail in S.regiongetdetail.volunteers
			console.log(sexpr(item))
			if(detail.country==rname)
				return detail
	matchr = (detail) ->
		console.log(sexpr("filter", detail.country==rp.region, detail.country, rp.region, detail))
		detail.country==rp.region

	if rp.region
		S.regionprofile.volunteers = S.regiongetdetail.volunteers.filter(matchr)

	S.rendercal = () ->
		$('#calendar').fullCalendar('render');
		console.log(sexpr("cal-tab-selected"))

	S.list1 = [
		name: 'News'
	,
		name: 'Articles'
	]
	S.list2 = []
]

app.controller 'AdminCtrl', ['$scope', '$location', 'steam', (S, loc, steam) ->

	S.feeds = []

	S.$watch('newfeed.title', ->
		if S.newfeed.title
			S.testname = S.newfeed.title.toLowerCase().replace(/[^a-z ]/g, "").trim().replace(/\s+/g, "-")
		S.newfeed.name = S.testname)

	handle_feeds = (data) ->
		S.data = data
		S.feeds = data.inventory

	handle_delete = (data) ->
		S.data = data

	steam.get('/home/techgrind/feeds/').then handle_feeds

	S.add_feed = () ->
		steam.put('/home/techgrind/feeds/', S.newfeed).then handle_feeds

	S.delete_feed = (thisfeed) ->
		steam.delete(thisfeed).then handle_delete
		steam.get('/home/techgrind/feeds/').then handle_feeds
]

