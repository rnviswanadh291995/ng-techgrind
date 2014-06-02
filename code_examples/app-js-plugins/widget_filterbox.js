/*
	widget_filterbox:
		display-style___________
		this widget is used as a filterbox for content on the page
		* 

	example:
		* 

	functional goal___________
		* dropdownbox with "region select" -- filtered contents should update OnSelect
		* textbox "tag it" keywords -- filtered contents should update OnKeywordAdded
			http://timschlechter.github.io/bootstrap-tagsinput/examples/
			http://aehlke.github.io/tag-it/
*/

var appModule = angular.module('TechGrindApp.plugins.widget.filterbox', []);

appModule.controller('WidgetFilterbox', ['$scope', 'steam', '$http', 'settings',
function($scope, steam, http, settings) {
	$scope.regions = regions; // list of available regions should come from the server in the future
	$scope.categories = categories;
	$scope.active_regions = settings.get('regions');
	$scope.keywords = settings.get('keywords');
}]);

var regions = [ 'Asia-Pacific', 'Australia', 'Cambodia', 'China', 'Indonesia', 'India', 'Japan', 'Korea', 'Laos', 'Malaysia', 'New Zealand', 'Philippines', 'Singapore', 'Thailand', 'Vietnam' ];

var categories = [ 'News', 'Articles', 'Guides & Tutorials', 'Photos & Videos', 'Documents' ];