/*
 content_articles:
 display-style___________
 this content display plugin should display "news cards" for each bit of content
 including the following information:
 * title
 * location
 * author
 * date-time
 * content-snippet
 * thumbnail (3 different sizes, can be specified as parameter, eg: 120x80, 180x120, 240x160)
 * rank (1 to 5 stars)
 * social-sharing-data (fb/gplus/twitter likes/shares/etc)

 example:
 * SSW Winner Announced!
 * Thailand
 * Karl Hoffmann
 * July 7, 18:26
 * Winner of SSW Bangkok, Splashpost, has received a gigantic prize ticket to Switzerland where ....
 * <thumbnail image>
 * 2
 * {FB:10, GP:6, TW:19}

 functional goal___________
 this plugin should display content cards in a "news-card" fashion, and allow simple
 interaction via clicking on the card itself, which will send the user to
 the full content page to view the entire article/content/guide/tutorial/etc

 example-content -> displayed information ==> action-on-interaction:
 news/article/tutorial/guide -> detailed info ==> full-content-page
 */

var appModule = angular.module('TechGrindApp.controllers.content.articles', []);

appModule.controller('ContentNewsCtrl', ['$scope', 'steam', '$routeParams', '$location',
function($scope, steam, rp, loc) {

	$scope.goToArticle = function(articleID) {
		loc.path('content/' + articleID);
	}

	var region = rp.region || "all";
	console.log(sexpr("ContentNewsCtrl", rp.region, region))
	var get_articles = function(data)
	{
		if (data['article-list'])
		$scope.articles = data['article-list'];
	}

	steam.get('/home/techgrind/articles/'+region).then(get_articles);
	/*$scope.gotoFullPage = function(id) {
		console.log(' ID TO GO: ',id);
		return fullPageService.open();
	}*/
	/*$scope.openCompose = function() {
		return richEditor.open();
	}*/

	return $scope.articles;
}]);

appModule.controller('ContentGuidesCtrl', ['$scope', 'steam', '$routeParams',
function($scope, steam, rp) {

	$scope.articles = guides;

	/*$scope.gotoFullPage = function(id) {
		console.log(' ID TO GO: ',id);
		return fullPageService.open();
	}*/
	/*$scope.compose = function() {
		return richEditor.open();
	}*/

	var goToArticle = function(articleID) {
		return document.location = '#/content/' + articleID;
	}

	return $scope.articles;
}]);

