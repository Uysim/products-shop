GTC.SlidersForm =
  init: ->
    @onChoseFile()
    @cocoonInserted()
    @cocoonConfig()

  cocoonConfig: ->
    $('a.add_fields').data('association-insertion-method', 'append')
    $('a.add_fields').data("association-insertion-node", 'table.slider-photos tbody')

  cocoonInserted: ->
    $('body').on 'cocoon:after-insert', (e, addedPartial) ->
      $('input[type=file]', addedPartial).change(GTC.SlidersForm.onAddFile)

  onChoseFile: ->
    $('input[type=file]').each ->
      $(this).change(GTC.SlidersForm.onAddFile)

  onAddFile: (event)->

    file = event.target.files[0]
    url = URL.createObjectURL(file)

    thumbContainer = $(this).closest('tr').find('td.thumb')
    console.log(thumbContainer)
    if thumbContainer.find('img').length == 0
      thumbContainer.append('<img src="' + url + '" />')
    else
      thumbContainer.find('img').attr('src', url)

GTC.SlidersEdit = GTC.SlidersForm
GTC.SlidersNew = GTC.SlidersForm