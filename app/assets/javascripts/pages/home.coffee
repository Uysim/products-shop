GTC.PagesHome =
  init: ->
    @carousel()
  carousel: ->
    $('.carousel').carousel({
      interval: 10000
    });