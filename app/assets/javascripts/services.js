jQuery(function() {

  $('#services_best .best_in_place').best_in_place();
  $('#services_best .best_in_place').bind('ajax:success', function(data) {
    if ($(this).parents('tr').attr('id') !== undefined){
      var serviceId = $(this).parents('tr').attr('id');
    } else {
      var serviceId = $(this).parents('div').attr('id');
    }

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
