AristotleApp
  .controller('TitleCtrl', function($scope, $rootScope) {
    $scope.time = '00:00';
    $rootScope.$on('timeUpdate', function(event, args) {
      $scope.time = args.formattedTimeRemaining;
    });
  });
