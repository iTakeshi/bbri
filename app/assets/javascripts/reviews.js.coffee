# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $('#new-review-form')
        .on 'ajax:complete', (event, ajax, status) ->
            response = $.parseJSON(ajax.responseText)
            if response.status == 'success'
                $('#new-review').modal('hide')
                $('.controls input').val('')
                $('.controls textarea').val('')
                $('#new-review-form .alert').toggleClass('alert-info', true)
                $('#new-review-form .alert').toggleClass('alert-error', false)
                $('#new-review-btn').attr('href', 'javascript:void(0)')
                $('#new-review-btn').attr('disabled', 'disabled')
                li = '<li><h4 class="review-heading">' + response.review.review_title + '</h4>' +
                    '<div class="review-body" data-review-id="' + response.review.id + '">' +
                    '<a href="/reviews/' + response.review.id + '/good" data-remote="true"><i class="icon-thumbs-up"></i></a>' +
                    '<span class="review-good-count">0</span>' +
                    '<a href="/reviews/' + response.review.id + '/bad" data-remote="true"><i class="icon-thumbs-down"></i></a>' +
                    '<span class="review-bad-count">0</span>' +
                    '<pre>' + response.review.review_text + '</pre></div></li>'
                $('#reviews').prepend(li)
            else
                $('#new-review-form .alert').toggleClass('alert-info', false)
                $('#new-review-form .alert').toggleClass('alert-error', true)

    $('.review-good, .review-bad')
        .on 'ajax:complete', (event, ajax, status) ->
            response = $.parseJSON(ajax.responseText)
            if response.status == 'success'
                $(@).closest('.review-body').children('.review-good-count').text(response.review.good_count)
                $(@).closest('.review-body').children('.review-bad-count').text(response.review.bad_count)
            else if response.status == 'already'
                if $(@).hasClass('review-good')
                    evaluation = 'GOOD'
                else
                    evaluation = 'BAD'
                window.alert('You have already said "' + evaluation + '" to this review')
