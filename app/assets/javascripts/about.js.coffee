ready = ->
  # if (undefined != $('.side-nav').offset())
  #   top = $('.side-nav').offset().top - parseFloat($('.side-nav').css("marginTop").replace(/auto/, 0))
  #   $(window).scroll (event) ->
      
  #     # what the y position of the scroll is
  #     y = $(this).scrollTop()
      
  #     # whether that's below the form
  #     if y >= top
  #       $('.side-nav').addClass "fixed"
  #     else
        
  #       # otherwise remove it
  #       $('.side-nav').removeClass "fixed"

$(document).ready(ready)
$(document).on('page:load', ready)