# this is a
# default
# value
# which can
# get
# modified
# later

#self.dialogCategories = ['news','guides','tutorials'];

# lets check if the user is logged

#open main modal window
#We need to pass this values from scope into modal has required by Angular-UI

#				$scope.initCat = function() {
#					return $scope.selectedCategory;
#				}

# lets steam the information

# lets steam the information
(->
  app = angular.module("ToolsRichEditor", [
    "ui.bootstrap"
    "TechGrindApp.directives.ui.tinymce"
  ])
  app.service "ToolsRichEditorService", [
    "$modal"
    "steam"
    "$rootScope"
    "$http"
    ($modal, steam, $rootScope, $http) ->
      self = this
      self.isOpen = false
      self.isLogged = false
      self.user = steam.loginp()
      self.loginp = steam.loginp
      self.tinymceOptions =
        selector: "#inputContentRichText"
        plugins: [
          "advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker"
          "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking"
          "save table contextmenu directionality emoticons template paste textcolor"
        ]
        width: "100%"
        height: 310
        browser_spellcheck: true
        statusbar: false
        menubar: false
        paste_as_text: true
        toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | link image media | bullist | forecolor backcolor"
        charLimit: 1000000

      self.tinymce = "Write your own article, news, or tutorial and publish it now!"
      self.labels = ""
      self.dialogCategories = []
      listOfCatFromJson = $http.get("http://dev-back1.techgrind.asia/scripts/rest.pike?request=/home/techgrind/resources/guides/tree")
      self.location = []
      listOfCatFromJson.success (data) ->
        console.log "Data for menu...", data.inventory
        $.each data.inventory, (k0, v0) ->
          self.location.push v0.name
          $.each v0.inventory, (k1, v1) ->
            self.location.push "::::" + v1.name
            $.each v1.inventory, (k2, v2) ->
              self.location.push "::::::::" + v2.name
              return

            return

          return

        return

      user = null
      @open = (startCat) ->
        console.log "Starting Category: ", startCat
        unless self.isOpen
          unless !!startCat
            self.startCat = "news"
          else
            self.startCat = startCat
          if self.startCat is "news"
            self.dialogCategories = ["news"]
          else
            self.dialogCategories = [
              "guides"
              "tutorials"
            ]
          self.isOpen = true
          self.user = steam.loginp()
          self.loginp = steam.loginp
          modalInstance = $modal.open(
            backdrop: false
            keyboard: false
            backdropClick: true
            dialogFade: true
            templateUrl: "partials/services/tools_richeditor.html"
            controller: ModalInstanceCtrl
            windowClass: "modal myWindow"
            resolve:
              dialogCategories: ->
                self.dialogCategories

              locations: ->
                self.location

              user: ->
                self.user

              loginp: ->
                self.loginp

              tinymce: ->
                self.tinymce

              tinymceOptions: ->
                self.tinymceOptions

              labels: ->
                self.labels

              initCat: ->
                self.startCat
          )
          modalInstance.result.then (selectedItem) ->
            console.log "Modal dismissed at: " + new Date()
            self.isOpen = false
            return

          modalInstance.opened.then (selectedItem) ->
            console.log "modal opened"
            return

        return

      ModalInstanceCtrl = ($scope, $modalInstance, dialogCategories, locations, user, loginp, tinymce, tinymceOptions, labels, initCat) ->
        $scope.dialogCategories = dialogCategories
        $scope.selectedCategory = initCat
        $scope.initCat = $scope.selectedCategory
        $scope.user = user
        $scope.loginp = loginp
        $scope.tinymceOptions = tinymceOptions
        $scope.tinymce = tinymce
        $scope.labels = labels
        $scope.locations = locations
        $scope.selectedLocation = locations[0]
        $scope.close = (result) ->
          try
            $modalInstance.close()
          catch e
            console.warn "Update bootstrap librarie to get ride of the error"
          return

        $scope.login = (result) ->
          console.log "Trying to login..."
          $rootScope.openlogin = true
          return

        $scope.save = (result) ->
          jsonMsg =
            title: @title
            fullText: @tinymce
            labels: @labels
            category: @selectedCategory

          steam.put("news", jsonMsg).then ->
            console.log "Steam put....."
            return

          return

        $scope.post = ->
          jsonMsg =
            title: @title
            fullText: @tinymce
            labels: @labels
            category: @selectedCategory

          steam.post("news", jsonMsg).then ->
            console.log "Steam post....."
            try
              $modalInstance.close()
            catch e
              console.warn "Update bootstrap librarie to get ride of the error"
            return

          return

        return
  ]
  return
).call this
