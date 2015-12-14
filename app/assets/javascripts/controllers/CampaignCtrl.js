angular.module('upsocl.controllers', []).controller('CampaignListController', function($scope, $state, $window, Campaign) {
  $scope.campaigns = Campaign.query();
}).controller('CampaignUrlViewController', function($scope, $stateParams, Url) {
  $scope.date = { startDate: moment().subtract(2, "year"), endDate: moment() };
  $scope.opts = run_datepicker();
  $scope.$watch('date', function(newDate) {
    var startDate = newDate.startDate.format('YYYY-MM-DD');
    var endDate = newDate.endDate.format('YYYY-MM-DD');
      $scope.url = Url.get({ id: $stateParams.id, startDate: startDate, endDate: endDate }, function(data){
        draw_graphics($stateParams.id, data.stadistics);
        $('#daterange').data('daterangepicker').setStartDate(moment().startOf("year"));
        $('#daterange').data('daterangepicker').setEndDate(moment());
        $scope.datePicker.date = {startDate: null, endDate: null};
      });
      $('[data-toggle="tooltip"]').tooltip();
  }, false);
})
