appModule = angular.module("TechGrindApp.controllers.list.startupgenome", [])
app.controller "StartupGenomeCtrl", [
  "$scope"
  "$routeParams"
  "steam"
  (S, rp, steam) ->
    get_countries = undefined
    get_country = undefined
    S.countries = {}
    S.sgenome = {}
    S.debug = []
    get_country = (country, filter) ->
      S.debug.push = [
        "getting"
        country
        filter
      ]
      if filter
        filter = "/" + filter
      else
        filter = ""
      steam.get("/home/techgrind/organizations/country/" + country + filter).then (data) ->
        S.debug.push = "got " + country
        S.sgenome[country] = data


    steam.get("/home/techgrind/organizations/country").then get_countries
    return get_country(rp.country, rp.filter)  if rp.country
]
