(function() {

	var appModule = angular.module('TechGrindApp.controllers.social.facebookgroup', []);

	appModule.controller('SocialFacebookGroupCtrl', ['$scope', 'steam',
	function($scope, steam) {

		var fbAccessToken = 'CAACEdEose0cBAOGDpUGu6jvFBkuibxGrHEPEgvDkVEPaomUw1FPMjRbJ408vNYsWiiUSyCfDx3C9cxtM22eph3aokhHc0L02JzwKPnldUN1T3SZBuuTtGI582ahKDgGivN421JINwiygtQGZA62Owc7rlpiPR8cNZA1QZCjeuYcMAMsW8NjYgLbuJrdIMPJgQlsHrmGOnwZDZD';
		var data = http.get('https://graph.facebook.com/153371304826505/feed?limit=5&access_token=' + fbAccessToken);

		return $scope.facebookFeed = data;
	}
	]);

}).call(this);

