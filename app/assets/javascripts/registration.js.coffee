ready = ->
	$('.remove_field').click ->
		link=$('.remove_field')
		link.prev("input[type=hidden]").value = "1"
		link.parents(".fields").hide()
		return false
$(document).ready(ready)
$(document).on('page:load', ready)