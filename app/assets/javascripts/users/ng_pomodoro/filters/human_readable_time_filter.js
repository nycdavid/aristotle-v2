angular
  .module('AristotleApp')
  .filter('humanReadableTime', function() {
    return function(seconds) {
      return formatMinutes(seconds) + ':' + formatSeconds(seconds);
    }
  });

function formatMinutes(seconds) {
  return parseInt(seconds / 60, 10);
};

function formatSeconds(seconds) {
  var ss = seconds % 60;
  return ss < 10 ? '0' + ss : ss;
}
