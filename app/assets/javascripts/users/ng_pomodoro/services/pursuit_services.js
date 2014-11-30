angular
  .module('PursuitServices', [])
  .factory('timeHelper', function() {
    return {
      formatMinutes: function(totalSeconds) {
        return parseInt(totalSeconds / 60, 10);
      },
      formatSeconds: function(totalSeconds) {
        var ss = totalSeconds % 60;
        return ss < 10 ? '0' + ss : ss;
      },
      incrementTime: function(scope) {
        scope.timeRemaining--; 
        scope.timeElapsed++;
      },
      timeRemainingString: function(scope) {
        return this.formatMinutes(scope.timeRemaining) + ':' + this.formatSeconds(scope.timeRemaining);
      }
    };
  });
