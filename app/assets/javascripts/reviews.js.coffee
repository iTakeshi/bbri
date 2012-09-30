# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $('.review-heading').live 'click', (event) ->
        $(@).next('.review-body').animate({ height: 'toggle', opacity: 'toggle' }, 'fast')

    $('.good-to-review').live 'ajax:complete', (event, ajax, status) ->
        response = $.parseJSON(ajax.responseText)
        if response.status == 'success'
            $(@).next('.review-good-count').text(response.good_counter)
            if response.operation == 'increment'
                $(@).html('<i class="icon-thumbs-down"></i> Unlike ')
            else
                $(@).html('<i class="icon-thumbs-up"></i> Like ')

    $('.edit-my-review').live 'ajax:complete', (event, ajax, status) ->
        $('#review-form-wrapper').html(ajax.responseText)
        $('#review-form-wrapper').modal('show')
