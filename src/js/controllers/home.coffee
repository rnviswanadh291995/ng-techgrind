#
#	home:
#		display-style___________
#		*
#		*
#		
#		example:
#		*
#		*
# 
#		functional goal___________
#					
#		example-item -> displayed information ==> action-on-interaction:
#			
#
appModule = angular.module("TechGrindApp.controllers.home", [])

appModule.controller 'HomeCtrl', ['$scope', '$http', 'ToolsRichEditorService', (S, http, richEditor) ->
	S.compose = ->
		richEditor.open()

	S.tabCalendarSelect = ->
		$('#calendar').fullCalendar 'render'
]

