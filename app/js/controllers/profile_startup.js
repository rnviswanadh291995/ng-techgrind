/*
	profile_startup:
		display-style___________
		the top element should be a "startup info card" spanning the width of the screen.
			it should contain the following elements:
		* 
		*
		*
		*

		the bottom element should be a 2-column tab-display customized by the user,
			with elements
		
		example:
		
		functional goal___________
		this plugin should display content cards in a "news-card" fashion, and allow simple
			interaction via clicking on the card itself, which will send the user to
			the full content page to view the entire article/content/guide/tutorial/etc
			
		example-content -> displayed information ==> action-on-interaction:
			news/article/tutorial/guide -> detailed info ==> full-content-page
*/

var appModule = angular.module('TechGrindApp.controllers.profilestartup', []);

appModule.controller('ProfileStartupCtrl', ['$scope', 'steam', '$http', '$rootScope', '$location',
function($scope, steam, http, $rootScope, loc) {

	$scope.startupprofile = startupprofile;
	$scope.demo = demo;
	$scope.news = news;
	$scope.fundraising = fundraising;
	$scope.sidetabs = sidetabs;

	$scope.goToPeople = function(userid) {
    	loc.path('profile/people/' + userid);
    }

}]);

var investment = [{
	date: '26/10/2013',
	userid: 'efraimip',
	series: 'A',
	amount: '500k'
}, {
	date: '7/1/2014',
	userid: 'efraimip',
	series: 'B',
	amount: '760k'
}];

var jobs = [{
	title : 'UX Designer',
	description : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc quis ante non massa sollicitudin adipiscing. Quisque ornare lectus non tincidunt porta. Phasellus iaculis sit amet nunc eu tincidunt. In hac habitasse platea dictumst. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce eleifend quam quis est scelerisque vehicula. Donec vehicula velit felis, ut interdum felis laoreet lacinia. Mauris luctus, nunc at imperdiet sodales, nisi lorem rhoncus turpis, et mattis ligula lectus eget enim.'
}, {
	title : 'DBA',
	description : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc quis ante non massa sollicitudin adipiscing. Quisque ornare lectus non tincidunt porta. Phasellus iaculis sit amet nunc eu tincidunt. In hac habitasse platea dictumst. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce eleifend quam quis est scelerisque vehicula. Donec vehicula velit felis, ut interdum felis laoreet lacinia. Mauris luctus, nunc at imperdiet sodales, nisi lorem rhoncus turpis, et mattis ligula lectus eget enim.'
}, {
	title : 'Web Developer',
	description : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc quis ante non massa sollicitudin adipiscing. Quisque ornare lectus non tincidunt porta. Phasellus iaculis sit amet nunc eu tincidunt. In hac habitasse platea dictumst. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce eleifend quam quis est scelerisque vehicula. Donec vehicula velit felis, ut interdum felis laoreet lacinia. Mauris luctus, nunc at imperdiet sodales, nisi lorem rhoncus turpis, et mattis ligula lectus eget enim.'
}];

var startupprofile = {
	startupid: 'techgrind',
	name: 'TechGrind',
	location: 'Thailand',
	founders: ['efraimip','martinb'],
	team: ['paulo','tandavas'],
	bioshort: 'A single online platform for startups in Asia-Pacific',
	biolong: 'TechGrind is Asia\'s premier startup ecosystem. Made by startups, for startups. We are both an online and offline community with the sole focus of enabling entrepreneurs from all walks of life to succeed in building their ventures. From pitching contests, hackathons, workshops, and the strongest entrepreneurship network in Asia with global ties to the strongest networks around the world, TechGrind is all about helping people build amazing things and take ideas from concept to consumer.',
	website: 'http://techgrind.asia',
	facebook: 'https://www.facebook.com/techgrind',
	twitter: 'https://twitter.com/Tech_Grind',
	followers: 479
};
var demo = {
	title: 'TechGrind 1.0',
	description: 'TechGrind is Asia\'s premier startup ecosystem. Made by startups, for startups. We are both an online and offline community with the sole focus of enabling entrepreneurs from all walks of life to succeed in building their ventures. From pitching contests, hackathons, workshops, and the strongest entrepreneurship network in Asia with global ties to the strongest networks around the world, TechGrind is all about helping people build amazing things and take ideas from concept to consumer.'
};
var news = {
	title: 'News'
};
var fundraising = {
	investment: investment
};

var sidetabs = [{
	title: 'Jobs',
	availablejobs: jobs
}, {
	title: 'Contact'
}];

