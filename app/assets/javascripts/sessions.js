// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('ready page:load', function() {
  setTimeout(function() {
    $(".notice, .alert").fadeOut(1000);
  }, 2400);
})