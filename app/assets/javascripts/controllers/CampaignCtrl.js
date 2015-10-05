angular.module('upsocl.controllers', []).controller('CampaignListController', function($scope, $state, $window, Campaign) {
  $scope.campaigns = Campaign.query();
}).controller('CampaignUrlViewController', function($scope, $stateParams, Url) {
  $scope.url = Url.get({ id: $stateParams.id });
  show_country($stateParams.id);
})
