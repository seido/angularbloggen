'use strict';

angular.module('anblogApp')
.directive('insertScript', function () {
	return {
		restrict: 'C',
		link: function postLink(scope, element, attrs) {
			var s = document.createElement('script');
			s.type = 'text/javascript';
			s.src = attrs.src;
			//element.text('this is the insertScript directive');
			element[0].appendChild(s);
		}
	};
});
