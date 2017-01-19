// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require materialize
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  // Pushpin category navbar
  $('#nav-category').pushpin({
    top: $('#nav-category').offset().top
  });

  // Enable tooltip
  $('.tooltipped').tooltip({delay: 10});

  // Enable side-nav
  $('.button-collapse-always').sideNav({
    edge: 'right'
  });

  // Enable waves effect
  Waves.displayEffect();

  // Unfold search field
  $("#icon-search").click(function(e) {
    e.preventDefault();
    $(this).toggleClass("hide");
    
    $('#nav-search').toggleClass("hide");
    $('#search').focus();
  })

  // Fold search field
  $('#search').blur(function() {
    $('#nav-search').toggleClass("hide");
    $("#icon-search").toggleClass("hide");
  });
});
