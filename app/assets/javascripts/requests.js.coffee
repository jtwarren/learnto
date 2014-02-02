ready = ->
  $('.upload-request-picture').click ->
    filepicker.pick 
      services: ["IMAGE_SEARCH", "URL", "COMPUTER"]
      openTo: "IMAGE_SEARCH"
    , (InkBlob) ->
      $('#request_picture')[0].value = InkBlob.url
      $('.upload-request-picture').html("Picture Uploaded!")
      $('.upload-request-picture').addClass('success')    


$(document).ready(ready)
$(document).on('page:load', ready)
