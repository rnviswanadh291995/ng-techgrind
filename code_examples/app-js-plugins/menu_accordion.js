(function() {

	var appModule = angular.module('TechGrindApp.plugins.menu.accordion', []);

	appModule.controller('MenuAccordionCtrl', ['$scope', '$rootScope', '$routeParams', '$http', '$location', 'localStorageService', 'GuidesSharedData', 'DocsSharedData',
	function($scope, $rootScope, $routeParams, $http, $location, localStorageService,GuidesSharedData,DocsSharedData) {

		var listOfCatFromJson = null;
		// lets find were we are in the app
		var lokky = $location.$$url.split('/')[2];
		//var lokky = sharedData;
		
		//lets verify we havent save the information into localstorage
		var menuSaved = localStorageService.get(lokky+'Menu');
		if(!!!menuSaved){
			if(lokky == 'docs'){
				//listOfCatFromJson = $http.get('/json/docs_menu.json');
				listOfCatFromJson = $http.get('http://dev-back1.techgrind.asia/scripts/rest.pike?request=/home/techgrind/resources/docs/tree');
				
			}else if(lokky == 'guides'){
				//listOfCatFromJson = $http.get('/json/guides_menu.json');
				listOfCatFromJson = $http.get('http://dev-back1.techgrind.asia/scripts/rest.pike?request=/home/techgrind/resources/guides/tree');
			}
			
			listOfCatFromJson.success(function(data){
				console.log('Data for menu...', data.inventory);
				$scope.menuItems = data.inventory;
				localStorageService.add(lokky+'Menu', JSON.stringify(data.inventory));
				
				$scope.selectedCat = $scope.menuItems[0].oid;
				updateIOActive($scope.menuItems[0].path, $scope.menuItems[0].title);
			});
		}else{
			$scope.menuItems = JSON.parse(menuSaved);
			$scope.selectedCat = $scope.menuItems[0].oid;
			updateIOActive($scope.menuItems[0].path, $scope.menuItems[0].title);
		}

		$scope.modifyUrl = function(item){
			$scope.selectedList = item.oid;
			updateIOActive(item.path, item.title);
//			console.log('$scope.selectedCat: ',$scope.selectedCat);
//			console.log('$scope.selectedList: ',$scope.selectedList);
		};
		$scope.selectCat = function(item){
			$scope.selectedList = null;
			if(item.oid != $scope.selectedCat && !item.open){
				$scope.selectedCat = item.oid;
				$.each($scope.menuItems, function(k,v){
					v.open = false;
				});
				item.open = true;
			} else if(item.oid == $scope.selectedCat && !item.open){
				item.open = true;
			} else {
				item.open = false;
			}

			updateIOActive(item.path, item.title);
//			console.log('$scope.selectedCat: ',$scope.selectedCat);
//			console.log('$scope.selectedList: ',$scope.selectedList);
		};

		$scope.selectedSubCat = -666;
		$scope.selectSubCat = function(item){

			if(item.oid != $scope.selectedSubCat && !item.open){
				$scope.selectedSubCat = item.oid;
				item.open = true;
			} else if(item.oid == $scope.selectedSubCat && !item.open){
				item.open = true;
			} else {
				item.open = false;
			}
			updateIOActive(item.path, item.title);
		};
		
		function updateIOActive(id, title){
			if(lokky == 'docs'){
				DocsSharedData.itemShared = {'id' : id, 'title' : title};
			}else{
				GuidesSharedData.itemShared = {'id' : id, 'title' : title};
			}
			$rootScope.$broadcast('iodActive',id);
		}

	}]);
}).call(this);
