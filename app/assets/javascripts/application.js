// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on("turbolinks:load", function() {
  $('.droptool').click(function() {
    $('.contents').slideToggle(100);
    $('.droptool').hide();
  });
  $('.close-modal').click(function() {
    $('.contents').slideToggle(100);
    $('.droptool').show();
  });
  setTimeout("$('.notice').fadeOut('slow')", 1000);

  var WindowHeight = $(window).height();
  //console.log(WindowHeight);
  var TotalHeight = $('main').height() + $('header').height() + $('footer').height();
  //console.log(TotalHeight);
  if (TotalHeight < WindowHeight) {
    $('main').css({'height': WindowHeight + 'px'})
  }
})
