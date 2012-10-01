# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $('.review-heading').live 'click', (event) ->
        $(@).next('.review-body').animate({ height: 'toggle', opacity: 'toggle' }, 'fast')
        $review_li = $(@).closest('.review-list')
        $.ajax
            type: 'GET'
            scriptCharset: 'utf-8'
            dataType: 'html'
            url: '/reviews/' + $review_li.attr('data-review-id') + '/comments'
            success: (res) ->
                console.log $review_li
                $review_li.find('ul').html(res)

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

    $('#review-form').live 'ajax:complete', (event, ajax, status) ->
        $('#review-form-wrapper').modal('hide')
        response = $.parseJSON(ajax.responseText)
        if response.new_record == 'true'
            if response.review.is_question
                $('#my-questions').prepend('<li class="review-list" data-review-id="' + response.review.id + '"></li>')
            else
                $('#my-review').prepend('<li class="review-list" data-review-id="' + response.review.id + '"></li>')
                $edit_link = $('ul#my-review').prev('a')
                $edit_link.text('Edit you review')
                $edit_link.attr('href', '/reviews/' + response.review.id + '/edit')
        if response.review.is_question == true
            review_class = 'question'
        else
            review_class = 'review'
        $li_review = $('li[data-review-id="' + response.review.id + '"]')
        $li_review.html('<div class="review-heading"><h3 class="' + review_class + '">' + response.review.review_title + '</h3>' +
            '<a href="/reviews/' + response.review.id + '/edit" data-remote="true" class="edit-my-review"><i class="icon-pencil"></i>Edit</a><br>' +
            'To: <a href="/parts/' + response.part_identifier + '">' + response.part_identifier + '</a>, By: ' + response.user +
            '<a href="/reviews/' + response.review.id + '/good" class="good-to-review" data-remote="true"><i class="icon-thumbs-up"></i>Like </a>' +
            '<span class="review-good-count">0</span></div>' +
            '<div class="review-body"><pre>' + response.review.review_text + '</pre></div>')
