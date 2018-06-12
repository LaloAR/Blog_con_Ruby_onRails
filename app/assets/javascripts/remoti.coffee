$(document).on "click", ".file-activate", (ev)->
	selector = $(this).attr("for")
	$(selector).click()


# Agregar un selector a los controles con remotipart
$(document).on "change", ".remotipart", (eb)->
	# Se envía el formulario
	$(this).parent().submit()