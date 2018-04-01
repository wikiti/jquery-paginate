class Navigator

  # Public properties
  # -----------------------------------

  options: null
  target: null

  # Private properties
  # -----------------------------------

  $ = null
  nav = null

  # Public interface
  # -----------------------------------

  constructor: (jQuery, target, options) ->
    $ = jQuery
    @options = options
    @target = target
    @_build()
    return

  # TODO: Rebuild method

  setPage: (index) ->
    if index == undefined
      index = @options.initialPage

    index = @_clampPage(index)
    return if index == @currentPage()

    previousPage = @currentPage()

    # Set the current button as active
    nav.find('a').removeAttr('data-jp-selected')
      .siblings('[data-jp-page=' + index + ']').attr 'data-jp-selected', true
    @target.trigger 'jp:change', @currentPage(), previousPage
    return

  currentPage: ->
    nav.find('[data-jp-selected]').data 'jp-page'

  # Private interface
  # -----------------------------------

  # -- Initialization

  _build: ->
    if !@options.optional or @_totalRows() > @options.limit
      @_createNavigation()
      @setPage()
    @target.trigger('jp:create')
    return

  # -- Navigation

  _createNavigation: ->
    @_createNavigationWrapper()
    @_createNavigationButtons()
    @_appendNavigation()
    @_addNavigationCallbacks()
    return

  _createNavigationWrapper: ->
    # TODO: Custom navigation wrapper render
    nav = $('<div>', class: @options.navigationClass)
    return

  _appendNavigation: ->
    # Add the content to the navigation block
    if @options.navigationParent
      $(@options.navigationParent).append nav
    else
      @target.after nav
    return

  _addNavigationCallbacks: ->
    self = this

    nav.find('[data-jp]').click (e) ->
      direction = $(this).data('jp-direction') * 1
      if $(this).data('jp-first')
        self.setPage 0
      else if $(this).data('jp-page') != undefined
        self.setPage $(this).data('jp-page') * 1
      else if $(this).data('jp-previous') or $(this).data('jp-next')
        page = self.currentPage() + direction
        self.setPage page
      else if $(this).data('jp-last') != undefined
        self.setPage self._totalPages() - 1

      e.preventDefault()
      false

    return

  # -- Navigation buttons

  _createNavigationButtons: ->
    # Add 'first' button
    if @options.first
      @_createNavigationButton @options.first, 'data-jp-first': true

    # Add 'previous' button
    if @options.previous
      @_createNavigationButton @options.previous,
        'data-jp-direction': -1
        'data-jp-previous': true

    # Add page buttons
    for i in [0...@_totalPages()]
      @_createNavigationButton @options.pageToText(i), 'data-jp-page': i

    # Add 'next' button
    if @options.next
      @_createNavigationButton @options.next,
        'data-jp-direction': 1
        'data-jp-next': true

    # Add 'last' button
    if @options.last
      @_createNavigationButton @options.last, 'data-jp-last': true

    return

  _createNavigationButton: (text, options) ->
    # TODO: Custom navigation renderer
    button = $('<a>', $.extend(options, href: '#', text: text))
    button.attr('data-jp', true)
    nav.append button
    return

  # -- Page calculations

  _clampPage : (page) ->
    return 0 if page < 0
    return @_totalPages() - 1 if page >= @_totalPages()
    page

  _totalRows: ->
    # TODO: Move this to content manager
    @target.find(@options.childrenSelector).length

  _totalPages: ->
    Math.ceil @_totalRows() / @options.limit

export default Navigator
