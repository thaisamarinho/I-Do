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






  var DOMAIN = "http://localhost:3000"

  $('.guest-name').on('click', '.im-going',function(event) {
    event.preventDefault();
    var guestId = $(this).parents('li').data('id')
       $.ajax({
         url: `${DOMAIN}/guests/${guestId}.js`,
         type: 'patch',
         data: {guest: {rsvp: true}},
         success: function(){
           console.log($('button .im-going'));
           $('button .im-going').addClass('.active');
         },
         error: function() {
           alert(`Could not rsvp guest, please try again...`)
         }
       })
  })
  $('.guest-name').on('click', '.cant-make-it',function(event) {
    event.preventDefault();
    var guestId = $(this).parents('li').data('id')
       $.ajax({
         url: `${DOMAIN}/guests/${guestId}.js`,
         type: 'patch',
         data: {guest: {rsvp: false}},
         success: function(){
           console.log($('button .im-going'));
           $('button .cant-make-it').addClass('.active');
         },
         error: function() {
           alert(`Could not rsvp guest, please try again...`)
         }
       })
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
