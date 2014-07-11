###
# 
# 	File: <name>
# 		Define file purpose: "What does this file do??? Why does it exist???"
# 
# 	Class: <name>
# 		Is this a class/object? Define its purpose: its "persona" or "role"
# 		Define its structure: what data elements, methods, etc does it need?
# 
# 	Function: <name>
# 		Is this a function? Define its purpose.
# 		Here's an example, lets say its a multiply function...
# 		Parameters/Inputs:
# 			x - The first integer.
# 		 	y - The second integer.
# 		Returns/Outputs:
# 		 	The two integers multiplied together.
# 		Example/Usage:
# 			var x = <functionName>(a,b);
# 			input.print tostring(x);
# 		 
# 	See Also:
#  		links? another file? function? webpage tutorial?
# 		anything else that can help me understand this file overall? 
# 
###

# http://docs.angularjs.org/guide/module
# http://docs.angularjs.org/api/angular.module
app = angular.module 'TechGrindApp', [
	'TechGrindApp.filters'
	'TechGrindApp.services'
	'TechGrindApp.directives'
	'TechGrindApp.directives.lazy-loading-img'
	'TechGrindApp.directives.ui.tinymce'
	'TechGrindApp.controllers'
	#'TechGrindApp.controllers.home' # this needs to be added, and translated from coffee to native-js
	'TechGrindApp.controllers.events'
	'TechGrindApp.controllers.res-jobs'
	'TechGrindApp.controllers.res-docs'
	'TechGrindApp.controllers.res-guides'
	'TechGrindApp.controllers.res-media'
	'TechGrindApp.controllers.res-teamspeak'
	'TechGrindApp.controllers.profileuser'
	'TechGrindApp.controllers.profilestartup'
	'TechGrindApp.controllers.content.articles'
	'TechGrindApp.controllers.content.articles.fullpage'
	'TechGrindApp.controllers.content.docbrowser'
	'TechGrindApp.controllers.content.mediabrowser'
	'TechGrindApp.controllers.list.tableview'
	'TechGrindApp.controllers.list.entities'
	'TechGrindApp.controllers.info.event'
	'TechGrindApp.plugins.menu.accordion'
	'TechGrindApp.plugins.widget.filterbox'
	'ui.bootstrap'
	'ngRoute'
	'LocalStorageModule'
	'ToolsRichEditor'
]

# give usage example for setting up a route, explain where each of these components goes and what it does
# eg: how do i make a route for a dynamic link? what does :name do in a link or path?
app.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->

# GENERAL FUNCTION PAGES
	$routeProvider.when '/register',
		templateUrl: 'partials/register.html'
		controller: 'RegisterCtrl'
	
	$routeProvider.when '/login',
		templateUrl: 'partials/login.html'
		controller: 'LoginCtrl'

	$routeProvider.when '/login/:userid',
		templateUrl: 'partials/login.html'
		controller: 'LoginCtrl'

	$routeProvider.when '/activate/:userid/:activationcode',
		templateUrl: 'partials/activation.html'
		controller: 'ActivationCtrl'

# MAIN MENU PAGES
	$routeProvider.when '/home',
		templateUrl: 'partials/home.html'
		controller: 'HomeCtrl'

	$routeProvider.when '/home/:category',
		templateUrl: 'partials/home.html'
		controller: 'HomeCtrl'

	$routeProvider.when '/events',
		templateUrl: 'partials/events.html'
		controller: 'EventsCtrl'

	$routeProvider.when '/resources/jobs',
		templateUrl: 'partials/res-jobs.html'
		controller: 'ResourcesJobsCtrl'

	$routeProvider.when '/resources/docs',
		templateUrl: 'partials/res-docs.html'
		controller: 'ResourcesDocsCtrl'

	$routeProvider.when '/resources/guides',
		templateUrl: 'partials/res-guides.html'
		controller: 'ResourcesGuidesCtrl'

	$routeProvider.when '/resources/media',
		templateUrl: 'partials/res-media.html'
		controller: 'ResourcesMediaCtrl'

	$routeProvider.when '/resources/media/:cat',
		templateUrl: 'partials/res-media.html'
		controller: 'ResourcesMediaCtrl'

	$routeProvider.when '/resources/teamspeak',
		templateUrl: 'partials/res-teamspeak.html'
		controller: 'ResourcesTeamSpeakCtrl'

## EVENTS
	$routeProvider.when '/events/new',
		templateUrl: 'partials/plugins/info_event.html'
		controller: 'InfoEventCreateNewCtrl'

	$routeProvider.when '/events/:name',
		templateUrl: 'partials/plugins/info_event.html'
		controller: 'InfoEventCtrl'

## CONTENT
	$routeProvider.when '/content/:name',
		templateUrl: 'partials/plugins/content_article_fullpage.html'
		controller: 'ContentArticleFullPageCtrl'

## PROFILE PAGES
	$routeProvider.when '/profile/people',
		templateUrl: 'partials/info_userprofile.html'
		controller: 'ProfileUserCtrl'

	$routeProvider.when '/profile/people/:userid',
		templateUrl: 'partials/info_userprofile.html'
		controller: 'ProfileUserCtrl'

	$routeProvider.when '/profile/startups',
		templateUrl: 'partials/controller/info_startupprofile.html'
		controller: 'ProfileStartupCtrl'

	$routeProvider.when '/profile/startups/:startupid',
		templateUrl: 'partials/controller/info_startupprofile.html'
		controller: 'ProfileStartupCtrl'

	$routeProvider.when '/profile/investors',
		templateUrl: 'partials/controller/info_investorprofile.html'
		controller: 'ProfileInvestorCtrl'

	$routeProvider.when '/profile/investors/:investorid',
		templateUrl: 'partials/controller/info_investorprofile.html'
		controller: 'ProfileInvestorCtrl'

	$routeProvider.when '/profile/services',
		templateUrl: 'partials/controller/info_serviceprofile.html'
		controller: 'ProfileServicesCtrl'

	$routeProvider.when '/profile/services/:serviceid',
		templateUrl: 'partials/controller/info_serviceprofile.html'
		controller: 'ProfileServicesCtrl'

	$routeProvider.when '/profile/spaces',
		templateUrl: 'partials/controller/info_spaceprofile.html'
		controller: 'ProfileSpacesCtrl'

	$routeProvider.when '/profile/spaces/:spaceid',
		templateUrl: 'partials/controller/info_spaceprofile.html'
		controller: 'ProfileSpacesCtrl'

	$routeProvider.when '/profile/community',
		templateUrl: 'partials/controller/info_communityprofile.html'
		controller: 'ProfileCommunityCtrl'

	$routeProvider.when '/profile/community/:communityid',
		templateUrl: 'partials/controller/info_communityprofile.html'
		controller: 'ProfileCommunityCtrl'

############### WIPs: incomplete/tests
## SGENOME TEST
	$routeProvider.when '/sgenome',
		templateUrl: 'partials/sgenome.html'
		controller: 'StartupGenomeCtrl'

	$routeProvider.when '/sgenome/:country',
		templateUrl: 'partials/sgenome.html'
		controller: 'StartupGenomeCtrl'

	$routeProvider.when '/sgenome/:country/:filter',
		templateUrl: 'partials/sgenome.html'
		controller: 'StartupGenomeCtrl'

## ADMIN AREA
	$routeProvider.when '/admin',
		templateUrl: 'partials/admin.html'
		controller: 'AdminCtrl'

# OTHERWISE
	$routeProvider.otherwise redirectTo: '/home'
]
