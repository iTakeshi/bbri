# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $('#my-review-form')
        .on 'ajax:complete', (event, ajax, status) ->
            response = $.parseJSON(ajax.responseText)
            if response.status == 'success'
                $('#new-review').modal('hide')
                $('.controls input').val(response.review.review_title)
                $('.controls textarea').val(response.review.review_text)
                $('#my-review-form .alert').toggleClass('alert-info', true)
                $('#my-review-form .alert').toggleClass('alert-error', false)
                $('#new-review-btn').text('Edit your review')
                $('#my-review-form').attr('method', 'put')
                if response.review.is_question == true
                    review_class = 'question'
                else
                    review_class = 'review'
                my_review = '<h3 class="' + review_class + '">' + response.review.review_title + '</h3>' +
                    'To: ' + $('h1').text() + ', By: ' + $('#current-user-name').text() + 
                    ' <a href="/reviews/' + response.review.id + '/good" data-remote="true" class="good-to-review"><i class="icon-thumbs-up"></i>Like </a>' +
                    '<span class="review-good-count">' + response.review.good_counter + '</span>' +
                    '<pre>' + response.review.review_text + '</pre>'
                $('#my-review').html(my_review)
            else
                $('#new-review-form .alert').toggleClass('alert-info', false)
                $('#new-review-form .alert').toggleClass('alert-error', true)

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
