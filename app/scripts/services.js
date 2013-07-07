'use strict';

angular.module('postServices', ['ngResource']).
factory('Posts', function($resource) {
	return $resource('/api/posts.json');
}).
factory('PostMeta', function($resource) {
	return $resource('/api/:postid.meta.json');
}).
factory('Categories', function($resource) {
	return $resource('/api/categories.json');
});
