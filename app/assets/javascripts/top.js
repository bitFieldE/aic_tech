// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on("turbolinks:load", function() {
  $('.single-item').slick({
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1,
    dots: true,
    autoplay: true,
    pauseOnFocus: false,
    pauseOnHover: false,
    pauseOnDotsHover: false,
    autoplaySpeed: 4000
  });
})
