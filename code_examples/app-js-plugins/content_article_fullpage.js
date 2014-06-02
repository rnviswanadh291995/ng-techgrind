/*
	content_article_fullpage:
		display-style___________
		*
		*
		
		example:
		*
		*
 
		functional goal___________
					
		example-item -> displayed information ==> action-on-interaction:
			
*/

var appModule = angular.module('TechGrindApp.controllers.content.articles.fullpage', []);

appModule.controller('ContentArticleFullPageCtrl', ['$scope', 'steam', '$routeParams',
function($scope, steam, rp) {

	var user = null;
	var self = this;
	var article = null;
	var get_article = function(data)
	{
		if (data['article'])
		$scope.article = data['article'];
	}

	steam.get('/home/techgrind/articles/all/'+rp.name).then(get_article);

	self.isOpen = false;
	self.isLogged = false;
	self.user = steam.loginp();
	self.loginp = steam.loginp;

	$scope.user = function() {
		return self.user;
	};
	$scope.loginp = function() {
		return self.loginp;
	};

	$scope.login = function(result) {
		console.log('Trying to login...');
		$rootScope.openlogin = true;
	};
	$scope.rateThis = function(result) {
		if(loginp) {
			var jsonMsg = {
				title: this.title,
				rating: this.rating
			};
			// lets steam the information
			steam.put('rating', jsonMsg).then(function() {
				console.log('Steam put.....');
			});
		} else {
			$scope.login();
		}
	};

}]);

var contentdata = {
 	type:'news',
 	labels: ['startups','thailand','singapore'],
 	author:'Efraim Pettersson',
	source:'http://efraimip.blogspot.com',
	date:'12-03-2013',
	time:'18:06',
	twitterid:'@EfraimIP',
	websiteurl:'www.grinder.com',
	title:'Test Title....',
	content:'we rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlrwe rowaej roiwaej roiwaej roijaweo rawo hriuaw ehriuawh eriu haweiurhawilu rhw eiouqwh eiuqwh riawheiouhwe tuiohw iut hiwuae htiuawh tiuw htiuhw atil hwaelit hiweauh tiweua htiuwea htilwah tiwha  it hew woeh riweh riuha wrihaweir hilwearh iluwea hrliw aherhliwar hi ewlr',
	rating:5
	};