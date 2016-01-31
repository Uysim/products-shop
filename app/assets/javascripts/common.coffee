GTC.Common =
  init: ->
    @menuToggle()
    @navbar()

  menuToggle: ->
    $('#menu-toggle').click (e) ->
      e.preventDefault()
      $('#wrapper').toggleClass 'toggled'


  navbar: ->
    navbar = $('nav.navbar')
    top = navbar.offset().top;
    $(window).scroll ->
      if $(this).scrollTop() > top
        navbar.removeClass('container')
        navbar.addClass('navbar-fixed-top')
      else
        navbar.addClass('container')
        navbar.removeClass('navbar-fixed-top')
