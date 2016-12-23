var dispatcher = require("../dispatcher");

module.exports = {
  savePomodoro: function(pursuitId, elapsedTime) {
    $.ajax({
      url: "/api/user/pursuits/" + pursuitId + "/pomodori",
      method: "POST",
      dataType: "JSON",
      data: {
        pomodoro: {
          elapsed_time: elapsedTime
        }
      },
      success: function() {
        alert('Timer complete!');
        window.location.assign("/user/pursuits/" + pursuitId);
      }
    });
  },
  setTimeRemaining: function(time) {
    dispatcher.dispatch({
      type: "receive-time-remaining",
      timeRemaining: time
    });
  }
}
