#
#	list_calendar:
#		display-style___________
#
#		example:
# 
#		functional goal___________
#			
#		example-item -> displayed information ==> action-on-interaction:
#
#
appModule = angular.module("TechGrindApp.controllers.list.calendar", [])
appModule.controller "ListCalendarCtrl", [ "$scope", "steam", "$http", "$routeParams", ($scope, steam, http, rp) ->
      @rendercal = (msg) ->
  ]