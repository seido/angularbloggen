'use strict';

angular.module('anblogApp', ['postServices'])
  .config(['$routeProvider', '$locationProvider', function ($routeProvider, $locationProvider) {
	  //$locationProvider.html5Mode(true).hashPrefix('!');
	  $locationProvider.hashPrefix('!');
	  $routeProvider
	  .when('/', {
		  templateUrl: '/views/main.html',
		  controller: 'MainCtrl'
	  })
	  .when('/post/:postid/', {
		  templateUrl: '/views/post.html',
		  controller: 'PostCtrl'
	  })
	  .when('/category/:category', {
		  templateUrl: '/views/category.html',
		  controller: 'CategoryCtrl'
	  })
	  .otherwise({
		  redirectTo: '/404/html'
	  });
  }]);
