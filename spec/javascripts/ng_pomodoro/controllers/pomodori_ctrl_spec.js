//= require spec_helper

describe('PomodoriCtrl', function() {
  var context = describe;
  var scope, ctrl, backend, mockInterval;
  var clock;

  beforeEach(angular.mock.module('AristotleApp'));

  beforeEach(angular.mock.inject(function($httpBackend) {
    var now = new Date();
    clock = sinon.useFakeTimers(now.getTime());

    backend = $httpBackend;
    backend.expect('GET', '/user/pursuits/1.json')
           .respond({ id: 1, name: 'Practice violin', user_id: 1, default_pomodoro_length: 50 });
  }));

  beforeEach(angular.mock.inject(function($controller, $rootScope, $http, $interval) {
    scope = $rootScope.$new();
    mockInterval = $interval;
    ctrl = $controller('PomodoriCtrl', { $scope: scope, $http: $http, $interval: mockInterval });
  }));

  afterEach(function() {
    clock.restore();
  });

  var tick = function(ms) {
    clock.tick(ms);
    mockInterval.flush(ms);
  };

  describe('initialization', function() {
    it('should have a timeElapsed variable that is equal to zero', function() {
      expect(scope.timeElapsed).to.equal(0);
    });
  });

  describe('#show', function() {
    beforeEach(function() {
      scope.show(1);
      backend.flush();
    });

    it('should set the pursuit attribute of the scope', function() {
      expect(scope.pursuit.id).to.equal(1);
      expect(scope.pursuit.name).to.equal('Practice violin');
      expect(scope.pursuit.user_id).to.equal(1);
      expect(scope.pursuit.default_pomodoro_length).to.equal(50);
    });

    it('should set the timeRemaining attribute', function() {
      expect(scope.timeRemaining).to.equal(50000);
    });

    it('should set the formattedTimeRemaining attribute', function() {
      expect(scope.formattedTimeRemaining).to.equal('0:50');
    });
    
    it('should decrease timeRemaining by the elapsed time since the last tick', 
      function() {

      clock.tick(1300);
      mockInterval.flush(100);
      expect(scope.timeRemaining).to.equal(48700);

      clock.tick(1700);
      mockInterval.flush(100);
      expect(scope.timeRemaining).to.equal(47000);
    });

    it('should re-set the formattedTimeRemaining', function() {
      tick(1000);
      expect(scope.formattedTimeRemaining).to.equal('0:49');
    });

    it('should send the pomodoro to the server');
  });

  describe('#pause', function() {
    beforeEach(function() {
      scope.show(1);
      backend.flush();
    });

    context('when the pomodoro is already paused', function() {
      it('should return false', function() {
        scope.pause();
        var pauseAgain = scope.pause();

        expect(pauseAgain).to.equal(false);
      });
    });

    context('when the pomodoro has already been paused and resumed', function() {
      it('should pause and resume an indefinite amount of times', function() {
        expect(scope.formattedTimeRemaining).to.equal('0:50');

        scope.pause();
        scope.resume();
        tick(1000);
        expect(scope.formattedTimeRemaining).to.equal('0:49');

        scope.pause();
        tick(1000);
        expect(scope.formattedTimeRemaining).to.equal('0:49');
      });
    });

    it('should set the pomodoro status to paused', function() {
      scope.pause();   

      expect(scope.status).to.equal('paused');
    });

    it('should pause the pomodoro timer', function() {
      tick(1000);
      expect(scope.formattedTimeRemaining).to.equal('0:49');

      scope.pause();
      tick(1000);
      expect(scope.formattedTimeRemaining).to.equal('0:49');

      tick(4000);
      expect(scope.formattedTimeRemaining).to.equal('0:49');
    });
  });

  describe('#resume', function() {
    beforeEach(function() {
      scope.show(1);
      backend.flush();
      scope.pause();
    });

    context('when the pomodoro is already running', function() {
      it('should return false', function() {
        scope.resume();
        var resumeAgain = scope.resume();

        expect(resumeAgain).to.equal(false);
      });
    });

    it('should set the pomodoro status to running', function() {
      scope.resume();
      
      expect(scope.status).to.equal('running');
    });

    it('should resume a paused pomodoro timer', function() {
      tick(1000);
      expect(scope.formattedTimeRemaining).to.equal('0:50');

      scope.resume();
      tick(5000);
      expect(scope.formattedTimeRemaining).to.equal('0:45');
    });
  });

  describe('#quit', function() {
    beforeEach(function() {
      scope.show(1);
      backend.flush();
      tick(5000);
    });

    it('should send the pomodoro with the proper params', function() {
      var data = {
        pomodoro: {
          pursuit_id:   1,
          elapsed_time: 5
        }
      };

      backend.expect('POST', '/user/pursuits/1/pomodori', data).respond(true);
      scope.quit();
      backend.flush();
    });
  });
});
