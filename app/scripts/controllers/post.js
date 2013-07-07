'use strict';

angular.module('anblogApp')
.controller('PostCtrl', function ($scope, $rootScope, $route, $routeParams, PostMeta, $location) {
	$rootScope.pageTitle = '';
	$scope.postid = $routeParams.postid;
	$scope.myurl = $location.absUrl();
	PostMeta.get({postid:$scope.postid},function(data) {
		$rootScope.pageTitle = data.title;
		$scope.url = data.url;
		$scope.meta = data;
	},function(err){
		console.log(err);
	});
});
