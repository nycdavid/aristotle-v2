$(document).ready(function() {

  // - Lower the opacity after 1.5s 
  var initialFadeout = setTimeout(initialFadeoutFunc, 1500);

  // - Fadeout completely after 4s
  var completeFadeout = setTimeout(completeFadeoutFunc, 4000);

  // - Kill notification on click
  // - Disable the fadeouts
  $('.notification').click(function() {
    clearTimeout(initialFadeout);
    clearTimeout(completeFadeout);
    $(this).hide();
  });

  // - Bring opacity back to 1 and disable fadeouts on mousein
  $('.notification').hover(function() {
    console.log("mouseenter");
    $(this).css('opacity', 1.0);

    clearTimeout(initialFadeout);
    clearTimeout(completeFadeout);
    initialFadeout = setTimeout(initialFadeoutFunc, 1500);
    completeFadeout = setTimeout(completeFadeoutFunc, 4000);
  }, function() {
  });

});

function initialFadeoutFunc() {
  $('.notification').fadeTo(500, 0.8);
}

function completeFadeoutFunc() {
  $('.notification').fadeOut(500);
}
