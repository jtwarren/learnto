ready = ->
  $(".glyphicon-star-empty").hover (->
    current_star = $(this)
    while (current_star.length > 0)
      current_star.removeClass('glyphicon-star-empty')
      current_star.removeClass('stars-unselected')
      current_star.addClass('glyphicon-star')
      current_star.addClass('stars')
      current_star = current_star.prev()
  ), ->
    current_star = $(this)
    all_stars = current_star.parent().children()
    for star in all_stars
      $(star).removeClass('glyphicon-star')
      $(star).removeClass('stars')      
      $(star).addClass('glyphicon-star-empty')
      $(star).addClass('stars-unselected')

  $('.glyphicon-star-empty').click ->
    $(this).unbind('mouseleave')
    stars = 0
    current_star = $(this)
    all_stars = current_star.parent().children()
    for star in all_stars
      $(star).removeClass('glyphicon-star')
      $(star).removeClass('stars')      
      $(star).addClass('glyphicon-star-empty')
      $(star).addClass('stars-unselected')
    while (current_star.length > 0)
      current_star.removeClass('glyphicon-star-empty')
      current_star.removeClass('stars-unselected')
      current_star.addClass('glyphicon-star')
      current_star.addClass('stars')
      stars += 1
      current_star = current_star.prev()
    $('#review_stars')[0].value = stars

$(document).ready(ready)
$(document).on('page:load', ready)
