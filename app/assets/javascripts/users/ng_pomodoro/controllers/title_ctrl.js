function TitleCtrl($scope, $rootScope, $http) {
  $scope.time = '00:00';
  $rootScope.$on('timeUpdate', function(event, args) {
    $scope.time = args.formattedTimeRemaining;
  });
};
TitleCtrl.$inject = ['$scope', '$http', '$rootScope'];
AristotleApp.controller('TitleCtrl', TitleCtrl);
