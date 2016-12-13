//= require jquery
//= require jquery_ujs
//= require chosen-jquery
//= require jquery.purr
//= require jquery-ui
//= require mustache
//= require jquery.mustache
//= require best_in_place
//= require bootstrap-sprockets
//= require hopscotch
//= require_tree .

$(function() {
  $('.chosen-select').chosen({width: '150px'});

  var DOMAIN = "http://localhost:3000"

  var WEDID = $('wed').data('id')

  if(WEDID){
    getTables(WEDID);
  }

  $(document.body).on('click', '.im-going',function(event) {
    event.preventDefault();
    console.log('Inside callback function after on click');
    var guestId = $(this).parents('li').data('id')
       $.ajax({
         url: `${DOMAIN}/guests/${guestId}.js`,
         type: 'patch',
         data: {guest: {rsvp: true}},
         success: function(){
           console.log('Ajax request successful!');
           $(this).addClass('active')
           $(this).siblings().removeClass('active')
         }.bind(this),
         error: function() {
           alert(`Could not rsvp guest, please try again...`)
         }
       })
  })
  $(document.body).on('click', '.cant-make-it',function(event) {
    event.preventDefault();
    var guestId = $(this).parents('li').data('id')
       $.ajax({
         url: `${DOMAIN}/guests/${guestId}.js`,
         type: 'patch',
         data: {guest: {rsvp: false}},
         success: function(){
          console.log('Yay!');
          $(this).addClass('active')
          $(this).siblings().removeClass('active')
        }.bind(this),
         error: function() {
           alert(`Could not rsvp guest, please try again...`)
         }
       })
  })

  $('.pick-gift').on('click', function(){
    var giftId = $(this).parents('tr').data('id')
    var quantityAfter = parseInt(
      $(this).parents('td').siblings('.quantity').html()
    ) - 1
    var quantityBefore = $(this).parents('td').siblings('.quantity')
    $.ajax({
      url: `${DOMAIN}/gifts/${giftId}.js`,
      type: 'patch',
      data: {gift: {available_quantity: quantityAfter}},
      success: function(){
        quantityBefore.html(quantityAfter);
      },
      error: function() {
        alert(`Could not pick this gift, please try again...`)
      }
    })
  })

  $('.table-arrangements').hide();
  // $('.add-table').submit(function(e){
  //   // e.preventDefault();
  //   $('.table-arrangements').slideDown();
  // });

  $(document.body).on('click', '.add-guest',function(event) {
    var guestId = $(this).parents('li').data('id');
    var guest = $(this).parents('li');
    $('.table').append(guest);
    $('.save-table').click(function(){
      var tableId = $(this).siblings('ul').data('id')
      console.log(tableId);
      $.ajax({
        url: `${DOMAIN}/guests/${guestId}.json`,
        type: 'patch',
        data: {guest: {table_id: tableId}},
        success: function(result){
         console.info(result);
         $('.table-arrangements').slideUp();
         getTables(WEDID);
       },
        error: function(err) {
          console.error(err);
        }
      })
    })
  });

  function getTables(wedding_id) {
    $.ajax({
      url: `${DOMAIN}/weddings/${wedding_id}/tables.json`,
      success: function (json) {
        console.table(json.tables);
        renderTables(json.tables);
      },
      error: function () {
        alert('Could not load tables, please try again...')
      }
    })
  };

  function renderTables(tables) {
    var tableTemplate = $('#table-summary').html();
    var tableList = $('.table-list');
    Mustache.parse(tableTemplate);
    var tablesHTML = tables.map(function (table) {
        return Mustache.render(tableTemplate, table)
      }).join('');
    tableList.html(tablesHTML);
  };

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

  $('.update-form').hide();
  $('.update-form-btn').click(function(){
    $('.update-form').slideDown();
  })
  $('.guests').hide();
  $('.rsvp').click(function(){
    $('.registry').slideUp();
    $('.guests').slideDown();
  })
  $('.registry').hide();
  $('.gift').click(function(){
    $('.guests').slideUp();
    $('.registry').slideDown();
  })

});
