angular.module('upsocl.services', []).factory('Campaign', function($resource) {
  return $resource('/campaigns/:id.json');
});

// [
//   '$http', function($http) {
//     var campaignData;
//
//     campaignData = {
//       data: {
//         campaigns: []
//       },
//       isLoaded: false
//     };
//
//     campaignData.loadCampaings = function() {
//       return $http.get('/campaigns.json').success(function(data) {
//         campaignData.data.campaigns = data;
//         return console.log('Successfully loaded posts.');
//       }).error(function() {
//         return console.error('Failed to load posts.');
//       });
//     };
//     return campaignData;
//   }
// ]
