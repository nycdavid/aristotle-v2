function NavToggler(open, nav, close) {
  this.$openBtn = open;
  this.$closeBtn = close;
  this.$nav = nav;

  this.$openBtn.click(this.open.bind(this));
  this.$closeBtn.click(this.close.bind(this));
}

NavToggler.prototype.open = function() {
  if ($(window).width() > 768) {
    return false;
  }
  this.$nav.css('display', 'block');
  this.$nav.css('position', 'absolute');
}

NavToggler.prototype.close = function() {
  if ($(window).width() > 768) {
    return false;
  }
  var screenWidth = $(window).width();
  this.$nav.css('display', 'none');
}

$(document).ready(function() {
  var $icon = $('.main-heading').prepend('<i class="nav-open fa fa-bars"></i>');
  var $close = $('.side-nav').prepend('<i class="nav-close fa fa-times"></i>');
  var $nav = $('.side-nav');

  new NavToggler($icon, $nav, $close);
});
