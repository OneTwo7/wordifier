'use strict';

@words_global_object =
	prepare_study_field: ->
		$sentence   = $ '#sen'
		$definition = $ '#def'

		disclose = ($btn, $br, $p) ->
			$btn.hide()
			$br.remove()
			$p.fadeIn(500)
			return

		$sentence.hide()
		$definition.hide()

		$('#sen_btn').on 'click', ->
			disclose $(this), $('#br_1'), $sentence
			return

		$('#def_btn').on 'click', ->
			disclose $(this), $('#br_2'), $definition
			return