var news = [{
	id : '7834',
	title : 'How to Use ng-bind-html-safe',
	day : '20',
	month : 'june',
	tags : 'developement',
	country : 'thailand',
	owner : 'Naveen',
	articlename : 'how-to-use-ng-bind-html-safe',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'Creates a binding that will innerHTML the result of evaluating the expression into the current element The innerHTML-ed content',
	content : 'Creates a binding that will innerHTML the result of evaluating the expression into the current element. The innerHTML-ed content will not be sanitized! You should use this directive only if ngBindHtml directive is too restrictive.'
}, {
	id : '7834',
	title : 'SSW Winner Announced',
	day : '7',
	month : 'july',
	tags : 'developement',
	country : 'singaphore',
	owner : 'Naveen',
	articlename : 'ssw-winner-announced',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'Winner of SSW Bangkok, SplashPost, has received a gigantic prize ticket to Switzerland where he will pitch for $500,000 in funding from the European',
	content : 'Winner of SSW Bangkok, SplashPost, has received a gigantic prize ticket to Switzerland where he will pitch for $500,000 in funding from the European investor community and Sandbox Network.',
	url : 'news/article2',
}, {
	id : '7834',
	title : 'Fashion Incubator Looking for Talent',
	day : '9',
	month : 'May',
	tags : 'developement',
	country : 'vietnam',
	owner : 'Naveen',
	articlename : 'fashion-incubator',
	tab : 'news',
	rate : 2,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'If you are a talented designer looking for support and infrastructure to build your own fashion brand - a group of Singapore-based women entrepreneurs',
	content : 'If you are a talented designer looking for support and infrastructure to build your own fashion brand - a group of Singapore-based women entrepreneurs are looking to help you do just that!',
}, {
	id : '7834',
	title : 'Founder Equity Calculator',
	day : '8',
	month : 'May',
	tags : 'developement',
	country : 'india',
	owner : 'Naveen',
	articlename : 'founder-equity-calculator',
	tab : 'news',
	rate : 4,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'Sorry about that everyone - meant to put this up immediately after the session over a week ago. Click here to view the founder-equity calculator',
	content : 'Sorry about that everyone - meant to put this up immediately after the session over a week ago. Click here to view the founder-equity calculator that was presented at TechGrind Co-founder dating event in April.',
}, {
	id : '7834',
	title : 'TG Monthly Enter Singaphore',
	day : '2',
	month : 'May',
	tags : 'developement',
	country : 'singaphore',
	owner : 'Naveen',
	articlename : 'tg-monthly-enter-singaphore',
	tab : 'news',
	rate : 1,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'To all you struggling startups in Singapore, tired of all the noise and fluff, eager to really solve problems and be part of a community',
	content : 'To all you struggling startups in Singapore, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!',
}, {
	id : '7834',
	title : 'FAP.BKK#1, WSR, a very busy week!',
	day : '27',
	month : 'April',
	tags : 'developement',
	country : 'thailand',
	owner : 'Naveen',
	articlename : 'fap-bkk-very-busy-work',
	tab : 'news',
	rate : 4,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'Thank-you everyone for a great week full of events! This last week was incredibly busy and productive for Bangkok startups.',
	content : 'Thank-you everyone for a great week full of events! This last week was incredibly busy and productive for Bangkok startups. Thanks to all who contributed and helped make TechGrind explode onto the scene with such success.',
}, {
	id : '7834',
	title : 'Fashion Incubator Looking for Talent',
	day : '9',
	month : 'May',
	tags : 'developement',
	country : 'vietnam',
	owner : 'Naveen',
	articlename : 'fashion-incubator',
	tab : 'articles',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'If you are a talented designer looking for support and infrastructure to build your own fashion brand - a group of Singapore-based women entrepreneurs',
	content : 'If you are a talented designer looking for support and infrastructure to build your own fashion brand - a group of Singapore-based women entrepreneurs are looking to help you do just that!',
}, {
	id : '7834',
	title : 'How to Use ng-bind-html-safe',
	day : '20',
	month : 'june',
	tags : 'developement',
	country : 'thailand',
	owner : 'Naveen',
	articlename : 'how-to-use-ng-bind-html-safe',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'Creates a binding that will innerHTML the result of evaluating the expression into the current element. The innerHTML-ed content',
	content : 'Creates a binding that will innerHTML the result of evaluating the expression into the current element. The innerHTML-ed content will not be sanitized! You should use this directive only if ngBindHtml directive is too restrictive.',
}, {
	id : '7834',
	title : 'TG Monthly Enter Singaphore',
	day : '2',
	month : 'May',
	tags : 'developement',
	country : 'singaphore',
	owner : 'Naveen',
	articlename : 'tg-monthly-enter-singaphore',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'To all you struggling startups in Singapore, tired of all the noise and fluff, eager to really solve problems and be part of a community',
	content : 'To all you struggling startups in Singapore, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!',
}, {
	id : '7834',
	title : 'TG Monthly Enter Philippines',
	day : '16',
	month : 'June',
	tags : 'developement',
	country : 'philippines',
	owner : 'Narp',
	articlename : 'tg-monthly-enter-philippines',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'To all you struggling startups in Philippines, tired of all the noise and fluff, eager to really solve problems and be part of a community',
	content : 'To all you struggling startups in Philippines, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!',
}, {
	id : '7834',
	title : 'TG Monthly Enter Malaysia',
	day : '2',
	month : 'May',
	tags : 'developement',
	country : 'malaysia',
	owner : 'Narp',
	articlename : 'tg-monthly-enter-malaysia',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'To all you struggling startups in Malaysia, tired of all the noise and fluff, eager to really solve problems and be part of a community',
	content : 'To all you struggling startups in Malaysia, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!',
}, {
	id : '7834',
	title : 'TG Monthly Enter Indonesia',
	day : '2',
	month : 'May',
	tags : 'developement',
	country : 'indonesia',
	owner : 'Narp',
	articlename : 'tg-monthly-enter-indonesia',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'To all you struggling startups in Indonesia, tired of all the noise and fluff, eager to really solve problems and be part of a community',
	content : 'To all you struggling startups in Indonesia, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!'
}, {
	id : '7834',
	title : 'TG Monthly Enter China',
	day : '2',
	month : 'December',
	tags : 'developement',
	country : 'china',
	owner : 'Narp',
	articlename : 'tg-monthly-enter-china',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'To all you struggling startups in China, tired of all the noise and fluff, eager to really solve problems and be part of a community',
	content : 'To all you struggling startups in China, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!',
}, {
	id : '7834',
	title : 'TG Monthly Enter Cambodia',
	day : '2',
	month : 'May',
	tags : 'developement',
	country : 'cambodia',
	owner : 'Narp',
	articlename : 'tg-monthly-enter-cambodia',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'To all you struggling startups in Cambodia, tired of all the noise and fluff, eager to really solve problems and be part of a community',
	content : 'To all you struggling startups in Cambodia, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!'
}];

