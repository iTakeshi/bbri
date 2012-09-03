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
                li = '<li><h4>' + response.review.review_title + '</h4></li>'
                $('#reviews').prepend(li)
            else
                $('#new-review-form .alert').toggleClass('alert-info', false)
                $('#new-review-form .alert').toggleClass('alert-error', true)
