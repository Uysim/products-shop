GTC.Common =
  init: ->

    @menuToggle()
  menuToggle: ->
    $('#menu-toggle').click (e) ->
      e.preventDefault()
      $('#wrapper').toggleClass 'toggled'