$(document).on 'turbolinks:load', ->
  console.log "working"
  # Trix tool bar fixed top
  if $('#trix-wrapper').length > 0
    trixToolbarScrollTop = $('trix-toolbar').offset().top

    $(window).scroll ->
      if trixToolbarScrollTop < $(window).scrollTop()
        if $('#header').has('trix-toolbar').length == 0
          $('trix-toolbar').appendTo('#header')
      else
        if $('#trix-wrapper').has('trix-toolbar').length == 0
          $('trix-toolbar').prependTo('#trix-wrapper')