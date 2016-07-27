GTC.ProductsShow =
  init: ->
    @_handleSlideHeight()

  _handleSlideHeight: ->
    slideItems = $('#product-slide .item')
    maxHeight  = 0;
    $.each slideItems, (index, element)->
      height = $(element).height()
      if height > maxHeight
        maxHeight = height
    $('#product-slide .item').height(maxHeight);