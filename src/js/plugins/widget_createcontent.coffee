#
#	widget_createcontent:
#  display-style___________
#  * this widget is used to open up tools/services for creating new content
#
#	example___________
#	* 
#
#	functional goal___________
#  * button-dropdown-menu with type of content to create
#  * textbox area?
#
appModule = angular.module("TechGrindApp.plugins.widget.createcontent", [])
appModule.controller "WidgetCreateContent", [
  "$scope"
  "steam"
  "$http"
  ($scope, steam, http) ->
    $scope.regions = regions
]
regions = [
  "Asia-Pacific"
  "Australia"
  "Cambodia"
  "China"
  "Indonesia"
  "India"
  "Japan"
  "Korea"
  "Laos"
  "Malaysia"
  "New Zealand"
  "Philippines"
  "Singapore"
  "Thailand"
  "Vietnam"
]
