###
Watch for an error loading image and replace it with a placeholder image
@author: thanakron
@version: 0.1
###
app = angular.module("TechGrindApp.directives.ngErrSrc", [])
app.directive "errSrc", ->
  link: (scope, element, attrs) ->
    element.bind "error", ->
      element.attr "src", attrs.errSrc
      return

    return

