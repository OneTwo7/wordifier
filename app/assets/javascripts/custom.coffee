'use strict'

initialState = ->
	$shadow = $('#shadow')
	$shadow.height($(document).height())
	$modal = $('#word-modal')
	unless $modal.length and not $modal.hasClass('hidden')
		$shadow.addClass('hidden')
	$('#navbar').addClass('sm-hidden')
	$('#dropdown-list').addClass('hidden')
	return

toggleNav = ->
	$('#shadow').toggleClass('hidden')
	$('#navbar').toggleClass('sm-hidden')
	return

ready = ->

	$shadow = $('#shadow')

	$('#up-btn').on 'click', (e) ->
		e.preventDefault()
		$('html, body').animate({ scrollTop: 0 }, 'fast')
		return

	$('#nav-toggle').on 'click', ->
		toggleNav()
		return

	$('#account-dropdown').on 'click', (e) ->
		e.preventDefault()
		e.stopPropagation()
		$('#dropdown-list').toggleClass('hidden')
		return

	$shadow.on 'click', ->
		unless $('#navbar').hasClass('sm-hidden')
			toggleNav()
		return

	$shadow.height($(document).height())

	return

$(document).on 'click', ->
	$list = $('#dropdown-list')
	if not $list.hasClass('hidden')
		$list.toggleClass('hidden')
	return

$(window).scroll ->
  cond = $(window).scrollTop() + $(window).height() == $(window).height()
  unless cond
    $('#up-btn').removeClass('hidden')
  else
    $('#up-btn').addClass('hidden')
  return

$(window).on 'resize', ->
	initialState()
	return

$(document).on('turbolinks:load', ready)
