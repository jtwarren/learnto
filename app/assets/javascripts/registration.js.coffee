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

	multiform()
$(document).ready(ready)
$(document).on('page:load', ready)

multiform = () ->
	steps = $("#SignupForm fieldset")
	count = steps.size()
	$("#Submit").hide()
	$("SignupForm").before("<ul id='steps'></ul>")
	steps.each (i) ->
		name = $(this).find("legend").html()
		$("#steps").append ("<li id='stepDesc" + i + "'>Step " + (i + 1) + "<span>" + name + "</span></li>")
		$(this).wrap "<div id='step" + i + "'></div>"
		$(this).append "<p id='step" + i + "commands'></p>"
		if i is 0
			createNextButton(i, count)
			selectStep i
		else if i is count - 1
			$("#step" + i).hide()
			createPrevButton i
		else
			$("#step" + i).hide()
			createPrevButton i
			createNextButton(i, count)

createPrevButton = (i) ->
	stepName = "step" + i
	$("#" + stepName + "commands").append "<a href='#' id='" + stepName + "Prev' class='prev'>< Back</a>"
	$("#" + stepName + "Prev").bind "click", (e) ->
		$("#" + stepName).hide()
		$("#Submit").hide()
		$("#step" + (i - 1)).show()
		selectStep (i - 1)
		return false

createNextButton = (i, count) ->
	stepName = "step" + i
	$("#" + stepName + "commands").append "<a href='#' id='" + stepName + "Next' class='next'>Next ></a>"
	$("#" + stepName + "Next").bind "click", (e) ->
		if (i+2)==count
			$("#Submit").show()
		$("#" + stepName).hide()
		$("#step" + (i + 1)).show()
		selectStep (i + 1)
		return false

selectStep = (i) ->
	$("#steps li").removeClass "current"
	$("#stepDesc" + i).addClass "current"




