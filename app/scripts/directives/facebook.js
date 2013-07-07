'use strict';
/*global FB: true*/

angular.module('anblogApp')
.directive('facebookPlugin', function () {
	return {
		restrict: 'C',
		link: function(scope, element, attributes) {
			attributes.$set('data-href', scope.myurl);
			var ready = typeof FB !== 'undefined' && FB !== null;
			return ready ? FB.XFBML.parse(element.parent()[0]) : void 0;
		}
	};
});
