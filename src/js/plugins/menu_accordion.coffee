
# lets find were we are in the app

#var lokky = sharedData;

#lets verify we havent save the information into localstorage

#listOfCatFromJson = $http.get('/json/docs_menu.json');

#listOfCatFromJson = $http.get('/json/guides_menu.json');

#			console.log('$scope.selectedCat: ',$scope.selectedCat);
#			console.log('$scope.selectedList: ',$scope.selectedList);

#			console.log('$scope.selectedCat: ',$scope.selectedCat);
#			console.log('$scope.selectedList: ',$scope.selectedList);
appModule = angular.module("TechGrindApp.plugins.menu.accordion", [])
appModule.controller "MenuAccordionCtrl", [ "$scope", "$rootScope", "$routeParams", "$http", "$location", "localStorageService", "GuidesSharedData", "DocsSharedData", 
	($scope, $rootScope, $routeParams, $http, $location, localStorageService, GuidesSharedData, DocsSharedData) ->
      updateIOActive = (id, title) ->
        if lokky is "docs"
          DocsSharedData.itemShared =
            id: id
            title: title
        else
          GuidesSharedData.itemShared =
            id: id
            title: title
        $rootScope.$broadcast "iodActive", id
        return
      listOfCatFromJson = null
      lokky = $location.$$url.split("/")[2]
      menuSaved = localStorageService.get(lokky + "Menu")
      unless !!menuSaved
        if lokky is "docs"
          listOfCatFromJson = $http.get("http://dev-back1.techgrind.asia/scripts/rest.pike?request=/home/techgrind/resources/docs/tree")
        else listOfCatFromJson = $http.get("http://dev-back1.techgrind.asia/scripts/rest.pike?request=/home/techgrind/resources/guides/tree")  if lokky is "guides"
        listOfCatFromJson.success (data) ->
          console.log "Data for menu...", data.inventory
          $scope.menuItems = data.inventory
          localStorageService.add lokky + "Menu", JSON.stringify(data.inventory)
          $scope.selectedCat = $scope.menuItems[0].oid
          updateIOActive $scope.menuItems[0].path, $scope.menuItems[0].title
          return

      else
        $scope.menuItems = JSON.parse(menuSaved)
        $scope.selectedCat = $scope.menuItems[0].oid
        updateIOActive $scope.menuItems[0].path, $scope.menuItems[0].title
      $scope.modifyUrl = (item) ->
        $scope.selectedList = item.oid
        updateIOActive item.path, item.title
        return

      $scope.selectCat = (item) ->
        $scope.selectedList = null
        if item.oid isnt $scope.selectedCat and not item.open
          $scope.selectedCat = item.oid
          $.each $scope.menuItems, (k, v) ->
            v.open = false
            return

          item.open = true
        else if item.oid is $scope.selectedCat and not item.open
          item.open = true
        else
          item.open = false
        updateIOActive item.path, item.title
        return

      $scope.selectedSubCat = -666
      $scope.selectSubCat = (item) ->
        if item.oid isnt $scope.selectedSubCat and not item.open
          $scope.selectedSubCat = item.oid
          item.open = true
        else if item.oid is $scope.selectedSubCat and not item.open
          item.open = true
        else
          item.open = false
        updateIOActive item.path, item.title
        return
  ]

appModule.controller "MenuCtrl", [ "$scope", "$routeParams", "$location", (S, rp, loc) ->
	S.menu = [
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
	]

	activemenu = [ "home" ]

	S.isactive = (entry) ->
		return true if activemenu is entry
		return false if entry.length > activemenu.length
		for i in [0..entry.length]
			return false if entry[i] isnt activemenu[i]
		true

	S.activate = (entry) ->
		activemenu = entry
	]
