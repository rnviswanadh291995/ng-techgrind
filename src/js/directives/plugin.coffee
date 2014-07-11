# https://github.com/angular/angular.js/pull/1227
# <div plugin="partial.html" plugin-scope="{ name: 'Peter' }"></div>

directives = angular.module 'TechGrindApp.directives', []
directives.directive 'plugin', () ->
		scope: {}
		templateUrl: (element, attrs) ->
			attrs.plugin
		link:
			pre: (scope, element, attrs) ->
				props = scope.$eval attrs.pluginScope
				console.log props, attrs, attrs.pluginScope
				scope.sexpr = sexpr
				angular.forEach props, (value, key) ->
					console.log key, value
					scope[key] = value

