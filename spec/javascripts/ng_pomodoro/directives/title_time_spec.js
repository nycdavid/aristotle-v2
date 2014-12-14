//= require spec_helper

var context = describe;

describe('titleTime', function() {
  var mockScope, compileService;
  
  beforeEach(angular.mock.module('AristotleApp'));
  beforeEach(angular.mock.inject(function($rootScope, $compile) {
    mockScope = $rootScope.$new();
    compileService = $compile;
    mockScope.timeRemaining = 400;
  }));

  it('should foo', function() {
    var compileFn = compileService('<html><title title-time="timeRemaining"></title></html>');
    var elem = compileFn(mockScope);

    expect(elem.text()).to.equal('6:40');
  });
});
