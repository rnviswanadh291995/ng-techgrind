
# create a uploader with options
# to automatically update the html. Default: $rootScope
# first user filter

# ADDING FILTERS
# second user filter

# REGISTER HANDLERS
app = angular.module("TechGrindApp.plugins.toolsUpload", [
	"TechGrindApp.services.tools_fileUploaderFactory"
	"TechGrindApp.directives.ngFileSelect"
	"TechGrindApp.directives.ngFileOver"
	"TechGrindApp.directives.ngFileDrop"
	])
app.controller "ToolsUploadCtrl", [ "$scope", "tools_fileUploaderFactory", ($scope, $fileUploader) ->
	uploader = $scope.uploader = $fileUploader.create(
		scope: $scope
		url: "/"
		formData: [key: "value"]
		filters: [(item) ->
			console.info "filter1"
			true
		]
	)
	uploader.filters.push (item) ->
		console.info "filter2"
		true

	uploader.bind "afteraddingfile", (event, item) ->
		console.info "After adding a file", item
		return

	uploader.bind "afteraddingall", (event, items) ->
		console.info "After adding all files", items
		return

	uploader.bind "changedqueue", (event, items) ->
		console.info "Changed queue", items
		return

	uploader.bind "beforeupload", (event, item) ->
		console.info "Before upload", item
		return

	uploader.bind "progress", (event, item, progress) ->
		console.info "Progress: " + progress, item
		return

	uploader.bind "success", (event, xhr, item, response) ->
		console.info "Success", xhr, item, response
		return

	uploader.bind "error", (event, xhr, item, response) ->
		console.info "Error", xhr, item, response
		return

	uploader.bind "complete", (event, xhr, item, response) ->
		console.info "Complete", xhr, item, response
		return

	uploader.bind "progressall", (event, progress) ->
		console.info "Total progress: " + progress
		return

	uploader.bind "completeall", (event, items) ->
		console.info "All files are transferred", items
		return
]