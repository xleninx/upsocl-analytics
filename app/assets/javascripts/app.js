var base_path = '/assets/templates/'
var app
app = angular.module('upsocl',[
  'templates',
  'ui.router',
  'ngResource',
  'upsocl.controllers',
  'upsocl.services',
  'daterangepicker'
])

angular.module('upsocl').config(function($stateProvider) {
  $stateProvider.state('campaigns', {
    url: '/',
    templateUrl: base_path + 'index.html.slim',
    controller: 'CampaignListController'
  }).state('viewCampaignUrl', { //state for showing single movie
    url: '/campaign/urls/:id',
    templateUrl: base_path + 'show.html.slim',
    controller: 'CampaignUrlViewController'
  })
}).run(function($state) {
  $state.go('campaigns');
});
