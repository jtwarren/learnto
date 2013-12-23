# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

get = (name) ->
	if(name=(new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search))
      return decodeURIComponent(name[1])

base = () ->
	return location.href.split('?')[0]

ready = ->
	if (get('confirm'))
		$('#confirmModal').modal('show')
	$('.share').click ->
    	window.open('https://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(base()), 'facebook-share-dialog','width=626,height=436') 
    	return false
  $('.fb').click ->
      window.open('https://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(location.href),'facebook-share-dialog','width=626,height=436')
      return false
  $('.upload-skill-picture').click ->
    filepicker.pick 
      services: ["IMAGE_SEARCH", "URL", "COMPUTER"]
      openTo: "IMAGE_SEARCH"
    , (InkBlob) ->
      $('#skill_picture')[0].value = InkBlob.url
      $('.upload-skill-picture').html("Picture Uploaded!")
      $('.upload-skill-picture').addClass('success')    


$(document).ready(ready)
$(document).on('page:load', ready)
