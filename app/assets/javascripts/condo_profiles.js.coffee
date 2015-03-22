# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  if $('#get-coordinates').length > 0
    $('#get-coordinates').on 'click', (e)->
      e.preventDefault()
      $("#condo_profile_lon").addClass("glow")
      $("#condo_profile_lat").addClass("glow")

      $.get($(e.currentTarget).attr('href'), address: $('#condo_profile_address').val()).always ->

        $("#condo_profile_lon").removeClass("glow")
        $("#condo_profile_lat").removeClass("glow")
      # , (data) ->
      #   console.log data
      # $.get
      #   url: $(e.currentTarget).attr('href')
      #   dataType: 'script'
      #   type: 'GET'

  if ($("#listing_condo_profile_id").length > 0)
    $('#listing_condo_profile_id').chosen
      no_results_text: 'No results matched'
      width: '200px'

    # $("#listing_condo_profile_id").select2
    #   placeholder: "Select a Profile"
    #   allowClear: true

