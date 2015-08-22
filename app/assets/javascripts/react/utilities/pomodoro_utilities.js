module.exports = {
  padSeconds: function(secondsRemaining) {
    if (secondsRemaining < 10) {
      return "0" + secondsRemaining;
    } else {
      return secondsRemaining;
    }
  },
  humanReadableTime: function(totalSeconds) {
    var minutes = Math.floor(totalSeconds / 60);
    var seconds = this.padSeconds(totalSeconds - minutes * 60);
    return minutes + ":" + seconds;
  }
}
