// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery-latest.min
//= require jquery_ujs
//= require bootstrap.min
//= require bootstrap-switch
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require lightbox-2.6.min
//= require gritter
//= require listings
//= require neighbourhoods
//= require jquery-ui
//= require condo_profiles
//= require select2
//= require chosen-jquery
function make_images_sortable() {
	    var sortable_list = $( "#photos > .row" ).sortable({
        start: function(event, ui) {
            var start_pos = ui.item.index();
            ui.item.data('start_pos', start_pos);
        },
        update: function(event, ui) {
            var start_pos = ui.item.data('start_pos');
            var end_pos = $(ui.item).index();
     


            $("#photos > .row").children().each(function(index){
            	$(this).find("#order_").val("{\"photo_id\": \"" + $(this).attr("id") + "\", \"order\": \"" + index + "\"}");
            });
        }
    });

}
$(document).ready(function() {

		if ($( "#photos > .row" ).length > 0)
		  make_images_sortable();

		//add this to listings.js on upload complete...


    $("input[name='listing[category_id]']:radio").change( function() {


      //Home selected
      if ($(this).val() == 1) {
        admin_home_selected();
      }
      //Condo selected
      else if ($(this).val() == 2) {
        admin_condo_selected();
      }
      //Commercial selected
      else {
        admin_commercial_selected();
      }
    });


    $("#general_tab_button").click(function() {
      if (!$("#general_tab_button").hasClass("active")) {
        
        $(".nav-tabs li").removeClass("active");

        $("#general_tab_button").addClass("active");

        $("#photos_tab").slideUp();

        $("#general_tab").slideDown();
      }
    }); 


    $("#photos_tab_button").click(function() {
      if (!$("#photos_tab_button").hasClass("active")) {
        $(".nav-tabs li").removeClass("active");

        $("#photos_tab_button").addClass("active");
        
        $("#photos_tab").slideDown();
        $("#general_tab").slideUp();

      }
    }); 

    if ($("input[name='listing[category_id]']:checked").val() == 1)
      admin_home_selected();
    else if ($("input[name='listing[category_id]']:checked").val() == 2)
      admin_condo_selected();
    else
      admin_commercial_selected();



    $( "input[name='listing[sold]']" ).change(function() {

      if ($(this).is(':checked'))
        $("#sold_properties").slideDown();
      else
        $("#sold_properties").slideUp();
    });

    if ($("input[name='listing[sold]']:checked").length == 0)
      $("#sold_properties").hide();


    $('#toggle_all_photos').click(function(){
      $(":checkbox[name='photo_ids[]']").prop('checked', !$(":checkbox[name='photo_ids[]']").eq(0).is(':checked'));
    });


  });

  function admin_home_selected() {
    $("#listing_unit_number").parent().hide();
    $("#listing_hide_unit_number").parent().hide();
    $("#listing_lot").parent().show();
    $("#listing_maintenance_fee").parent().hide();
  }
  function admin_condo_selected() {
    $("#listing_unit_number").parent().show();
    $("#listing_hide_unit_number").parent().show();
    $("#listing_lot").parent().hide();
    $("#listing_maintenance_fee").parent().show();
  }
  function admin_commercial_selected() {
    $("#listing_unit_number").parent().show();
    $("#listing_hide_unit_number").parent().show();
    $("#listing_lot").parent().show();
    $("#listing_maintenance_fee").parent().show();
  }


