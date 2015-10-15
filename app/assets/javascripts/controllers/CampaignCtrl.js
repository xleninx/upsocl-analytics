angular.module('upsocl.controllers', []).controller('CampaignListController', function($scope, $state, $window, Campaign) {
  $scope.campaigns = Campaign.query();
}).controller('CampaignUrlViewController', function($scope, $stateParams, Url) {
  $scope.date = { startDate: moment().subtract(7, "days"), endDate: moment() };
  $scope.opts = run_datepicker();
  $scope.$watch('date', function(newDate) {
    var startDate = newDate.startDate.format('YYYY-MM-DD');
    var endDate = newDate.endDate.format('YYYY-MM-DD');
      $scope.url = Url.get({ id: $stateParams.id, startDate: startDate, endDate: endDate }, function(data){
        draw_graphics($stateParams.id, data.stadistics);
      });
  }, false);
})
