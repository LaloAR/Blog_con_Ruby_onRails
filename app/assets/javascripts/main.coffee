# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.snack = (options) ->
	document.querySelector("#global-snackbar").MaterialSnackbar.showSnackbar(options)

$(document).on "page:load page:fetch ready", ()->
	$(".best_in_place").best_in_place()