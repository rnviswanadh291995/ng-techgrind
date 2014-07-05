# comments:

# including the following information:
# * title
# * location
# * author
# * date-time
# * ...

appModule = angular.module("TechGrindApp.controllers.content.comments", [])
appModule.controller "CommentCtrl", [ "$scope", "steam", "$routeParams", "$location", ($scope, steam, rp, loc) ->

    get_comments = (data) ->
      $scope.comments = data["annotations"][0]["annotations"]
      if $scope.comments.length == 0
          steam.get("/home/techgrind/annotations").then get_comments
      $scope.data = data
      $scope.debug = [ rp, loc ]

    $scope.send_reply = (c) ->
        $scope.debug = c
        steam.put(c.path + "/annotations", c.reply).then get_comments

    # we need to put our location here:
    steam.get("/home/techgrind/articles/all/" + rp.name + "/annotations").then get_comments
]

# register here: https://dev-back1.techgrind.asia/register/register.html
# add comments here: 
# https://dev-back1.techgrind.asia:444/scripts/navigate.pike?object=971&type=annotations
