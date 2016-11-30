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
//= require chosen-jquery
//= require jquery.purr
//= require best_in_place
//= require bootstrap-sprockets
// require turbolinks
//= require_tree .

$(function() {
  $('.chosen-select').chosen({width: '150px'});

  $('.guests').on('click', '.confirm', function(event) {
    var guest = $(event.target).parents('.guest-name');
    guest.fadeOut(800)
    $('.confirmed-guest').append(guest[0].outerHTML);
  })

  var DOMAIN = "http://localhost:3000"

  $('.button-confirm').on('click', function(event) {
    event.preventDefault;

    var confirm = $.map($('.confirmed-guest li'), function(g){
       var a = parseInt(g.id.split("_")[1]);
       $.ajax({
         url: `${DOMAIN}/guests/${a}.js`,
         type: 'patch',
         data: {guest: {rsvp: true}},
         success: function(){
           $('.confirmed-guest').hide();
         },
         error: function() {
           alert(`Could not rsvp guest, please try again...`)
         }
       })
    })
    console.log(confirm);
  })


  





});
