# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  $('form').on 'click', '.add_fields', (event) ->
    $(this).before($(this).data('fields'))
    event.preventDefault()