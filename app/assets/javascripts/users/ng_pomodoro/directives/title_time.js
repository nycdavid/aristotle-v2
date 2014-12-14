angular
  .module('titleTimeDirective', [])
  .directive('titleTime', function(timeHelper) {
    return function(scope, element, attrs) {
      var data = scope[attrs['titleTime']];  
      element.text(timeHelper.timeRemainingString(scope));
    };
  });
