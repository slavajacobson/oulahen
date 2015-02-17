
$(function() {

  if ($("#neighbourhood_schools").length > 0)

    $("#neighbourhood_schools").select2({
      tags:  true,
      tokenSeparators: [',']
    });



});