var guides = [{
	id : '7834',
	id : '7834',
	title : 'Laying the Startup Groundwork',
	day : '20',
	month : 'june',
	tags : 'developement',
	country : 'thailand',
	owner : 'Naveen',
	articlename : 'how-to-use-ng-bind-html-safe',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'Starting your own business is not just about having a dream. There are real steps to ensure your business a successful start. So what are all of the things you should consider when launching your new brainchild?',
	content : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras lacinia pulvinar mi eu egestas. Sed pharetra vestibulum blandit. Suspendisse id erat vitae orci condimentum ultricies. Nulla fringilla id sapien quis tincidunt. Nullam quis pretium turpis. Phasellus varius felis non interdum tempus. Nullam mi lacus, elementum non nunc pulvinar, posuere ullamcorper mi. Aliquam et dui ipsum.'
}, {
	id : '7834',
	title : 'Planning for a Successful Start',
	day : '7',
	month : 'july',
	tags : 'developement',
	country : 'singaphore',
	owner : 'Naveen',
	articlename : 'ssw-winner-announced',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'The old adage goes: failure to plan is a plan for failure. Your business plan does not need to be complex or convoluted, but it is necessary. If you are having a hard time pulling your plan together, our experts can help.',
	content : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras lacinia pulvinar mi eu egestas. Sed pharetra vestibulum blandit. Suspendisse id erat vitae orci condimentum ultricies. Nulla fringilla id sapien quis tincidunt. Nullam quis pretium turpis. Phasellus varius felis non interdum tempus. Nullam mi lacus, elementum non nunc pulvinar, posuere ullamcorper mi. Aliquam et dui ipsum.',
	url : 'news/article2',
}, {
	id : '7834',
	title : 'Raising Capital',
	day : '9',
	month : 'May',
	tags : 'developement',
	country : 'vietnam',
	owner : 'Naveen',
	articlename : 'fashion-incubator',
	tab : 'news',
	rate : 2,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'You\'ve got the idea and you\'ve got a plan. But you can\'t start a business without a little cold hard cash. If you have it, you can always invest your own funds, but if you\'re like most, you\'ll need a little help.',
	content : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras lacinia pulvinar mi eu egestas. Sed pharetra vestibulum blandit. Suspendisse id erat vitae orci condimentum ultricies. Nulla fringilla id sapien quis tincidunt. Nullam quis pretium turpis. Phasellus varius felis non interdum tempus. Nullam mi lacus, elementum non nunc pulvinar, posuere ullamcorper mi. Aliquam et dui ipsum.',
}, {
	id : '7834',
	title : 'Founder Equity Calculator',
	day : '8',
	month : 'May',
	tags : 'developement',
	country : 'india',
	owner : 'Naveen',
	articlename : 'founder-equity-calculator',
	tab : 'news',
	rate : 4,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'Sorry about that everyone - meant to put this up immediately after the session over a week ago. Click here to view the founder-equity calculator',
	content : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras lacinia pulvinar mi eu egestas. Sed pharetra vestibulum blandit. Suspendisse id erat vitae orci condimentum ultricies. Nulla fringilla id sapien quis tincidunt. Nullam quis pretium turpis. Phasellus varius felis non interdum tempus. Nullam mi lacus, elementum non nunc pulvinar, posuere ullamcorper mi. Aliquam et dui ipsum.',
}, {
	id : '7834',
	title : 'TG Monthly Enter Singaphore',
	day : '2',
	month : 'May',
	tags : 'developement',
	country : 'singaphore',
	owner : 'Naveen',
	articlename : 'tg-monthly-enter-singaphore',
	tab : 'news',
	rate : 1,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'To all you struggling startups in Singapore, tired of all the noise and fluff, eager to really solve problems and be part of a community',
	content : 'To all you struggling startups in Singapore, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!',
}, {
	id : '7834',
	title : 'FAP.BKK#1, WSR, a very busy week!',
	day : '27',
	month : 'April',
	tags : 'developement',
	country : 'thailand',
	owner : 'Naveen',
	articlename : 'fap-bkk-very-busy-work',
	tab : 'news',
	rate : 4,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'Thank-you everyone for a great week full of events! This last week was incredibly busy and productive for Bangkok startups.',
	content : 'Thank-you everyone for a great week full of events! This last week was incredibly busy and productive for Bangkok startups. Thanks to all who contributed and helped make TechGrind explode onto the scene with such success.',
}, {
	id : '7834',
	title : 'Fashion Incubator Looking for Talent',
	day : '9',
	month : 'May',
	tags : 'developement',
	country : 'vietnam',
	owner : 'Naveen',
	articlename : 'fashion-incubator',
	tab : 'articles',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'If you are a talented designer looking for support and infrastructure to build your own fashion brand - a group of Singapore-based women entrepreneurs',
	content : 'If you are a talented designer looking for support and infrastructure to build your own fashion brand - a group of Singapore-based women entrepreneurs are looking to help you do just that!',
}, {
	id : '7834',
	title : 'How to Use ng-bind-html-safe',
	day : '20',
	month : 'june',
	tags : 'developement',
	country : 'thailand',
	owner : 'Naveen',
	articlename : 'how-to-use-ng-bind-html-safe',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'Creates a binding that will innerHTML the result of evaluating the expression into the current element. The innerHTML-ed content',
	content : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras lacinia pulvinar mi eu egestas. Sed pharetra vestibulum blandit. Suspendisse id erat vitae orci condimentum ultricies. Nulla fringilla id sapien quis tincidunt. Nullam quis pretium turpis. Phasellus varius felis non interdum tempus. Nullam mi lacus, elementum non nunc pulvinar, posuere ullamcorper mi. Aliquam et dui ipsum.',
}, {
	id : '7834',
	title : 'TG Monthly Enter Singaphore',
	day : '2',
	month : 'May',
	tags : 'developement',
	country : 'singaphore',
	owner : 'Naveen',
	articlename : 'tg-monthly-enter-singaphore',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'To all you struggling startups in Singapore, tired of all the noise and fluff, eager to really solve problems and be part of a community',
	content : 'To all you struggling startups in Singapore, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!',
}, {
	id : '7834',
	title : 'TG Monthly Enter Philippines',
	day : '16',
	month : 'June',
	tags : 'developement',
	country : 'philippines',
	owner : 'Narp',
	articlename : 'tg-monthly-enter-philippines',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'To all you struggling startups in Philippines, tired of all the noise and fluff, eager to really solve problems and be part of a community',
	content : 'To all you struggling startups in Philippines, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!',
}, {
	id : '7834',
	title : 'TG Monthly Enter Malaysia',
	day : '2',
	month : 'May',
	tags : 'developement',
	country : 'malaysia',
	owner : 'Narp',
	articlename : 'tg-monthly-enter-malaysia',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'To all you struggling startups in Malaysia, tired of all the noise and fluff, eager to really solve problems and be part of a community',
	content : 'To all you struggling startups in Malaysia, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!',
}, {
	id : '7834',
	title : 'TG Monthly Enter Indonesia',
	day : '2',
	month : 'May',
	tags : 'developement',
	country : 'indonesia',
	owner : 'Narp',
	articlename : 'tg-monthly-enter-indonesia',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'To all you struggling startups in Indonesia, tired of all the noise and fluff, eager to really solve problems and be part of a community',
	content : 'To all you struggling startups in Indonesia, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!'
}, {
	id : '7834',
	title : 'TG Monthly Enter China',
	day : '2',
	month : 'December',
	tags : 'developement',
	country : 'china',
	owner : 'Narp',
	articlename : 'tg-monthly-enter-china',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'To all you struggling startups in China, tired of all the noise and fluff, eager to really solve problems and be part of a community',
	content : 'To all you struggling startups in China, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!',
}, {
	id : '7834',
	title : 'TG Monthly Enter Cambodia',
	day : '2',
	month : 'May',
	tags : 'developement',
	country : 'cambodia',
	owner : 'Narp',
	articlename : 'tg-monthly-enter-cambodia',
	tab : 'news',
	rate : 3,
	fb : 30,
	tw : 5,
	gp : 10,
	excerpt : 'To all you struggling startups in Cambodia, tired of all the noise and fluff, eager to really solve problems and be part of a community',
	content : 'To all you struggling startups in Cambodia, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!'
}];
