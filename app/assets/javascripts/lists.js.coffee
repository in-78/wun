jQuery ->
  $('.calendar').datepicker
 	  dateFormat: 'yy-mm-dd'

  $('#lists tbody').sortable
    axis: 'y'
    update: ->
      $.post($('#lists').data('update-url'), $(this).sortable('serialize'))

  $('#items tbody').sortable
    axis: 'y'
    update: ->
      $.post($('#items').data('update-url'), $(this).sortable('serialize'))