function NavToggler(open, nav, close) {
  this.$openBtn = open;
  this.$closeBtn = close;
  this.$nav = nav;

  this.$openBtn.click(this.open.bind(this));
  this.$closeBtn.click(this.close.bind(this));
}

NavToggler.prototype.open = function() {
  this.$nav.css('display', 'block');
}

NavToggler.prototype.close = function() {
  this.$nav.css('display', 'none');
}

$(document).ready(function() {
  var icon = '<i class="nav-open fa fa-bars" aria-hidden="true"></i>';
  var $icon = $('.main-heading').prepend(icon);
  var $nav = $('.side-nav');
  var $close = $('.nav-close');

  new NavToggler($icon, $nav, $close);
});
