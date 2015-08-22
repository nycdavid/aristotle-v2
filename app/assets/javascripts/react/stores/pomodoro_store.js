var assign = require("object-assign")
  , BaseStore = require("./base_store")
  , dispatcher = require("../dispatcher");

var _timeRemaining = 0;

var PomodoroStore = assign({}, BaseStore, {
  timeRemaining: function() {
    return _timeRemaining;
  }
});

PomodoroStore.dispatchToken = dispatcher.register(function(action) {
  switch (action.type) {
    case "receive-time-remaining": 
      _timeRemaining = action.timeRemaining;
      PomodoroStore.emitChange();
      break;
    default:
  }
});

module.exports = PomodoroStore;
