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
    templateUrl: 'index_view',
    controller: 'CampaignListController'
  }).state('viewCampaignUrl', { //state for showing single movie
    url: '/campaign/urls/:id',
    templateUrl: 'show_view',
    controller: 'CampaignUrlViewController'
  })
}).run(function($state) {
  $state.go('campaigns');
});
