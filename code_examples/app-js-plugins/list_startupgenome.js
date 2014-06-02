var appModule = angular.module('TechGrindApp.controllers.list.startupgenome', []);

app.controller('StartupGenomeCtrl', ['$scope', '$routeParams', 'steam',
  function(S, rp, steam) {

    var get_countries, get_country;
    S.countries = {};
    S.sgenome = {};
    S.debug = [];

    get_country = function(country, filter) {
      S.debug.push = ["getting", country, filter];
      if (filter) {
        filter = "/" + filter;
      } else {
        filter = "";
      }
      return steam.get('/home/techgrind/organizations/country/' + country + filter).then(function(data) {
        S.debug.push = "got " + country;
        return S.sgenome[country] = data;
      });
    };

    steam.get('/home/techgrind/organizations/country').then(get_countries);
    if (rp.country) {
      return get_country(rp.country, rp.filter);
    }
  }
]);