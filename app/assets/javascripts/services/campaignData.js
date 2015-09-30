angular.module('upsocl.services', []).factory('Campaign', function($resource) {
  return $resource('/campaigns/:id.json');
}).factory('Url', function($resource) {
  return $resource('/urls/:id.json');
});
