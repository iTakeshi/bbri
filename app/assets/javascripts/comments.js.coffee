# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $('.comment-to-review').live 'ajax:complete', (event, ajax, status) ->
        $(@).next('.comment-form-wrapper').html(ajax.responseText)

    $('.comment-form').live 'ajax:complete', (event, ajax, status) ->
        response = $.parseJSON(ajax.responseText)
        $(@).closest('.review-list').find('ul').append('<li class="comment-list" data-comment-id="' + response.comment.id + '">' +
            '<div class="comment-header"><span class="comment-user">' + response.user_name + '</span>' +
            '<span class="comment-time">' + response.time + '</span>' +
            '</div><pre>' + response.comment.comment_text + '</pre></li>')
        $(@).closest('.comment-form-wrapper').html("")
