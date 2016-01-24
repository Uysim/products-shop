GTC.Common =
  init: ->
    @menuToggle()
    @tooltip()

  menuToggle: ->
    $('#menu-toggle').click (e) ->
      e.preventDefault()
      $('#wrapper').toggleClass 'toggled'

  tooltip: ->
    $('[data-toggle="tooltip"]').tooltip()