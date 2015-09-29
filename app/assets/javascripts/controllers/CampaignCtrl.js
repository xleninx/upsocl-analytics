// app.controller('CampaignCtrl', function( $scope, $routeParams, campaignData ) {
//
//   $scope.data = campaignData.data
//   campaignData.loadCampaings();
//
// });

angular.module('upsocl.controllers', []).controller('CampaignListController', function($scope, $state, $window, Campaign) {
  $scope.campaigns = Campaign.query();
}).controller('CampaignViewController', function($scope, $stateParams, Campaign ) {
  $scope.campaign = Campaign.get({ id: $stateParams.id });
})
