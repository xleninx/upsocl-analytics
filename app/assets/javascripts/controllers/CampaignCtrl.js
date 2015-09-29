app.controller('CampaignCtrl', function( $scope, $routeParams, campaignData ) {

  $scope.data = campaignData.data
  campaignData.loadCampaings();

});
