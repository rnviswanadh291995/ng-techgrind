(function() {

	var appModule = angular.module('TechGrindApp.controllers.content.news', []);

	appModule.controller('ContentNewsCtrl', ['$scope', 'steam',
	function($scope, steam) {

		var newsList = [{
			title: 'How to Use ng-bind-html-safe',
			day: '20',
			month: 'june',
			tags: 'developement',
			country: 'thailand',
			owner: 'Naveen',
			articlename: 'how-to-use-ng-bind-html-safe',
			tab: 'news',
			rate: 3,
			fb: 30,
			tw: 5,
			gp: 10,
			excerpt: 'Creates a binding that will innerHTML the result of evaluating the expression into the current element The innerHTML-ed content',
			content: 'Creates a binding that will innerHTML the result of evaluating the expression into the current element. The innerHTML-ed content will not be sanitized! You should use this directive only if ngBindHtml directive is too restrictive.'
		}, {
			title: 'SSW Winner Announced',
			day: '7',
			month: 'july',
			tags: 'developement',
			country: 'singapore',
			owner: 'Naveen',
			articlename: 'ssw-winner-announced',
			tab: 'news',
			rate: 3,
			fb: 30,
			tw: 5,
			gp: 10,
			excerpt: 'Winner of SSW Bangkok, SplashPost, has received a gigantic prize ticket to Switzerland where he will pitch for $500,000 in funding from the European',
			content: 'Winner of SSW Bangkok, SplashPost, has received a gigantic prize ticket to Switzerland where he will pitch for $500,000 in funding from the European investor community and Sandbox Network.'
		}, {
			title: 'Fashion Incubator Looking for Talent',
			day: '9',
			month: 'May',
			tags: 'developement',
			country: 'vietnam',
			owner: 'Naveen',
			articlename: 'fashion-incubator',
			tab: 'news',
			rate: 2,
			fb: 30,
			tw: 5,
			gp: 10,
			excerpt: 'If you are a talented designer looking for support and infrastructure to build your own fashion brand - a group of Singapore-based women entrepreneurs',
			content: 'If you are a talented designer looking for support and infrastructure to build your own fashion brand - a group of Singapore-based women entrepreneurs are looking to help you do just that!'
		}, {
			title: 'Founder Equity Calculator',
			day: '8',
			month: 'May',
			tags: 'developement',
			country: 'india',
			owner: 'Naveen',
			articlename: 'founder-equity-calculator',
			tab: 'news',
			rate: 4,
			fb: 30,
			tw: 5,
			gp: 10,
			excerpt: 'Sorry about that everyone - meant to put this up immediately after the session over a week ago. Click here to view the founder-equity calculator',
			content: 'Sorry about that everyone - meant to put this up immediately after the session over a week ago. Click here to view the founder-equity calculator that was presented at TechGrind Co-founder dating event in April.'
		}, {
			title: 'TG Monthly Enter Singaphore',
			day: '2',
			month: 'May',
			tags: 'developement',
			country: 'singapore',
			owner: 'Naveen',
			articlename: 'tg-monthly-enter-singapore',
			tab: 'news',
			rate: 1,
			fb: 30,
			tw: 5,
			gp: 10,
			excerpt: 'To all you struggling startups in Singapore, tired of all the noise and fluff, eager to really solve problems and be part of a community',
			content: 'To all you struggling startups in Singapore, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!'
		}, {
			title: 'FAP.BKK#1, WSR, a very busy week!',
			day: '27',
			month: 'April',
			tags: 'developement',
			country: 'thailand',
			owner: 'Naveen',
			articlename: 'fap-bkk-very-busy-work',
			tab: 'news',
			rate: 4,
			fb: 30,
			tw: 5,
			gp: 10,
			excerpt: 'Thank-you everyone for a great week full of events! This last week was incredibly busy and productive for Bangkok startups.',
			content: 'Thank-you everyone for a great week full of events! This last week was incredibly busy and productive for Bangkok startups. Thanks to all who contributed and helped make TechGrind explode onto the scene with such success.'
		}, {
			title: 'Fashion Incubator Looking for Talent',
			day: '9',
			month: 'May',
			tags: 'developement',
			country: 'vietnam',
			owner: 'Naveen',
			articlename: 'fashion-incubator',
			tab: 'articles',
			rate: 3,
			fb: 30,
			tw: 5,
			gp: 10,
			excerpt: 'If you are a talented designer looking for support and infrastructure to build your own fashion brand - a group of Singapore-based women entrepreneurs',
			content: 'If you are a talented designer looking for support and infrastructure to build your own fashion brand - a group of Singapore-based women entrepreneurs are looking to help you do just that!'
		}, {
			title: 'How to Use ng-bind-html-safe',
			day: '20',
			month: 'june',
			tags: 'developement',
			country: 'thailand',
			owner: 'Naveen',
			articlename: 'how-to-use-ng-bind-html-safe',
			tab: 'news',
			rate: 3,
			fb: 30,
			tw: 5,
			gp: 10,
			excerpt: 'Creates a binding that will innerHTML the result of evaluating the expression into the current element. The innerHTML-ed content',
			content: 'Creates a binding that will innerHTML the result of evaluating the expression into the current element. The innerHTML-ed content will not be sanitized! You should use this directive only if ngBindHtml directive is too restrictive.'
		}, {
			title: 'TG Monthly Enter Singaphore',
			day: '2',
			month: 'May',
			tags: 'developement',
			country: 'singapore',
			owner: 'Naveen',
			articlename: 'tg-monthly-enter-singapore',
			tab: 'news',
			rate: 3,
			fb: 30,
			tw: 5,
			gp: 10,
			excerpt: 'To all you struggling startups in Singapore, tired of all the noise and fluff, eager to really solve problems and be part of a community',
			content: 'To all you struggling startups in Singapore, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!'
		}, {
			title: 'TG Monthly Enter Philippines',
			day: '16',
			month: 'June',
			tags: 'developement',
			country: 'philippines',
			owner: 'Narp',
			articlename: 'tg-monthly-enter-philippines',
			tab: 'news',
			rate: 3,
			fb: 30,
			tw: 5,
			gp: 10,
			excerpt: 'To all you struggling startups in Philippines, tired of all the noise and fluff, eager to really solve problems and be part of a community',
			content: 'To all you struggling startups in Philippines, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!'
		}, {
			title: 'TG Monthly Enter Malaysia',
			day: '2',
			month: 'May',
			tags: 'developement',
			country: 'malaysia',
			owner: 'Narp',
			articlename: 'tg-monthly-enter-malaysia',
			tab: 'news',
			rate: 3,
			fb: 30,
			tw: 5,
			gp: 10,
			excerpt: 'To all you struggling startups in Malaysia, tired of all the noise and fluff, eager to really solve problems and be part of a community',
			content: 'To all you struggling startups in Malaysia, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!'
		}, {
			title: 'TG Monthly Enter Indonesia',
			day: '2',
			month: 'May',
			tags: 'developement',
			country: 'indonesia',
			owner: 'Narp',
			articlename: 'tg-monthly-enter-indonesia',
			tab: 'news',
			rate: 3,
			fb: 30,
			tw: 5,
			gp: 10,
			excerpt: 'To all you struggling startups in Indonesia, tired of all the noise and fluff, eager to really solve problems and be part of a community',
			content: 'To all you struggling startups in Indonesia, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!'
		}, {
			title: 'TG Monthly Enter China',
			day: '2',
			month: 'December',
			tags: 'developement',
			country: 'china',
			owner: 'Narp',
			articlename: 'tg-monthly-enter-china',
			tab: 'news',
			rate: 3,
			fb: 30,
			tw: 5,
			gp: 10,
			excerpt: 'To all you struggling startups in China, tired of all the noise and fluff, eager to really solve problems and be part of a community',
			content: 'To all you struggling startups in China, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!'
		}, {
			title: 'TG Monthly Enter Cambodia',
			day: '2',
			month: 'May',
			tags: 'developement',
			country: 'cambodia',
			owner: 'Narp',
			articlename: 'tg-monthly-enter-cambodia',
			tab: 'news',
			rate: 3,
			fb: 30,
			tw: 5,
			gp: 10,
			excerpt: 'To all you struggling startups in Cambodia, tired of all the noise and fluff, eager to really solve problems and be part of a community',
			content: 'To all you struggling startups in Cambodia, tired of all the noise and fluff, eager to really solve problems and be part of a community supportive of eachother --- get on over to Hackerspace.SG this Saturday, May 4th!!!'
		}];

		return $scope.news = newsList;
	}
	]);
}).call(this);