var context = describe;

describe('timeHelper', function() {
  beforeEach(angular.mock.module('AristotleApp'));

  describe('#formatMinutes', function() {
    context('when total seconds are perfectly divisible by 60', function() {
      it('should convert to minutes', function() {
        angular.mock.inject(function(timeHelper) {
          expect(timeHelper.formatMinutes(300000)).to.equal(5);
        });
      });
    });

    context('when total milliseconds are not perfectly divisible by 60', function() {
      it('should convert to minutes', function() {
        angular.mock.inject(function(timeHelper) {
          expect(timeHelper.formatMinutes(432000)).to.equal(7);
        });
      });
    });
  });

  describe('#formatSeconds', function() {
    context('when the mod is less than 10', function() {
      it('should convert to ss seconds', function() {
        angular.mock.inject(function(timeHelper) {
          expect(timeHelper.formatSeconds(305000)).to.equal('05');
        });
      });
    });

    context('when the mod is greater than 10', function() {
      it('should convert to ss seconds', function() {
        angular.mock.inject(function(timeHelper) {
          expect(timeHelper.formatSeconds(311000)).to.equal(11);
        });
      });
    });
  });

  describe('#incrementTime', function() {
    var scope;

    beforeEach(function() {
      scope = {
        timeRemaining: 300,
        timeElapsed: 0
      };
    });

    it('should subtract 1 second from timeRemaining attribute of scope', function() {
      angular.mock.inject(function(timeHelper) {
        timeHelper.incrementTime(scope);
        expect(scope.timeRemaining).to.equal(299);
      });
    });

    it('should add 1 second to timeElapsed attribute of scope', function() {
      angular.mock.inject(function(timeHelper) {
        timeHelper.incrementTime(scope);
        expect(scope.timeElapsed).to.equal(1);
      });
    });
  });

  describe('#timeRemainingString', function() {
    var scope;

    beforeEach(function() {
      scope = {
        timeRemaining: 105000
      };
    });

    it('should return a human readable time string', function() {
      angular.mock.inject(function(timeHelper) {
        expect(timeHelper.timeRemainingString(scope)).to.equal('1:45');
      });
    });
  });
});
