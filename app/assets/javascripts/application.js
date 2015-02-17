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
//= require jquery
//= require jquery-migrate-min
//= require jquery_ujs
//= require museutils
//= require jquery.musemenu
//= require webpro
//= require musewpslideshow
//= require jquery.museoverlay
//= require touchswipe
//= require musewpdisclosure
//= require jquery.musepolyfill.bgsize
//= require jquery.watch
//= require mortgage_calculator
//= require landtransfer_calculator
//= require gritter
//= require bootstrap-slideshow.min
//= require gallerific
//= require twitter/typeahead.min
//= require search

jQuery(document).ready(function($) {
  if ($('#thumbs').length > 0) {
    $('#thumbs').galleriffic({
      imageContainerSel:      '#slideshow',
      controlsContainerSel:   '#controls',
      captionContainerSel: '#caption',
      delay:                     5000, // in milliseconds
      numThumbs:                 20, // The number of thumbnails to show page
      preloadAhead:              40, // Set to -1 to preload all images
      autoStart: true,
      prevLinkText:              '<',
      nextLinkText:              '>',
      syncTransitions: true
    });

  }

  // if ($(".condo_profile").length > 0) {
  //   var lon = $(".condo_profile").data("lon");
  //   var lat = $(".condo_profile").data("lat");
  //   var address = encodeURIComponent($(".condo_profile").data("address"));

  //   var path = "http://api.walkscore.com/score?format=json&address=" + address + "&lat=" + lat + "&lon=" + lon + "&wsapikey=b84b6a85455d2fe8fd04f93ce048518c"
  //   console.log(path);

  //   $.ajax({ 
  //     type: 'GET', 
  //     url: path,
  //     contentType: "application/json",
  //     success: function(data) {
  //       console.log(data);
  //     }

  //   })
  // }
});