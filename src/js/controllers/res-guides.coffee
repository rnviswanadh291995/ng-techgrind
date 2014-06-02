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

appModule = angular.module("TechGrindApp.controllers.res-guides", [])
appModule.controller "ResourcesGuidesCtrl", [
  "$scope"
  "$location"
  "steam"
  "$filter"
  "$rootScope"
  "$http"
  "GuidesSharedData"
  "ToolsRichEditorService"
  ($scope, loc, steam, $filter, $rootScope, $http, guidesSharedData, richEditor) ->
    $scope.data = guidesSharedData.itemShared
    oldData = $scope.data.id
    $scope.$on "iodActive", (event, x) ->
      unless x is oldData
        $scope.data = guidesSharedData.itemShared
        oldData = $scope.data.id
      return

    $scope.compose = ->
      richEditor.open "guides"
]

# ---
# PUBLIC METHODS.
# ---
#		$scope.activateSection = function(id) {
#			$scope.activeTitle = $rootScope.listOfCategories[id].title;
#			console.log('ACTIVE TITLE: ', $scope.activeTitle);
#			$scope.activeId = $rootScope.listOfCategories[id].id;
#			$scope.activeDescription = $rootScope.listOfCategories[id].description;
#		}

#First we must obtain the list from steam
#TODO Steam call to obtain list of categories
#		var listOfCatFromJson = $http.get('/json/guides_menu.json');
#		listOfCatFromJson.success(function(data){
#			console.warn('data:',data);
#			$rootScope.listOfCategories = data;
#			
#			return $scope.activateSection(0);
#		});
appModule.factory "GuidesSharedData", ->
  itemShared: {}
