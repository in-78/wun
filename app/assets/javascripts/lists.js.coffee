# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('.calendar').datepicker
 	  dateFormat: 'yy-mm-dd'

  $('#lists tbody').sortable
    axis: 'y'
    update: ->
      $.post($('#lists').data('update-url'), $(this).sortable('serialize'))