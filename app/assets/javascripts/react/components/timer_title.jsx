var React = require("react")
  , PomodoroStore = require("../stores/pomodoro_store")
  , PomodoroUtilities = require("../utilities/pomodoro_utilities");

function getTimerTitleState() {
  return {
    timeRemaining: PomodoroStore.timeRemaining()
  }
}

var TimerTitle = React.createClass({
  getInitialState: function() {
    return {
      timeRemaining: PomodoroUtilities.humanReadableTime(0)
    }
  },
  componentDidMount: function() {
    PomodoroStore.addChangeListener(this._onChange);
  },
  componentWillUnmouse: function() {
    PomodoroStore.removeChangeListener(this._onChange);
  },
  render: function() {
    return <title>{ this.state.timeRemaining }</title>
  },
  _onChange: function() {
    this.setState(getTimerTitleState());
  }
});

module.exports = TimerTitle;
