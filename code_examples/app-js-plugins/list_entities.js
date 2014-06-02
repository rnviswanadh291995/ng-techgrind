/*
	list_entities:
		display-style___________
		this list object should display elements in a vertical 1-column list with:
		* a small logo
		* name
		* type (what type of entity is it?) (can be multiple)
		* market segment / specialty (can be multiple)
		* location(s) (city/country) (can be multiple)
		
		example:
		* <tg-logo>
		* TechGrind
		* Service, Community, Incubator, Investor, Office
		* Startups, Technology, Software, Cloud
		* China, Cambodia, Singapore, Thailand, Vietnam, Malaysia, Philippines
 
		functional goal___________
		this list object should simply act as a nice wide column display grid
			with a thumbnail, allowing user to navigate to the full-profile-page
			of the displayed element.
			
		example-entity -> displayed information ==> action-on-interaction:
			investors/startups/services -> small logo thumbnail + detailed info ==> profile page
*/

// - name
// - location
// - type ( startup, investors, conworking space etc...)
// - ID for user : user.type.favorite[] 

// row 1 : Name | location
// row 2 : Type

// Pagination or inifinity scroll (download, say, 5 rows at a time)
// Add star on the right
// click at the star = fixed on top (favorite) & add that entities  user.type.favorite[] for user record
// click at the row = redirect to the start/service/investor profile page. example http://127.0.0.1:8000/#/people

(function() {

	var appModule = angular.module('TechGrindApp.controllers.list.entities', ['TechGrindApp.directives.ngErrSrc']);
 
	appModule.controller('ListEntitiesCtrl', ['$scope', 'steam', '$routeParams', '$location',
	  function($scope, steam, rp, loc) {
	 
	    var get_countries, get_country;
	    $scope.countries = {};
	    $scope.sgenome = {};
	    $scope.debug = [];
	    $scope.entities = [];

	    $scope.user = {
	    	userid: 'efraimip',
	    	favorite: []
	    };

	    $scope.goToOrganization = function(slug) {
	    	loc.path('profile/startup/' + slug);
	    }

	    $scope.userFavorite = function(organization_id) {
	    	var isFavoriteExist = $scope.user.favorite.indexOf(organization_id) != -1;
	    	if (isFavoriteExist) {
	    		$scope.user.favorite.splice($scope.user.favorite.indexOf(organization_id), 1);
	    	} else {
	    		$scope.user.favorite.push(organization_id);
	    	}
	    	$scope.entities[organization_id].favorited = ($scope.entities[organization_id].favorited) ? false : true;
	    	console.log($scope.user.favorite);
	    }

	    get_country = function(country, filter) {
	      $scope.debug.push = ["getting", country, filter];
	      if (filter) {
	        filter = "/" + filter;
	      } else {
	        filter = "";
	      }
	      return steam.get('/home/techgrind/organizations/country/' + country + filter).then(function(data) {
	        $scope.debug.push = "got " + country;
	        return $scope.entities = data.sgenome;
	      });
	    };

	    if (rp.region) {
	      return get_country(rp.region, rp.filter);
	    }

	    return $scope.entities;
	  }]);

}).call(this);
