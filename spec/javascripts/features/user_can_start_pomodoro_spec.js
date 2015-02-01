var feature = describe;
var scenario = it;

feature('User can start a pomodoro', function() {
  var dv;
  beforeEach(function() {
    dv = browser.driver;
    dv.get('http://localhost:4000/login');
    dv.findElement(by.name('user[email]')).sendKeys('johndoe@person.com');
    dv.findElement(by.name('user[password]')).sendKeys('foo');
    dv.findElement(by.tagName('button')).click();
  });

  scenario('User clicks start pomodoro', function() {
    dv.findElement(by.linkText('My Pursuits')).click();
    dv.findElement(by.linkText('Exercise')).click(); 
    dv.findElement(by.linkText('Start Pomodoro')).click();
    browser.wait(function() {
      return browser.switchTo().alert().then(
        function(alert) {
          alert.accept();
          return true;
        },
        function() {
          return false;
        }
      );
    });
    expect(dv.findElement(by.css('.pomodori-count')).getText()).toBe('Pomodori Count: 1');
  });
});
