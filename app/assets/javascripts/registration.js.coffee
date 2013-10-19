ready = ->
	$('.remove_field').click ->
		link=$('.remove_field')
		link.prev("input[type=hidden]").value = "1"
		link.parents(".fields").hide()
		return false

	$('.add_field').click ->
		link=$('.add_field')
		association=$(this).data["association"]
		content=$(this).data["fields"]
		add_fields(link, association, content)

$(document).ready(ready)
$(document).on('page:load', ready)

add_fields (link, association, content) ->
	new_id = new Date().getTime()
	regexp = new RegExp("new_"+association, "g")
	$(link).prev().insert({
		before: content.replace(regexp,new_id)
	})
