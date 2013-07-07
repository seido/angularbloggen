'use strict';

angular.module('anblogApp')
.controller('MainCtrl', function ($scope, Posts, $rootScope, Categories) {
	$rootScope.pageTitle='TopPage';

	Posts.query(function(list){
		$scope.list = list;
	}, function(data){
		$scope.list = [{title:'err',err:data}];
	});

	Categories.query(function(list){
		$scope.categories = list;
	}, function(data){
		$scope.categories = [['ERR',data]];
	});
});
