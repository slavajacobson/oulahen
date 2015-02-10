$ ->
  console.log $('#condo-profile-search').data('autoCompleteSource') + '/%QUERY'
  condoProfiles = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value')
    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote: $('#condo-profile-search').data('autoCompleteSource') + '/%QUERY')

  if $('#condo-profile-search').length > 0
    $('#condo-profile-search').typeahead null,
      name: 'best-pictures'
      displayKey: 'value'
      source: condoProfiles.ttAdapter()