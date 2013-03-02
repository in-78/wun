jQuery ->
  $('#search').autocomplete
    source: "/search_items"

  $('.complete').click ->
  	$.post($('#items').data('complete-url'), { 'id': this.id, 'complete': this.checked })