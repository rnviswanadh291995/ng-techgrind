###
The angular file upload module
@author: nerv
@version: 0.2.9.5, 2013-12-02
###
app = angular.module("TechGrindApp.directives.ngFileDrop", [])

# It is attached to an element that catches the event drop file
app.directive "ngFileDrop", [
  "tools_fileUploaderFactory"
  ($fileUploader) ->
    "use strict"
    
    # don't use drag-n-drop files in IE9, because not File API support
    return link: (if not $fileUploader.hasHTML5 then angular.noop else (scope, element, attributes) ->
      # jQuery fix;
      # jQuery fix;
      element.bind("drop", (event) ->
        dataTransfer = (if event.dataTransfer then event.dataTransfer else event.originalEvent.dataTransfer)
        event.preventDefault()
        event.stopPropagation()
        scope.$broadcast "file:removeoverclass"
        scope.$emit "file:add", dataTransfer.files, scope.$eval(attributes.ngFileDrop)
        return
      ).bind("dragover", (event) ->
        dataTransfer = (if event.dataTransfer then event.dataTransfer else event.originalEvent.dataTransfer)
        event.preventDefault()
        event.stopPropagation()
        dataTransfer.dropEffect = "copy"
        scope.$broadcast "file:addoverclass"
        return
      ).bind "dragleave", ->
        scope.$broadcast "file:removeoverclass"
        return

      return
    )
]
