function TitleCtrl($scope, $http) {
  $scope.time = '00:00';
  $rootScope.$on('timeUpdate', function(event, args) {
    $scope.time = args.formattedTimeRemaining;
  });
};
TitleCtrl.$inject = ['$scope', '$http'];
AristotleApp.controller('TitleCtrl', TitleCtrl);
