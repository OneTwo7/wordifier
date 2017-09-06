'use strict'

@words_global_object =
	prepare_study_field: ->
		$sentence   = $ '#sen'
		$definition = $ '#def'

		disclose = ($btn, $p) ->
			$btn.addClass 'hidden'
			$p.removeClass 'hidden'
			return

		$('#sen_btn').on 'click', ->
			disclose $(this), $sentence
			return

		$('#def_btn').on 'click', ->
			disclose $(this), $definition
			return

		return

	prepare_word_modal: ->
		$modal = $ '#word-modal'
		$content = $ '#word-modal-content'
		$close = $modal.children '.close-modal'
		$shadow = $ '#shadow'

		close_modal = ->
			unless $modal.hasClass 'hidden'
				$shadow.css 'z-index', 1
				$shadow.toggleClass 'hidden'
				$modal.toggleClass 'hidden'
			return

		$close.on 'click', ->
			close_modal()
			return

		$shadow.on 'click', ->
			close_modal()
			return

		return