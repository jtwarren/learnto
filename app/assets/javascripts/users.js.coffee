ready = ->
  $('.edit-field').hide()
  $('.edit').click -> 
    $(this).hide()
    category = $(this).parents('.info')
    category.find('.text').hide()
    category.find('.edit-field').show()

$(document).ready(ready)
$(document).on('page:load', ready)