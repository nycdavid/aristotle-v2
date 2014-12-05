angular
  .module('PomodoroServices', [])
  .factory('pomodoriHelper', function() {
    return {
      payload: function(scope) {
        return { pomodoro: { pursuit_id: scope.pursuit.id, elapsed_time: scope.timeElapsed } }
      }
    };
  });
