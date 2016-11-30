jQuery(function() {

  $('.best_in_place').best_in_place()
  $('.best_in_place').bind('ajax:success', function(data) {
    var serviceId = $(this).data('id');

    var budget = $("#best_in_place_service_17_budget").html();
    var price = $("#best_in_place_service_17_price").html();
    status = budget - price
    $('.status').html(status)
  })

})
