GTC.ProductsIndex =
  init: ->
    @sortable()
  sortable: ->
    $( ".sortable" ).sortable(
      {
        handle: '.dragable'
      }
    )
