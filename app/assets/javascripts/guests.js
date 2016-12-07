jQuery(function() {
  $('#guest_best .best_in_place').best_in_place();
  $('#guest_best .best_in_place').bind('ajax:success', function(event) {
    var rsvp = $(event.delegateTarget).html();
    var confirmedGuest = parseInt($('.confirmed-guest-count').html());
    var guestId = $(event.delegateTarget).data('id');
    var plusOne = $(`#best_in_place_${guestId}_rsvp`).siblings().html().trim();

    if (rsvp === '<span class="glyphicon glyphicon-remove" aria-hidden="true" style="color:red;"></span>'){
      if(plusOne == 'true'){
        $('.confirmed-guest-count').html(confirmedGuest - 2);
      } else {
        $('.confirmed-guest-count').html(confirmedGuest - 1);
      }
    } else if (rsvp === '<span class="glyphicon glyphicon-ok" aria-hidden="true" style="color:green;"></span>'){
      if(plusOne == 'true'){
        $('.confirmed-guest-count').html(confirmedGuest + 2);
      } else {
        $('.confirmed-guest-count').html(confirmedGuest + 1);
      }
    }
  });
})
