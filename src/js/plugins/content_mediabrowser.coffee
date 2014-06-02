#
#	content_mediabrowser:
#		display-style___________
#		this content display plugin acts as a media browser. it should be a fully built-in
#			media browser with navigation inside of the media itself (when and if possible).
#			the media browser will handle video and photos, which also serve as navigation.
#			there are 2 types of elements to display in this plugin.
#		
#		1) media, which sould include:
#		* video / photo thumbnail
#		* text-title
#		* author
#		
#		2) category, which should include:
#		* photo thumbnail
#		* text-title
#		
#		example #1:
#		* <thumbnail>
#		* eKita @ SLAP.BKK#2 Pitching!
#		* Efraim Pettersson
#		
#		example #1 - when clicked on, full-scale-view:
#		* <thumbnail>
#		* eKita @ SLAP.BKK#2 Pitching!
#		* Efraim Pettersson
#		* July 2, 19:07
#		* {FB:10, GP:6, TW:19}
#		
#		example #2:
#		* <techgrind-logo>
#		* TechGrind
#		
#		example #2.2: (a sub-category)
#		* <thumbnail>
#		* TechGrind.Events
#		
#		functional goal___________
#		this plugin should display media in a media browser as thumbnails.
#			when clicking on a thumbnail, 1 of 2 things happens:
#			1) if thumbnail is a category, media browser navigates to the category, adding a "breadcrumb" to a navigation element
#			2) if thumbnail is an image/video, media browser expands view to full-scale for the specified media object
#			
#		example-media -> displayed information ==> action-on-interaction:
#			photo/video/image -> thumbnail-view ==> full-scale view
#

# I control the root of the application.
(->
  app = angular.module("TechGrindApp.controllers.content.mediabrowser", [])
  app.controller "ContentMediaCtrl", [
    "$scope"
    "$location"
    "steam"
    "$routeParams"
    "$http"
    ($scope, loc, steam, $routeParams, $http) ->
      callHttpForListOfCats = ->
        listOfCatFromJson = $http.get("http://dev-back1.techgrind.asia/scripts/rest.pike?request=/home/techgrind/resources/media/tree")
        listOfCatFromJson.success (data) ->
          console.log "Data for menu...", data.inventory
          $scope.categories = data.inventory
          $scope.level = 0
          return

        return
      callHttpForListOfMedia = (cat) ->
        listOfCatFromJson = $http.get("http://dev-back1.techgrind.asia/scripts/rest.pike?request=" + cat)
        listOfCatFromJson.success (data) ->
          console.log "Data for menu...", data.inventory
          $scope.listOfMedia = data.inventory
          return

        return
      $scope.level = -1
      $scope.titleCatActive = ""
      $scope.goToSubLevel = (item) ->
        $scope.level = 1
        $scope.titleCatActive = item.title
        callHttpForListOfMedia item.path
        return

      $scope.modifiUrlForSrc = (path) ->
        "http://dev-back1.techgrind.asia" + path

      $scope.goBackToList = ->
        $scope.level = "0"
        $scope.listOfMedia = []
        $scope.titleCatActive = ""
        return

      callHttpForListOfCats()
  ]
  return
).call this
