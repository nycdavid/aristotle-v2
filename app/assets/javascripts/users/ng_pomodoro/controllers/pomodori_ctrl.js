function PomodoriCtrl($scope, $rootScope, $interval, $http, $resource, $window, pursuitsUrl, timeHelper, pomodoriHelper) {
  $scope.pursuitsResource = $resource(pursuitsUrl + ':id.json', { id: '@id' });
  $scope.pomodoriResource = $resource(pursuitsUrl + ':pursuit_id/pomodori', { pursuit_id: '@pursuit_id' });

  $scope.timeElapsed = 0;
  $scope.status = 'running';

  var intervalPromise;
  $scope.show = function(id) {
    $scope.pursuitsResource.get({ id: id })
      .$promise.then(function(data) {
        $scope.pursuit = data;
        $scope.timeRemaining = data.default_pomodoro_length;
        $scope.formattedTimeRemaining = timeHelper.timeRemainingString($scope);

        intervalPromise = startTimer();
      });
  };

  $scope.pause = function() {
    if ($scope.status == 'paused') return false;

    $scope.status = 'paused';
    $interval.cancel(intervalPromise);
  };

  $scope.resume = function() {
    if ($scope.status == 'running') return false;

    $scope.status = 'running';
    intervalPromise = startTimer();
  };

  $scope.quit = function() {
    $interval.cancel(intervalPromise);
    sendPomodoro(createPayload());
  };

  $scope.abort = function() {
    $window.location.href = '/user/pursuits/' + $scope.pursuit.id;
  };

  // Private
  function checkTime() {
    if ($scope.timeRemaining == 0) {
      $interval.cancel(intervalPromise);
      sendPomodoro(createPayload()); 
    }
  };

  function sendPomodoro(pomodoro) {
    new $scope.pomodoriResource(pomodoro)
      .$save({ pursuit_id: $scope.pursuit.id })
      .then(redirectToPursuit);
  };

  function redirectToPursuit() {
    $window.location.href = '/user/pursuits/' + $scope.pursuit.id;
    alert('Pomodoro has completed!');
  };

  function startTimer() {
    return $interval(function() {
      timeHelper.incrementTime($scope); 
      $scope.formattedTimeRemaining = timeHelper.timeRemainingString($scope);
      $rootScope.$broadcast('timeUpdate', { formattedTimeRemaining: $scope.formattedTimeRemaining });
      checkTime();
    }, 1000);
  };

  function createPayload() {
    return {
      pomodoro: {
        pursuit_id: $scope.pursuit.id,
        elapsed_time: $scope.timeElapsed
      }
    }
  };
};

PomodoriCtrl.$inject = ['$scope', '$rootScope', '$interval', '$http', '$resource', '$window', 'pursuitsUrl', 'timeHelper', 'pomodoriHelper'];

AristotleApp
.constant('pursuitsUrl', '/user/pursuits/')
.controller('PomodoriCtrl', PomodoriCtrl);
