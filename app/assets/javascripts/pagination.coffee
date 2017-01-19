$(document).on 'turbolinks:load', ->
  # Execute on scrolling
  $(window).on 'scroll', ->
    nextPageUrl = $('.pagination a.next_page').attr('href')
    scrollBottom = $(document).height() - $(window).height() - $(window).scrollTop()
    
    if nextPageUrl && scrollBottom < 200
      $('.infinite-root .preloader').toggleClass('hide')
      $.getScript nextPageUrl