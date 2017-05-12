$(document).ready(function() {
  $('.messages .msg .close').on('click', function(e) {
      e.preventDefault();
      $(this).parents('.msg').fadeOut();
    });
});
