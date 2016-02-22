# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# Add the dialog title
$ ->
  loading_posts = false
  $('a.load-more-products').on 'inview', (e, visible) ->
    return if loading_posts or not visible
    loading_posts = true
    
    $.getScript $(this).attr('href'), ->
      loading_posts = false