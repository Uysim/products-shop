GTC.Common =
  init: ->
    @menuToggle()
    # @tinymce()
    @editor()

  menuToggle: ->
    $('#menu-toggle').click (e) ->
      e.preventDefault()
      $('#wrapper').toggleClass 'toggled'

  editor: ->
    $('.editable').froalaEditor()

$(document).on 'page:load', ->
  window['rangy'].initialized = false