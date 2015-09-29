var base_path = '/assets/templates/'
var app
app = angular.module('upsocl',[
  'templates',
  'ui.router',
  'ngResource',
  'upsocl.controllers',
  'upsocl.services',
  'ui.bootstrap'
])

// app.config(['$routeProvider', function($routeProvider){
//   $routeProvider
//   .when('/', { templateUrl: base_path + 'index.html.slim', controller: 'CampaignCtrl' } )
//   .when('/campaigns/:campaignId', base_path + 'show.html.slim', controller: 'CampaignCtrl')
// }])

angular.module('upsocl').config(function($stateProvider) {
  $stateProvider.state('campaigns', {
    url: '/',
    templateUrl: base_path + 'index.html.slim',
    controller: 'CampaignListController'
  }).state('viewCampaign', { //state for showing single movie
    url: '/campaigns/:id',
    templateUrl: base_path + 'show.html.slim',
    controller: 'CampaignViewController'
  })
}).run(function($state) {
  $state.go('campaigns');
});
