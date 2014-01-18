# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.upload-event-picture').click ->
    filepicker.pick 
      services: ["IMAGE_SEARCH", "URL", "COMPUTER"]
      openTo: "IMAGE_SEARCH"
    , (InkBlob) ->
      $('#event_picture')[0].value = InkBlob.url
      $('.upload-event-picture').html("Picture Uploaded!")
      $('.upload-event-picture').addClass('success')


$(document).ready(ready)
$(document).on('page:load', ready)