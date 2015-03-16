$ ->

  condoProfiles = new Bloodhound(
    # datumTokenizer: (d) ->
    #   Bloodhound.tokenizers.whitespace d.value
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value')
    queryTokenizer: Bloodhound.tokenizers.whitespace
    limit: 8
    remote:
      url: $('#condo-profile-search').data('autoCompleteSource') + '/%QUERY'
      filter: (streets) ->
        if streets.length == 0
          return [{
            value: 'No Results'
          }]
        else
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
        
        if (datum.id != undefined)
          window.location.href = datum.id
        else
          
          $('.twitter-typeahead input').eq(0).val('')
          $('.twitter-typeahead input').eq(1).val('')
          obj.preventDefault()
          return false
