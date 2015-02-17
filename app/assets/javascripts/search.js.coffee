$ ->

  condoProfiles = new Bloodhound(
    # datumTokenizer: (d) ->
    #   Bloodhound.tokenizers.whitespace d.value
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value')
    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote:
      url: $('#condo-profile-search').data('autoCompleteSource') + '/%QUERY'
      filter: (streets) ->
        return $.map streets, (street) ->
          return {
            value: street.address
            id: street.url
          }
  )

  condoProfiles.initialize();

  # condoProfiles = new Bloodhound(
  #   datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value')
  #   queryTokenizer: Bloodhound.tokenizers.whitespace
  #   remote: 
  # $('.typeahead.intersection').typeahead(null,
  #   hightlight: true
  #   autoselect: true
  #   displayKey: 'value'
  #   source: intersections.ttAdapter()).bind 'typeahead:selected', (obj, datum, name) ->
  #   lookUpIntersection datum.value, datum.id
  #   return


  if $('#condo-profile-search').length > 0
    console.log $('#condo-profile-search').data('autoCompleteSource') + '/%QUERY'
    $('#condo-profile-search').typeahead(null,
      name: 'streets'
      hightlight: true
      autoselect: true
      displayKey: 'value'
      source: condoProfiles.ttAdapter()).bind 'typeahead:selected', (obj, datum, name) ->
        window.location.href = datum.id