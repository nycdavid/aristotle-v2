//= require spec_helper

var context = describe;

describe('pomodoriHelper', function() {
  beforeEach(angular.mock.module('AristotleApp'));

  var scope;

  beforeEach(function() {
    scope = {
      pursuit: { id: 1 },
      timeElapsed: 10 
    };
  });

  describe('#payload', function() {
    it('should return a pomodoro object to send to the server', function() {
      angular.mock.inject(function(pomodoriHelper) {
        returnedObject = pomodoriHelper.payload(scope);

        expect(returnedObject.pomodoro.pursuit_id).to.equal(1);
        expect(returnedObject.pomodoro.elapsed_time).to.equal(10);
      });
    });
  });
});
