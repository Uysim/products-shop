GTC.Initializer =
  exec: (pageName) ->
    if pageName && GTC[pageName]
      GTC[pageName]['init']()

  currentPage: ->
    return '' unless $('body').attr('id')
    bodyId = $('body').attr('id').split('-')
    action = GTC.Util.capitalize(bodyId[1])
    controller = GTC.Util.capitalize(bodyId[0])
    controller + action
  init: ->
    @exec('Common')
    if @currentPage()
      @exec(@currentPage())

$(document).on 'ready', ->
  GTC.Initializer.init()
