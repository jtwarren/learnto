ready = ->
	$('.remove_field').click ->
		link=$('.remove_field')
		link.prev("input[type=hidden]").value = "1"
		link.parents(".fields").hide()
		return false

	$('.add_field').click ->
		new_id = new Date().getTime()
		regexp = new RegExp("new_"+association, "g")
		link=$('.add_field')
		association=$(this).data("association")
		content=$(this).data("fields").replace(regexp,new_id)
		trueContent = $(content)
		add_fields(link, trueContent)

	add_fields =(link, content) ->
		content.insertBefore(link)
		return false
$(document).ready(ready)
$(document).on('page:load', ready)
