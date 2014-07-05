#
#	content_article_fullpage:
#		display-style___________
#		*
#		*
#		
#		example:
#		*
#		*
# 
#		functional goal___________
#					
#		example-item -> displayed information ==> action-on-interaction:
#			
#
appModule = angular.module("TechGrindApp.controllers.content.articles.fullpage", [])
appModule.controller "ContentArticleFullPageCtrl", [
  "$scope"
  "steam"
  "$routeParams"
  ($scope, steam, rp) ->
    user = null
    self = this
    article = null
    $scope.test = rp
    get_article = (data) ->
      $scope.article = data["article"]
      $scope.test = data

    steam.get("/home/techgrind/articles/all/" + rp.name).then get_article
    self.isOpen = false
    self.isLogged = false
    self.user = steam.loginp()
    self.loginp = steam.loginp
    $scope.user = ->
      self.user

    $scope.loginp = ->
      self.loginp

    $scope.login = (result) ->
      console.log "Trying to login..."
      $rootScope.openlogin = true
      return

    $scope.rateThis = (result) ->
      if loginp
        jsonMsg =
          title: @title
          rating: @rating

        
        # lets steam the information
        steam.put("rating", jsonMsg).then ->
          console.log "Steam put....."
          return

      else
        $scope.login()
      return
]
contentdata =
  type: "news"
  labels: [
    "startups"
    "thailand"
    "singapore"
  ]
  author: "Efraim Pettersson"
  source: "http://efraimip.blogspot.com"
  date: "12-03-2013"
  time: "18:06"
  twitterid: "@EfraimIP"
  websiteurl: "www.grinder.com"
  title: "Test Title...."
  content: "we rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlr"
  rating: 5
