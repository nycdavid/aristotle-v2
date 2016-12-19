var React = require("react")
  , PomodoroActionCreators = require("../actions/pomodoro_action_creators")
  , PomodoroStore = require("../stores/pomodoro_store")
  , PomodoroUtilities = require("../utilities/pomodoro_utilities");

var Pomodoro = React.createClass({
  propTypes: {
    pursuitId: React.PropTypes.number.isRequired,
    pomodoroLength: React.PropTypes.number.isRequired
  },
  getInitialState: function() {
    return {
      elapsedTime: 0,
      intervalId: null,
      pomodoroLength: this.props.pomodoroLength,
      pursuitId: this.props.pursuitId,
      running: true,
      startTime: new Date().getTime(),
      timeRemaining: PomodoroUtilities.humanReadableTime(this.props.pomodoroLength)
    }
  },
  componentDidMount: function() {
    this._startTimer();
  },
  render: function() {
    return (
      <div className="pomodoro" rel="pomodori-timer">
        <h1 className="pomodoro__timer-display">{ this.state.timeRemaining }</h1>
        <button className="pomodoro__toggle-status btn btn-lg btn-clear branding-controls__control" onClick={ this._toggleTimer }>{ this._statusButton() }</button>
        <button className="pomodoro__stop btn btn-lg btn-clear branding-controls__control" onClick={ this._stopTimer }><i className="fa fa-stop"></i></button>
      </div>
    )
  },
  _stopTimer: function() {
    this._pomodoroCompleted(); 
  },
  _toggleTimer: function() {
    if (this.state.running) {
      clearInterval(this.state.intervalId);
    } else {
      this._startTimer();
    }
    this.setState({ running: !this.state.running }); 
  },
  _statusButton: function() {
    if (this.state.running) {
      return <i className="fa fa-pause"></i>;
    } else {
      return <i className="fa fa-play"></i>
    }
  },
  _startTimer: function() {
    var previousTime = new Date().getTime() - (this.state.elapsedTime * 1000);
    var intervalId = window.setInterval(function() {
      var time = new Date().getTime() - previousTime;
      this.setState({ elapsedTime: Math.floor(time / 1000) });
      var newTime = this.state.pomodoroLength - this.state.elapsedTime;

      if (newTime <= 0) {
        this.setState({ timeRemaining: PomodoroUtilities.humanReadableTime(0) });
        this._pomodoroCompleted(); 
      } else {
        this.setState({ timeRemaining: PomodoroUtilities.humanReadableTime(newTime) });
        PomodoroActionCreators.setTimeRemaining(this.state.timeRemaining);
      }
    }.bind(this), 1000);

    this.setState({ intervalId: intervalId });
  },
  _pomodoroCompleted: function() {
    clearInterval(this.state.intervalId);
    PomodoroActionCreators.savePomodoro(this.state.pursuitId, this.state.elapsedTime);
  }
});

module.exports = Pomodoro;
