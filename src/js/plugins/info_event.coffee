#
#  info_event:
#    functional goal___________
#    * 
#    *
#    *
#    *
#
#    display-style___________
#    * 
#    *
#    *
#    *
#
#    example:
#
appModule = angular.module("TechGrindApp.controllers.info.event", [])
appModule.controller "InfoEventCtrl", [ "$scope", "steam", "$routeParams", ($scope, steam, rp) ->
    
    # for testing purposes, need to get event info from steam
    $scope.event = {}
    $scope.newschedule = {}
    $scope.rp = rp
    
    #
    #              { title: "SLAP",
    #		tags: ["tag1", "tag2", "tag3"], 
    #                description: "Meet friends and good stuff", 
    #                schedule: [{
    #                        city: "BKK", 
    #                        address: "Asoke BTS", 
    #                        date: "2/2/14",
    #                        time: "1300", 
    #                        source: "FB"},
    #                        {
    #                        city: "ON NUT", 
    #                        address: "Silom soi 4", 
    #                        date: "3/2/14",
    #                        time: "1800", 
    #                        source: "Juan"}]
    #	};
    #
    
    # flag used for testing the display of pencil icon 
    # and editing only if user is owner of event
    $scope.owner = true
    get_event = (data) ->
      $scope.data = data
      $scope.event = data.event
      
      # keep a copy to undo changes when user cancels edit
      $scope.master = angular.copy($scope.event)
      return

    steam.get("techgrind.events." + rp.name).then get_event
    
    ###
    Clear any edits made while adding a new event.
    ###
    $scope.cancelEventEdit = ->
      $scope.reset()
      $scope.eventItem.selected = null
      return

    
    ###
    Clear any edits made if user pressed cancel.
    ###
    $scope.reset = ->
      angular.copy $scope.master, $scope.event
      return

    
    ###
    Add a new event to the schedule.
    ###
    $scope.add_schedule = ->
      handle_newschedule = (data) ->
        $scope.result = data
        $scope.cancelNewEvent()
        get_event data
        return

      steam.put("techgrind.events." + rp.name, $scope.newschedule).then handle_newschedule
      return

    $scope.update_schedule = (index, schedule) ->
      handle_update_schedule = (data) ->
        $scope.result = data
        return

      steam.post($scope.event.schedule[index].id, schedule).then handle_update_schedule
      steam.get("techgrind.events." + rp.name).then get_event
      return

    $scope.update_event = ->
      steam.post("techgrind.events." + rp.name, $scope.event).then get_event
      return

    $scope.eventItem = selected: null
    
    ###
    Event selected in schedule table.
    ###
    $scope.editEvent = (index) ->
      $scope.eventItem.selected = index
      return

    
    ###
    Clear new event form. Restores original placeholders for fields below.
    ###
    $scope.cancelNewEvent = (index) ->
      $scope.newschedule.address = null
      $scope.newschedule.city = null
      $scope.newschedule.country = null
      $scope.newschedule.date = null
      $scope.newschedule.time = null
      $scope.newschedule.source = null
      return
]

# this controller is used to create a new activity.
# using the same view: info_acitivity.html - in edit/ownership mode
appModule.controller "InfoEventCreateNewCtrl", [
  "$scope"
  "steam"
  "$http"
  "$rootScope"
  ($scope, steam, http, $rootScope) ->
]
