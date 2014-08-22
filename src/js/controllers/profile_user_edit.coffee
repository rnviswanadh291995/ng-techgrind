#
# profile_user:
# display-style___________
#   the top element should be a "user info card" spanning the width of the screen.
#     it should contain the following elements:
#   *
#   *
#   *
#   *
#
#   the bottom element should be a 2-column tab-display customized by the user,
#     with elements
# 
#   example:
#
#   functional goal___________
#   this plugin should display content cards in a "news-card" fashion, and allow simple
#     interaction via clicking on the card itself, which will send the user to
#     the full content page to view the entire article/content/guide/tutorial/etc
# 
#   example-content -> displayed information ==> action-on-interaction:
#     news/article/tutorial/guide -> detailed info ==> full-content-page
#

# 
# tab.header
# tab.type
# tab.template
# 
appModule = angular.module("TechGrindApp.controllers.profileuser.edit", [])
appModule.controller "ProfileUserEditCtrl", [
  "$scope"
  "steam"
  "$http"
  "$rootScope"
  "filterFilter"
  ($scope, steam, http, $rootScope, filterFilter) ->
    user = steam.loginp()
    loginp = steam.loginp
    isFollowing = false
    $scope.userprofile =
      userid: "efraimip"
      name: "Efraim Pettersson Ivener"
      location: "Thailand"
      link: "http://techgrind.asia/#/people/efraimip" # + userid,                                                       
      merit: 5015
      position: "Founder & CEO"
      company: "eKita"
      companylink: "http://techgrind.asia/#/startups/ekita" # + company,                                                
      bioshort: "techie, cereal entrepreneur & academic"
      biolong: "techie, cereal entrepreneur & academictechie, cereal entrepreneur & academictechie, cereal entrepreneur\
 & academictechie, cereal entrepreneur & academictechie, cereal entrepreneur & academictechie, cereal entrepreneur & ac\
ademictechie, cereal entrepreneur & academictechie, cereal entrepreneur & academic"
      github: "https://github.com/efraimip"
      portfolio: ""
      facebook: "https://www.facebook.com/efraimpettersson"
      gplus: "www.blah.com"
      twitter: "https://twitter.com/efraimip"
      linkedin: "www.blah.com"
      blogurl: "http://efraimip.blogspot.com"
      blogfeed: "http://efraimip.blogspot.com/atom.xml"
      website: "http://www.ekita.co"
      email: "blah@blah.com"
      followers: 5
      following:[
        "martinb"
        "paulo"
        "onetom"
        "khoffmann"
      ]
    
    $scope.data = {}
    handle_profilerequest = (data) ->
      console.log(sexpr("user-result",data))
      $scope.userprofile.userid = data.settings.OBJ_NAME
      $scope.userprofile.name = data.settings.USER_FULLNAME
      $scope.userprofile.email = data.settings.USER_EMAIL
      $scope.userprofile.description = data.settings.OBJ_DESC
      $scope.userprofile.techgrind = data.settings.techgrind
      $scope.maintabs = data.settings.techgrind.maintabs
      
    steam.get('settings').then handle_profilerequest
    
# list of objects                                                                                                       
    $scope.maintabs = [
      {
        name:"News & Articles"
        selected:true
      }
      {
        name:"Startups"
        selected:true
      }
      {
        name:"Investments"
        selected:true
      }
      {
        name:"Followers"
        selected:true
      }
      {
        name:"Groups"
        selected:true
      }
    ]

    $scope.sidetabs = [
      "Seeking"
      "Offering"
    ]

# selected tabs                                                                                                         
    $scope.selection = []

# helper method to get selected tabs                                                                                    
    $scope.selectedTabs = selectedTabs =->
      filterFilter $scope.maintabs,
        selected: true
#hello?

# watch maintabs for changes                                                                                            
    $scope.$watch "maintabs| filter:{selected:true}", ((nv) ->
      $scope.selection = nv.map ((tab) ->
        tab.name
      )
      return
    ), true

    $scope.followMeStart = ->
      if loginp
        $scope.isFollowing = true
      else
        $rootScope.openlogin = true
      return

    $scope.followMeStop = ->
      if loginp
        $scope.isFollowing = false
      else
        $rootScope.openlogin = true
      return

    $scope.messageMe = ->

    #Test submit button works
    #$scope.data = {}
    #handle_profileupdate = (data) ->
    #   $scope.me.fullname = data.name

    $scope.submitEdit = ->
      data =
        OBJ_DESC: $scope.userprofile.description
        USER_FULLNAME: $scope.userprofile.name
        OBJ_NAME: $scope.userprofile.userid
        USER_EMAIL: $scope.userprofile.email
        techgrind:
            maintabs: $scope.maintabs
      steam.post('settings',data).then handle_profilerequest
      console.log("Submited updated profile")                                                    
]

# popup messagebox modal and handle modalInstance message contents + sending()                                                




