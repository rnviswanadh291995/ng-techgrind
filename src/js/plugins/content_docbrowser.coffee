#
#	content_docbrowser:
#		display-style___________
#		this content display plugin should display a file-browser-like window.
#			it should have a breadcrumb navigation added to it so that users can
#			smartly navigate up and down a category tree.
#			both individual files/objects can be viewed in one container as well as
#			categories (eg: folders).
#			these should be all displayed as small thumbnails with the following info:
#		* <thumbnail:filetype> (eg: folder, PDF, word-doc, image, source-code, office-document)
#		* name
#		* author [does not show on "folders/categories"]
#		* rank (1 to 5 stars) [does not show on "folders/categories"]
#		
#		example folder:
#		* <image:folder>
#		* Legal Templates
#
#		example doc:
#		* <image:PDF>
#		* NDA - Harvard-Business-School
#		* HBS Administration Team
#		* 5
#		
#		example office-document:
#		* <image:calc-sheet>
#		* Founder Equity Calculator
#		* Efraim Pettersson
#		* 4
#		
#		functional goal___________
#		this plugin should display objects in a filebrowser-like-fashion.
#			user interacts with plugin im similar fashion as a file-browser.
#			clicking on a folder, takes user to another sub-category.
#			breadcrumb navigation is maintained in the navigation bar at top of plugin.
#			when user clicks on file/doc/object, user should have the option to download, or open.
#			the "open" button should be grayed out, if it is an object-type we do not have an application
#			on the website to open the object with. eg: .psd file (needs photoshop, and we dont have it on
#			the website).
#			
#		example-object -> displayed information ==> action-on-interaction:
#			doc/template/file -> object thumbnail + name ==> full-content-view // download to user
#

# I control the root of the application.

#lets start with level list

#lets be on watch for broadcast from menuAccordion

#TODO we wanrt to call steam to delete here

#call controller to upload
(->
  app = angular.module("TechGrindApp.controllers.content.docbrowser", ["TechGrindApp.plugins.toolsUpload"])
  app.controller "ContentDocsCtrl", [
    "$scope"
    "$location"
    "steam"
    "$routeParams"
    "$http"
    "DocsSharedData"
    ($scope, loc, steam, $routeParams, $http, DocsSharedData) ->
      callHttpForListOfFiles = ->
        listOfCatFromJson = $http.get("http://dev-back1.techgrind.asia/scripts/rest.pike?request=/" + $scope.data.id)
        listOfCatFromJson.success (data) ->
          console.log "Data for menu...", data.inventory
          $scope.docs = data.inventory
          return

        return
      $scope.data = DocsSharedData.itemShared
      oldData = $scope.data.id
      callHttpForListOfFiles()
      $scope.level = "list"
      $scope.$on "iodActive", (event, x) ->
        unless x is oldData
          $scope.docs = []
          $scope.data = DocsSharedData.itemShared
          oldData = $scope.data.id
          isMylistActivated = false
          callHttpForListOfFiles()
        return

      isMylistActivated = false
      $scope.myListActivated = ->
        isMylistActivated

      $scope.myList = ->
        $scope.docs = tempListMyFiles
        $scope.data = title: "Your files uploaded"
        oldData = -1
        isMylistActivated = true
        return

      $scope.modifiUrlForSrc = (path) ->
        "http://dev-back1.techgrind.asia/" + path

      $scope.itemActive = {}
      $scope.gotoView = (doc) ->
        console.log "view item id: ", doc.oid
        $scope.level = "view"
        $scope.itemActive = doc
        return

      $scope.goBackToList = ->
        $scope.level = "list"
        return

      $scope.deleteFile = (doc, $event) ->
        console.log "Lets delete the doc oid: ", doc.oid
        $event.stopPropagation()
        return

      $scope.downloadFile = (doc, $event) ->
        $event.stopPropagation()
        window.open "http://dev-back1.techgrind.asia" + doc.path
        return

      $scope.modifySizesForKb = (size) ->
        Math.round size / 1024

      $scope.uploadFiles = ->
        $scope.level = "upload"
        return

      tempListMyFiles = [
        {
          oid: 6078
          mime_type: "application/msword"
          class: "Document"
          path: "/home/techgrind/resources/docs/product-development/technology/backend-stacks/No way we can miss this.doc"
          name: "No way we can miss this.doc"
          title: ""
          size: 17920
        }
        {
          oid: 6079
          mime_type: "application/msword"
          class: "Document"
          path: "/home/techgrind/resources/docs/product-development/technology/backend-stacks/piece of information.doc"
          name: "piece of information.doc"
          title: ""
          size: 17920
        }
      ]
  ]
  return
).call this
