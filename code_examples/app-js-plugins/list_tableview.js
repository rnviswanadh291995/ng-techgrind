/*
	list_tableview:
		display-style___________
		this list object should display elements in a vertical 1-column list with:
		* type
		* location (city)
		* name / abbreviation
		* date
		* time
		* price
		* {short-description}
		
		example:
		* Event
		* Thailand
		* SLAP
		* Speak, Learn, and Pitch:
		* Thursday, 21-11-2013
		*	18:00 - 22:00
		* FREE!
 
		functional goal___________
		this list object should display in a narrow/compact height+full width table-type grid.
			it should serve as a quick-information listing of actionable items and should
			send the user to a full-profile page or handling page for the item on interaction.
			
		example-item -> displayed information ==> action-on-interaction:
			investors/startups/services -> small logo thumbnail + detailed info ==> profile page
*/

var appModule = angular.module('TechGrindApp.controllers.list.tableview', []);

appModule.controller('ListEventsCtrl', ['$scope', 'steam', '$http',
function($scope, steam, http) {

	$scope.eventsData = eventsData;

	$scope.listClickLink = function(linkid) {
		document.location = '#/events/' + linkid;
	};

	/*
	$scope.filterByLocation = function(location) {
		// location can be an array or a single value
		var newData = {};
		for(i = activities.length; i < activities.length; i++) {
			if(location in activities.location) {
				newData += activities[i];
			}
		}
		$scope.gridOptions.data	= newData;
	};
	$scope.mySelections = [];
	$scope.gridOptions = {
		data: 'activities',
		columnDefs: 'cols',
		multiSelect: false,
		showGroupPanel: true,
		selectedItems: $scope.mySelections,
		afterSelectionChange: afterSelectionChangeFunc,
		plugins: [new ngGridFlexibleHeightPlugin()],
		minHeight: 600,
		//Enables or disables sorting in grid.
		enableSorting: true,		
		//To be able to have selectable rows in grid.
		enableRowSelection: true,
		//Prevent unselections when in single selection mode.
		keepLastSelected: true,
		//Enables the server-side paging feature
		enablePaging: true,
		showFooter: true,
		pagingOptions: {
			// pageSizes: list of available page sizes.
			pageSizes: [10, 25, 50], 
			//pageSize: currently selected page size. 
			pageSize: 10,
			//totalServerItems: Total items are on the server. 
			totalServerItems: 50,
			//currentPage: the uhm... current page.
			currentPage: 1
		},
		//The height of the header row in pixels.
		headerRowHeight: 30,
		//Row height of rows in grid.
		rowHeight: 30,
		//Define a row template to customize output. See github wiki for more details.
		rowTemplate: '<style>.ngRow:hover, .ngRow>*:hover { background-color:#FF871E; cursor: pointer; }</style><div ng-repeat="col in renderedColumns" ng-class="col.colIndex()" class="ngCell {{col.cellClass}}"><div class="ngVerticalBar" ng-style="{height: rowHeight}" ng-class="{ ngVerticalBarVisible: !$last }">&nbsp;</div><div ng-cell></div></div>',
		//Define a header row template for further customization. See github wiki for more details.
		headerRowTemplate: undefined,
		//Enables cell editing.
		enableCellEdit: false,
		//Enables cell selection.
		enableCellSelection: false,
		//Enable or disable resizing of columns
		enableColumnResize: false,
		//Enable or disable reordering of columns
		enableColumnReordering: false
	};
        */
/*
	$scope.updatedTab = function(tab) {
		console.log(tab);
		$scope.currentTab = tab;
		$scope.percentTabs = ($scope.currentTab+1)/$scope.tabs.length * 100;

		window.setTimeout(function(){
			$(window).resize();
			$(window).resize();
		}, 1000);
	};
*/

}]);

var eventsData = [{
		path: 'SLAP',
		type: 'Event',
		location: 'Thailand',
		name: 'Speak.Learn.And.Pitch',
		date: '18/12/2013',
		time: '18:00',
		price: 'FREE',
		descriptionshort: 'Speak.Learn.And.Pitch - Come learn to pitch with fellow startups and get an info session from a local investor!'
	}, {
		path: 'CFF',
		type: 'Workshop',
		location: 'Thailand',
		name: 'CFF',
		date: '20/12/2013',
		time: '18:00',
		price: 'FREE',
		descriptionshort: 'Coding.For.Fun -- Come code for fun!!! Learn Pike!'
	}, {
		path: 'CFF',
		type: 'Event',
		location: 'Thailand',
		name: 'CFF',
		date: '24/12/2013',
		time: '18:00',
		price: 'FREE',
		descriptionshort: 'Coding.For.Fun -- Come code for fun!!! Learn Pike!'
	}, {
		path: 'SUJ-Fair',
		type: 'Conferece',
		location: 'Singapore',
		name: 'StartupJobz Job Fair @ National University of Singapore',
		date: '27/12/2013',
		time: '18:00',
		price: 'FREE',
		descriptionshort: 'Come get a job at a startup!'
	}, {
		path: 'SLAP',
		type: 'Event',
		location: 'Philippines',
		name: 'Speak.Learn.And.Pitch',
		date: '18/12/2013',
		time: '18:00',
		price: 'FREE',
		descriptionshort: 'Speak.Learn.And.Pitch - Come learn to pitch with fellow startups and get an info session from a local investor!'
	}, {
		path: 'CFF',
		type: 'Workshop',
		location: 'Philippines',
		name: 'CFF',
		date: '20/12/2013',
		time: '18:00',
		price: 'FREE',
		descriptionshort: 'Coding.For.Fun -- Come code for fun!!! Learn Pike!'
	}, {
		path: 'CFF',
		type: 'Event',
		location: 'Philippines',
		name: 'CFF',
		date: '24/12/2013',
		time: '18:00',
		price: 'FREE',
		descriptionshort: 'Coding.For.Fun -- Come code for fun!!! Learn Pike!'
	}, {
		path: 'SUJ-Fair',
		type: 'Conferece',
		location: 'Philippines',
		name: 'StartupJobz Job Fair @ National University of Singapore',
		date: '27/12/2013',
		time: '18:00',
		price: 'FREE',
		descriptionshort: 'Come get a job at a startup!'
	}, {
		path: 'SLAP',
		type: 'Event',
		location: 'Cambodia',
		name: 'Speak.Learn.And.Pitch',
		date: '18/12/2013',
		time: '18:00',
		price: 'FREE',
		descriptionshort: 'Speak.Learn.And.Pitch - Come learn to pitch with fellow startups and get an info session from a local investor!'
	}, {
		path: 'CFF',
		type: 'Workshop',
		location: 'Cambodia',
		name: 'CFF',
		date: '20/12/2013',
		time: '18:00',
		price: 'FREE',
		descriptionshort: 'Coding.For.Fun -- Come code for fun!!! Learn Pike!'
	}, {
		path: 'CFF',
		type: 'Event',
		location: 'Cambodia',
		name: 'CFF',
		date: '24/12/2013',
		time: '18:00',
		price: 'FREE',
		descriptionshort: 'Coding.For.Fun -- Come code for fun!!! Learn Pike!'
	}, {
		path: 'SUJ-Fair',
		type: 'Conferece',
		location: 'Cambodia',
		name: 'StartupJobz Job Fair @ National University of Singapore',
		date: '27/12/2013',
		time: '18:00',
		price: 'FREE',
		descriptionshort: 'Come get a job at a startup!'
	}];
