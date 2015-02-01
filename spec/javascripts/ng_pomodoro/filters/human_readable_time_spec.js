describe('humanReadableTime', function() {
  var context = describe;

  var filterInstance;

  beforeEach(angular.mock.module('AristotleApp'));

  beforeEach(angular.mock.inject(function($filter) {
    filterInstance = $filter('humanReadableTime');  
  }));
  
  it('should convert seconds to a human readable time string', function() {
    var result = filterInstance(240);
    expect(result).to.equal('4:00');
  });
});
