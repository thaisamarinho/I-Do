jQuery(function() {

  $('.best_in_place').best_in_place();
  $('.best_in_place').bind('ajax:success', function(data) {
    var serviceId = $(this).data('id');
    var budget = $(`#best_in_place_${serviceId}_budget`).html();
    var price = $(`#best_in_place_${serviceId}_price`).html();
    status = budget - price
    if (status <= 0) {
      $(`#${serviceId} .status`).html(status).css({ 'color': 'red'})
    } else {
      $(`#${serviceId} .status`).html(status).css({ 'color': 'green'})
    }
  })

})
