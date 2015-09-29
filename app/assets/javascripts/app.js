
var app
app = angular.module('upsocl',[
  'templates',
  'ngRoute'
])

app.config(['$routeProvider', function($routeProvider){
  $routeProvider.when('/', { templateUrl: '/assets/templates/index.html.slim', controller: 'CampaignCtrl' } )
}])
