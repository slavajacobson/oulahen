# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
	$('#new_photo').fileupload
		dataType: "script"
		add: (e, data) ->
			data.context = $(tmpl("template-upload", data.files[0]))
			$('#progress_bars').append(data.context)
			data.submit()
		progress: (e, data) ->
			if data.context
				progress = parseInt(data.loaded / data.total * 100, 10)
				data.context.find('.progress-bar').css('width', progress + '%')
		complete: (e, data) ->
			$(this).hide()
		stop: (e) ->
			$.gritter.add
			  title: "Photos"
			  text: "All photos have been finished uploading."
			  image: '/assets/success.png'
			
			




