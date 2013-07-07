'use strict';
/*global Hatena: true*/


angular.module('anblogApp')
.directive('hatenaPlugin', function ($rootScope) {
	return {
		restrict: 'C',
		link: function postLink(scope, element, attrs) {
			attrs.$set('href', 'http://b.hatena.ne.jp/entry/'+window.escape(scope.myurl));
			attrs.$set('data-hatena-bookmark-title', $rootScope.pageTitle);
			Hatena.Bookmark.BookmarkButton.setup();
		}
	};
});
