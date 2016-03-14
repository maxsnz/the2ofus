

$(document).ready(function() {

  // Менюшка
  var thisit = $('.topMenu');
  $('.topMenu').click(function(e) {
      e.preventDefault();
      $('.menu-collapsed').toggleClass("menu-expanded");
      thisit.toggleClass('active');
  });
  $('.menu-collapsed').click(function() {
      $('.menu-collapsed').toggleClass("menu-expanded");
      thisit.toggleClass('active');
  });

});