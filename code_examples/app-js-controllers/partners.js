(function() {

	var appModule = angular.module('TechGrindApp.controllers.partners', []);

	appModule.controller('PartnersCtrl', ['$scope', 'steam',
	function($scope, steam) {

		var pts = [];
		
		var partnersList = [{
			title : '3 Day Startup',
			src : 'img/logos_partners/intl_3ds.png',
			url : 'http://www.3daystartup.org'
		}, {
			title : 'Sandbox Network',
			src : 'img/logos_partners/intl_sandbox.png',
			url : 'http://www.sandbox-network.com/'
		}, {
			title : 'LeanStartupCircle',
			src : 'img/logos_partners/intl_lsc.png',
			url : 'http://www.leanstartupcircle.com/'
		}, {
			title : 'NetDNA',
			src : 'img/logos_partners/intl_netdna.png',
			url : 'http://www.netdna.com/'
		}, {
			title : 'Rackspace',
			src : 'img/logos_partners/intl_rackspace.png',
			url : 'http://www.rackspacestartups.com/'
		}, {
			title : 'TNW',
			src : 'img/logos_partners/intl_tnw.png',
			url : 'http://thenextweb.com/'
		}, {
			title : 'Startup Club',
			src : 'img/logos_partners/th_suc.png',
			url : 'http://www.startupclubhq.com'
		}, {
			title : 'StartupJobs.Asia',
			src : 'img/logos_partners/sg_startupjobs.png',
			url : 'http://www.startupjobs.asia/'
		}, {
			title : 'Dreamstake',
			src : 'img/logos_partners/intl_dreamstake.png',
			url : 'http://www.dreamstake.net/'
		}, {
			title : 'Seedcamp',
			src : 'img/logos_partners/intl_seedcamp.png',
			url : 'http://www.seedcamp.com/'
		}, {
			title : 'StartupBootcamp',
			src : 'img/logos_partners/intl_startupbootcamp.png',
			url : 'http://www.startupbootcamp.org/'
		}, {
			title : 'TiE',
			src : 'img/logos_partners/intl_tie.jpg',
			url : 'http://www.tie.org/'
		}];

		for (var i = 0; i < partnersList.length; i++) {
			if (i % 3 == 0){
				pts.push([]);
			}
			pts[pts.length - 1].push(partnersList[i]);
		}
		
		
		$scope.frmName = '';
		$scope.frmEmail = '';
		$scope.frmCountry = '';
		$scope.frmMessage = '';
		
		$scope.send = function() {
			console.log('some day this will be done....');
		}; 


		return $scope.partners = pts;
	}
	]);

}).call(this);
