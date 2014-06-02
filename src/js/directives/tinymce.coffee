
###
Binds a TinyMCE widget to <textarea> elements.
###

# generate an ID if not present

# Update model when calling setContent (such as from the source editor popup)

# Update model on button click

# Update model on keypress

# Update model on change, i.e. copy/pasted text, plugins altering content

# extend options with initial uiTinymceConfig and options from directive attribute value
(->
  angular.module("TechGrindApp.directives.ui.tinymce", []).value("uiTinymceConfig", {}).directive "uiTinymce", [
    "uiTinymceConfig"
    (uiTinymceConfig) ->
      uiTinymceConfig = uiTinymceConfig or {}
      generatedIds = 0
      return (
        require: "ngModel"
        link: (scope, elm, attrs, ngModel) ->
          expression = undefined
          options = undefined
          tinyInstance = undefined
          updateView = ->
            ngModel.$setViewValue elm.val()
            scope.$apply()  unless scope.$root.$$phase
            return

          attrs.$set "id", "uiTinymce" + generatedIds++  unless attrs.id
          if attrs.uiTinymce
            expression = scope.$eval(attrs.uiTinymce)
          else
            expression = {}
          options =
            setup: (ed) ->
              args = undefined
              ed.on "init", (args) ->
                ngModel.$render()
                return

              ed.on "ExecCommand", (e) ->
                ed.save()
                updateView()
                return

              ed.on "KeyUp", (e) ->
                ed.save()
                updateView()
                return

              ed.on "SetContent", (e) ->
                unless e.initial
                  ed.save()
                  updateView()
                return

              if expression.setup
                scope.$eval expression.setup
                delete expression.setup
              return

            mode: "exact"
            elements: attrs.id

          angular.extend options, uiTinymceConfig, expression
          setTimeout ->
            tinymce.init options
            return

          ngModel.$render = ->
            tinyInstance = tinymce.get(attrs.id)  unless tinyInstance
            tinyInstance.setContent ngModel.$viewValue or ""  if tinyInstance
            return

          return
      )
  ]
  return
).call this
