'use strict';

angular.module('anblogApp')
  .controller('CategoryCtrl', function ($scope, Posts, $filter, $routeParams) {
	  $scope.categoryName = $routeParams.category;
	  Posts.query(function(list) {
		  $scope.list = $filter('filter')(list, {category:$scope.categoryName});
	  });
  });
