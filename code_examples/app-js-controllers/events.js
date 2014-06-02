/*
	events:
		display-style___________
		*
		*
		
		example:
		*
		*
 
		functional goal___________
					
		example-item -> displayed information ==> action-on-interaction:
			
*/
var appModule = angular.module('TechGrindApp.controllers.events', []);

appModule.controller('EventsCtrl', ['$scope', '$http', 'steam',
	function(S, http, steam) {
    var allevents, get_events, list_events_by_category;
    S.events = {};
    list_events_by_category = function(events) {
      angular.forEach(events, function(item) {
        if (!(item.category in S.events))
          S.events[item.category] = []
        S.events[item.category].push(item)
      });
      return console.log(sexpr("list_events_by_category", S.events));
    };
    get_events = function(data) {
      S.data = data;
      var events = data["event-list"]
      list_events_by_category(events);
    };
    S.listClickLink = function(linkid) {
      document.location = '#/events/' + linkid;
    };

    steam.get('techgrind.events').then(get_events);

  }
]);

/* TODO: individual arrays for each type, pull from sTeam by 'type'
var meetups = [];
var workshops = [];
var conferences = [];
*/

var mockevents = [
  {
    category: 'meetup',
    location: 'Bangkok',
    name: 'World.Startup.Report',
    date: '12/34/56',
    time: '1900',
    price: 'FREE',
    description: 'blah blah come to meeee!',
    path: 'wsr'
  },
  {
    category: 'meetup',
    location: 'Bangkok',
    title: 'Speak.Learn.And.Pitch',
    date: '12/34/56',
    time: '1900',
    price: 'FREE',
    description: 'test description woierj owijrowaejr ',
    path: 'slap'
  }];

appModule.controller('CreateActivityCtrl', ['$scope', 'steam', '$location', '$routeParams',
  function(S, steam, loc, rp) {
    var handle_event;
    S.rp = rp;
    S.user = steam.user;
    S.categories = categories;
    handle_event = function(data) {
      S.data = data;
      S.event = data.event;
      return console.log(sexpr("handle_event", data));
    };
    if (rp.name) {
      console.log(sexpr("rp.name", rp));
      steam.get('techgrind.events.' + rp.name).then(handle_event);
    } else {
      S.event = {
        name: 'SHORT-NAME',
        title: 'Event Title',
        description: 'Event description',
        events: []
      };
    }
    return S.submit_event = function() {
      console.log(sexpr("submit_event", S.event));
      if (S.event.eventid) {
        return steam.post(S.event.eventid, S.event).then(handle_event);
      } else {
        return steam.put('techgrind.events', S.event).then(handle_event);
      }
    };
  }
]);


/*
	submit_event:

	functional goal___________
                * fields describing an event
                  shortname, title, description, region (optional), category, keywords
*/
appModule.controller('SubmitEvent', ['$scope', 'steam', 'settings', '$window',
    function(S, steam, settings, W) {
        S.regions = regions; // list of available regions should come from the server in the future
        S.categories = event_categories;
        S.active_regions = settings.get('regions');
        S.keywords = (settings.get('keywords')||[]).join("\n");
        S.event = {};

        S.$watch('event.name', function()
        {
            count = 0;
            if (S.event.name)
                S.testname = S.event.name.toLowerCase().replace(/[^a-z ]/g, "").trim().replace(/\s+/g, "-")
            S.event.id = S.testname
        });

        var tested_groups = {};
        S.$watch('event.id', function()
        {
            handle_group = function(data)
            {
                S.data = data;
                console.log(sexpr("userid-result", data));
                if (data.error && data.error == "request not found")
                    tested_groups[data.request] = false;
                else
                    tested_groups[data.request] = true;
            };
            if (S.event.id)
                steam.get("techgrind.events."+S.event.id).then(handle_group);
        });

        S.event_available = function(){
            console.log(sexpr("event-available", tested_groups, S.event.id, !tested_groups["techgrind.events."+S.event.id], typeof(tested_groups["techgrind.events."+S.event.id])));
            return (S.event.id &&
                typeof(tested_groups["techgrind.events."+S.event.id]) != 'undefined' && 
                !tested_groups["techgrind.events."+S.event.id])
        }
        S.event_exists = function(){
            return (typeof(tested_groups["techgrind.events."+S.event.id]) != 'undefined' && tested_groups["techgrind.events."+S.event.id])
        }

        S.$watch('keywords', function()
                             {
                                 if (S.keywords)
                                     S.event.keywords = S.keywords.split("\n");
                             });
        handle_submit = function(data)
        {
            S.result = data;
            W.location.href = '#/events/'+S.result["event-list"].name;
        }

        S.submit_event = function()
        {
            steam.put("techgrind.events", S.event).then(handle_submit);
        }
    }
]);

var regions = [ 'Asia-Pacific', 'Australia', 'Cambodia', 'China', 'Indonesia', 'India', 'Japan', 'Korea', 'Laos', 'Malaysia', 'New Zealand', 'Philippines', 'Singapore', 'Thailand', 'Vietnam' ];

var event_categories = [ { title:'Meetup', name:'meetup' },
                         { title:'Workshop', name:'workshop' },
                         { title:'Conference', name:'conference' } ];

/*
# WIP
app.controller 'EventsCtrl', ['$scope', '$location', 'steam', (S, loc, steam) ->

	S.events = {}
	allevents = []
	list_events_by_category = (category) ->
		S.events[category] = allevents.filter((item) -> item.category==category)
		console.log(sexpr("list_events_by_category", category, S.events))

	get_events = (data) ->
		S.data = data
		allevents = data.events
		list_events_by_category('event')
		list_events_by_category('workshop')
		list_events_by_category('conference')

	steam.get('techgrind.events').then(get_events)

	S.createactivity = [
		path: 'partials/createactivity.html'
	]

	S.past = [
		title: 'World.Startup.Report'
		name: 'WSR'
		path: '/events/wsr'
	]


	S.showEvent = (event) -> loc.path event.url
]

# WIP
app.controller 'CreateactivityCtrl', ['$scope', 'steam', '$location', '$routeParams', (S,steam,loc,rp) ->
	S.rp = rp
	S.user = steam.user

	S.categories = categories

	handle_event = (data) ->
		S.data = data
		S.event = data.event
		console.log(sexpr("handle_event", data))

	if rp.name
		console.log(sexpr("rp.name", rp))
		steam.get('techgrind.events.'+rp.name).then(handle_event)
	else
		S.event =
			name: 'SHORT-NAME'
			title: 'Event Title'
			description: 'Event description'
			events: []

	S.submit_event = ->
		console.log(sexpr("submit_event", S.event))
		if S.event.eventid
			steam.post(S.event.eventid, S.event).then(handle_event)
		else
			steam.put('techgrind.events', S.event).then(handle_event)

#		steam.post('event', event).then(handle_event)
#
#	S.create_eventtype = ->
#		handle_eventtype = -> (data) ->
#			S.data = data
#			S.eventtype = data.eventtype
#		steam.post('eventtype', S.eventtype).then(handle_eventtype)

]
*/
