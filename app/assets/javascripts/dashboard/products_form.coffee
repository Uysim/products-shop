GTC.ProductsForm = GTC.ProductsNew = GTC.ProductsCreate = GTC.ProductsEdit = GTC.ProductsUpdate =
  init: ->
    @_handleImageAdded()
    @_initUploaders()

  _handleImageAdded: ->
    self = @
    $('#images').on 'cocoon:after-insert', (e, productImage)->
      $(productImage).find('.image-file').trigger('click')
      self._initImagePreview(productImage)

  _initImagePreview: (productImage)-> 
    uploader = $(productImage).find('.image-file')
    image    = $(productImage).find('.image')
    $(image).previewImage
      uploader: uploader

  _initUploaders: ()->
    self = @
    productImages = $('.product-image')
    $.each productImages, (index, productImage)->
      self._initImagePreview(productImage)