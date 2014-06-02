###
The angular file upload module
@author: nerv
@version: 0.2.9.6, 2013-12-02
###
app = angular.module("TechGrindApp.directives.ngFileOver", [])

# It is attached to an element which will be assigned to a class "ng-file-over" or ng-file-over="className"
app.directive "ngFileOver", ->
  "use strict"
  link: (scope, element, attributes) ->
    scope.$on "file:addoverclass", ->
      element.addClass attributes.ngFileOver or "ng-file-over"
      return

    scope.$on "file:removeoverclass", ->
      element.removeClass attributes.ngFileOver or "ng-file-over"
      return

    return

