ready = ->
  filepicker.setKey('AwDJHgIufS2WDkFtTMXBAz')
  $('.edit-field').hide()
  $('.upload').click ->
    filepicker.pick (InkBlob) ->
      $('#regular_user_picture')[0].value = InkBlob.url
      $('.upload').html("Picture Uploaded!")
      $('.upload').addClass('success')

  $('.edit').click -> 
    $(this).hide()
    category = $(this).parents('.info')
    category.find('.text').hide()
    category.find('.edit-field').show()
  $('.save').click ->
    category = $(this).parents('.info')
    name = category.attr('class').split(' ')[0]
    input = category.find('textarea').val()
    user_data = {}
    user_data[name] = input;
    data = {user: user_data}
    $.ajax({
      type: "PUT",
      data: data,
      url: window.location.pathname
    });
    category.find('.text').text(input)    
    category.find('.text').show()
    category.find('.edit').show()
    category.find('.edit-field').hide()

$(document).ready(ready)
$(document).on('page:load', ready)