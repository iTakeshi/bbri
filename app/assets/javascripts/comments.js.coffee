# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $('.comment-to-review').live 'ajax:complete', (event, ajax, status) ->
        $(@).next('.comment-form-wrapper').html(ajax.responseText)
