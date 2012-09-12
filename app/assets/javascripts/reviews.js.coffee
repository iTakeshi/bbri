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
                if $('#my-review pre').length == 0
                    li = '<li><h4 class="review-heading">' + response.review.review_title + '</h4>' +
                        '<div class="review-body" data-review-id="' + response.review.id + '">' +
                        '<a href="/review/' + response.review.id + '/good" data-remote="true"><i class="icon-thumbs-up"></i> Like </a>' +
                        '<span class="review-good-count">0</span>' +
                        '<pre>' + response.review.review_text + '</pre></div></li>'
                    $('#reviews').prepend(li)
                    $('#my-review-form').attr('method', 'put')
                my_review = '<h4>' + response.review.review_title + '</h4>' +
                    '<a href="/review/' + response.review.id + '/good" data-remote="true"><i class="icon-thumbs-up"></i> Like </a>' +
                    '<span class="review-good-count">0</span>' +
                    '<pre>' + response.review.review_text + '</pre>'
                $('#my-review').html(my_review)
            else
                $('#new-review-form .alert').toggleClass('alert-info', false)
                $('#new-review-form .alert').toggleClass('alert-error', true)

    $('.review-heading').live 'click', (event) ->
        $(@).next('.review-body').animate({ height: 'toggle', opacity: 'toggle' }, 'fast')
