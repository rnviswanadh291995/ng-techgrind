#
#	list_entities:
#		display-style___________
#		this list object should display elements in a vertical 1-column list with:
#		* a small logo
#		* name
#		* type (what type of entity is it?) (can be multiple)
#		* market segment / specialty (can be multiple)
#		* location(s) (city/country) (can be multiple)
#		
#		example:
#		* <tg-logo>
#		* TechGrind
#		* Service, Community, Incubator, Investor, Office
#		* Startups, Technology, Software, Cloud
#		* China, Cambodia, Singapore, Thailand, Vietnam, Malaysia, Philippines
# 
#		functional goal___________
#		this list object should simply act as a nice wide column display grid
#			with a thumbnail, allowing user to navigate to the full-profile-page
#			of the displayed element.
#			
#		example-entity -> displayed information ==> action-on-interaction:
#			investors/startups/services -> small logo thumbnail + detailed info ==> profile page
#

# - name
# - location
# - type ( startup, investors, conworking space etc...)
# - ID for user : user.type.favorite[] 

# row 1 : Name | location
# row 2 : Type

# Pagination or inifinity scroll (download, say, 5 rows at a time)
# Add star on the right
# click at the star = fixed on top (favorite) & add that entities  user.type.favorite[] for user record
# click at the row = redirect to the start/service/investor profile page. example http://127.0.0.1:8000/#/people
appModule = angular.module("TechGrindApp.controllers.list.entities", ["TechGrindApp.directives.ngErrSrc"])
appModule.controller "ListEntitiesCtrl", [ "$scope", "steam", "$routeParams", "$location", ($scope, steam, rp, loc) ->
      get_countries = undefined
      get_country = undefined
      console.log("getting:", $scope.filter)
      $scope.debug = [ $scope.filter ]
      $scope.countries = {}
      $scope.sgenome = {}
      $scope.entities = []
      $scope.user =
        userid: "efraimip"
        favorite: []

      $scope.goToOrganization = (slug) ->
        loc.path "profile/startup/" + slug

      $scope.userFavorite = (organization_id) ->
        isFavoriteExist = $scope.user.favorite.indexOf(organization_id) isnt -1
        if isFavoriteExist
          $scope.user.favorite.splice $scope.user.favorite.indexOf(organization_id), 1
        else
          $scope.user.favorite.push organization_id
        $scope.entities[organization_id].favorited = (if ($scope.entities[organization_id].favorited) then false else true)
        console.log $scope.user.favorite

      get_entities = (country, filter) ->
        $scope.debug.push [
          "getting"
          country
          filter
        ]
        console.log sexpr("get_entities", country, filter, $scope.debug)
        if country
          country = "/" + country
        else
          country = ""
        if filter
          if !Array.isArray filter
            filter = [ filter ]
        else
          filter = [""]
        for category in filter
          if (category != "")
            category = "/"+category
          steam.get("/home/techgrind/organizations" + country + category).then (data) ->
            $scope.debug.push [ "got", country, category ]
            $scope.entities = data.sgenome

      console.log(sexpr(["filter: ", $scope.filter ]))
      get_entities(rp.region, $scope.filter)
  ]
