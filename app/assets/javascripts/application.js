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
//= require jquery-ui
//= require best_in_place
//= require bootstrap-sprockets
//= require hopscotch
//= require_tree .

$(function() {
  $('.chosen-select').chosen({width: '150px'});

  $('#all-guests').on('click', '.guest-name', function(event) {
    var guest = $(event.target);
    event.preventDefault;
    guest.draggable()
    $('.rsvp-true').droppable();
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

  $('.pick-gift').on('click', function(event){
    var giftId = parseInt(($(this).parents('tr').attr('id')).split("_")[1])
    var quantityAfter = parseInt($(this).parents('td').siblings('.quantity').html()) - 1
    var quantityBefore = $(this).parents('td').siblings('.quantity')

    $.ajax({
      url: `${DOMAIN}/gifts/${giftId}.js`,
      type: 'patch',
      data: {gift: {quantity: quantityAfter}},
      success: function(){
        quantityBefore.html(quantityAfter);
      },
      error: function() {
        alert(`Could not pick this gift, please try again...`)
      }
    })
  })

  var tourGuest = {
    id: "edit-info",
    steps: [
      {
        target: "hopscotch",
        title: "Hi, do you need to edit?",
        content: "Just click on the item you need to edit, make your changes and press enter!",
        placement: "top",
        xOffset: 'center',
        arrowOffset: 'left'
      }
    ]
  };
  var tourService = {
    id: "edit-info",
    steps: [
      {
        target: "hopscotch",
        title: "Hi, do you need to edit?",
        content: "Just click on the item you need to edit (Vendor, Budget or Price), make your changes and press enter!",
        placement: "top",
        xOffset: 'center',
        arrowOffset: 'center'
      }
    ]
  };
  $('table').on('click', '#glyphicon-pencil-guest', function(){
    hopscotch.startTour(tourGuest);
  })
  $('table').on('click', '#glyphicon-pencil-service', function(){
    hopscotch.startTour(tourService);
  })
});
