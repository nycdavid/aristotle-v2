AristotleApp
  .constant('pursuitsUrl', 'http://localhost:3000/user/pursuits/')
  .controller('PomodoriCtrl', function($scope, $rootScope, $interval, $http, $resource, $window, pursuitsUrl, timeHelper, pomodoriHelper) {
    $scope.pursuitsResource = $resource(pursuitsUrl + ':id.json', { id: '@id' });
    $scope.pomodoriResource = $resource(pursuitsUrl + ':pursuit_id/pomodori', { pursuit_id: '@pursuit_id' });

    $scope.timeElapsed = 0;

    var intervalPromise;
    $scope.show = function(id) {
      $scope.pursuitsResource.get({ id: id })
            .$promise.then(function(data) {
              $scope.pursuit = data;
              $scope.timeRemaining = data.default_pomodoro_length;
              $scope.formattedTimeRemaining = timeHelper.timeRemainingString($scope);

              intervalPromise = $interval(function() {
                timeHelper.incrementTime($scope); 
                $scope.formattedTimeRemaining = timeHelper.timeRemainingString($scope);
                $rootScope.$broadcast('timeUpdate', { formattedTimeRemaining: $scope.formattedTimeRemaining });
                checkTime();
              }, 1000);
            });
    };

    $scope.pause = function() {
      $interval.cancel(intervalPromise);
    };

    // Private
    function checkTime() {
      if ($scope.timeRemaining == 0) {
        $interval.cancel(intervalPromise);
        var payload = {
          pomodoro: {
            pursuit_id: $scope.pursuit.id,
            elapsed_time: $scope.timeElapsed
          }
        };
        sendPomodoro(payload); 
      }
    };

    function sendPomodoro(pomodoro) {
      new $scope.pomodoriResource(pomodoro)
                .$save({ pursuit_id: $scope.pursuit.id })
                .then(redirectToPursuit);
    };

    function redirectToPursuit() {
      $window.location.href = '/user/pursuits/' + $scope.pursuit.id;
    };
  });
