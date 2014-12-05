//= require spec_helper
//= require users/ng_pomodoro/services/pursuit_services
//= require users/ng_pomodoro/controllers/pomodori_ctrl

describe('PomodoriCtrl', function() {
  var context = describe;
  var scope, ctrl, backend, mockInterval;

  beforeEach(angular.mock.module('AristotleApp'));
  
  beforeEach(angular.mock.inject(function($httpBackend) {
    backend = $httpBackend;
    backend.expect('GET', 'http://localhost:3000/user/pursuits/1.json')
           .respond({ id: 1, name: 'Practice violin', user_id: 1, default_pomodoro_length: 50 });
  }));

  beforeEach(angular.mock.inject(function($controller, $rootScope, $http, $interval) {
    scope = $rootScope.$new()
    mockInterval = $interval;
    ctrl = $controller('PomodoriCtrl', { $scope: scope, $http: $http, $interval: mockInterval });
  }));

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
      expect(scope.timeRemaining).to.equal(50);
    });

    it('should set the formattedTimeRemaining attribute', function() {
      expect(scope.formattedTimeRemaining).to.equal('0:50');
    });
    
    it('should decrease the timeRemaining by 1 every second', function() {
      mockInterval.flush(1000);
      expect(scope.timeRemaining).to.equal(49);
    });

    it('should increase the timeElapsed by 1 every second', function() {
      mockInterval.flush(1000);
      expect(scope.timeElapsed).to.equal(1);
    });

    it('should re-set the formattedTimeRemaining', function() {
      mockInterval.flush(1000);
      expect(scope.formattedTimeRemaining).to.equal('0:49');
    });

    it('should send the pomodoro to the server');
  });
});