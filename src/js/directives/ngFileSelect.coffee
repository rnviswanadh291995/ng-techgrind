###
The angular file upload module
@author: nerv
@version: 0.2.9.5, 2013-12-02
###
app = angular.module("TechGrindApp.directives.ngFileSelect", [])

# It is attached to <input type="file"> element like <ng-file-select="options">
app.directive "ngFileSelect", [
  "tools_fileUploaderFactory"
  ($fileUploader) ->
    "use strict"
    return link: (scope, element, attributes) ->
      $fileUploader.hasHTML5 or element.removeAttr("multiple")
      element.bind "change", ->
        scope.$emit "file:add", (if @files then @files else this), scope.$eval(attributes.ngFileSelect)
        $fileUploader.hasHTML5 and element.prop("value", null)
        return

      return
]
