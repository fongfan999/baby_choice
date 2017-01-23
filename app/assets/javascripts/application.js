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
  $('#nav-category-root').pushpin({
    top: $('#nav-category-root').offset().top
  });

  // Enable tooltip
  $('.tooltipped').tooltip({delay: 10});

  // Enable side-nav
  $('.button-collapse-always').sideNav({
    edge: 'right'
  });
  // Hide side-nav
  $('.hide-side-nav').click(function(e) {
    e.preventDefault();
    $('.button-collapse').sideNav('hide');
  });

  // Enable waves effect
  Waves.displayEffect();

  // Unfold search field
  $("#icon-search").click(function(e) {
    e.preventDefault();
    $(this).toggleClass('hide');
    
    $('#nav-search').toggleClass('hide');
    $('#q').focus();
  })

  // Fold search field
  $('#q').blur(function() {
    $('#nav-search').toggleClass('hide');
    $("#icon-search").toggleClass('hide');
  });

  // Go to top
  $(".go-to-top").click(function(event){
    event.preventDefault();
    $("body").animate({"scrollTop": "0px"}, 500);
  })

  // Show go to top button when page height is greater than 1000
  $(window).scroll(function() {
    if ($(this).scrollTop() > 1000) {
      $('.go-to-top').show();
    } else {
      $('.go-to-top').fadeOut('slow');
    }
  });

  // Banner
  // Initialize slider
  $('.carousel.carousel-slider').carousel({full_width: true});
  
  $(window).resize(function() {
    // Responsive slider
    $('#slide-default').height( $('#slide-default  .carousel-item').height() );
  });

  // Navigate slider on click
  $('.nav-slide').click(function(e) {
    var step = 300;
    e.preventDefault();
    lastestArticles = $('.nav-slide-content');
    currentScrollLeft = lastestArticles.scrollLeft();

    if ($(this).data('nav') === 'next') {
      lastestArticles.animate({"scrollLeft": currentScrollLeft + step}, 500);
    } else {
      lastestArticles.animate({"scrollLeft": currentScrollLeft - step}, 500);
    }
  })
});

// Autoplay slide-default
setInterval(function(){
  $('#slide-default').carousel('next');
}, 7000);
