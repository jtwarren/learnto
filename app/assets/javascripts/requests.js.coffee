ready = ->
  $('.upload-request-picture').click ->
    filepicker.pick 
      services: ["IMAGE_SEARCH", "URL", "COMPUTER"]
      openTo: "IMAGE_SEARCH"
    , (InkBlob) ->
      $('#request_picture')[0].value = InkBlob.url
      $('.upload-request-picture').html("Picture Uploaded!")
      $('.upload-request-picture').addClass('success')    
  $('.arrow').click ->
    thing = $(this)
    link = thing.attr('link')
    $.ajax({
      url: link
    }).done(() ->
      num = parseInt($('.votes').text())
      $('.votes').text(num+1)
      $('.votes').removeClass('neutral')
      $('.votes').addClass('success')
      thing.removeClass('clickable')
      );


$(document).ready(ready)
$(document).on('page:load', ready)
