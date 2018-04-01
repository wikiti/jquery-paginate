class Paginator

  # Public properties
  # -----------------------------------

  options: null
  nav: null

  # Private properties
  # -----------------------------------

  obj = null
  jQuery = $

  # Public interface
  # -----------------------------------

  constructor: (jQuery, target) ->
    @$ = $
    obj = target
    return

  build: (options) ->
    @options = options
    if !@options.optional or @_totalRows() > @options.limit
      @_createNavigation()
      @_setPage()
    if @options.onCreate
      @options.onCreate obj
    obj

  # Private interface
  # -----------------------------------

  # -- Initialization

  _createNavigation: ->
    @_createNavigationWrapper()
    @_createNavigationButtons()
    @_appendNavigation()
    @_addNavigationCallbacks()
    return

  _createNavigationWrapper: ->
    # TODO: Custom navigation wrapper option
    @nav = $('<div>', class: @options.navigationClass)
    return

  _createNavigationButtons: ->
    # Add 'first' button
    if @options.first
      @_createNavigationButton @options.first, 'data-first': true

    # Add 'previous' button
    if @options.previous
      @_createNavigationButton @options.previous,
        'data-direction': -1
        'data-previous': true

    # Add page buttons
    for i in [0...@_totalPages()]
      @_createNavigationButton @options.pageToText(i), 'data-page': i

    # Add 'next' button
    if @options.next
      @_createNavigationButton @options.next,
        'data-direction': 1
        'data-next': true

    # Add 'last' button
    if @options.last
      @_createNavigationButton @options.last, 'data-last': true

    return

  _createNavigationButton: (text, options) ->
    # TODO: Custom navigation button option
    @nav.append $('<a>', $.extend(options, href: '#', text: text))
    return

  _appendNavigation: ->
    # Add the content to the navigation block
    if @options.navigationWrapper
      @options.navigationWrapper.append @nav
    else
      obj.after @nav
    return

  _addNavigationCallbacks: ->
    self = this

    @nav.find('a').click (e) ->
      direction = $(this).data('direction') * 1
      # 'First' button
      if $(this).data('first')
        self._setPage 0
      else if $(this).data('page') != undefined
        self._setPage $(this).data('page') * 1
      else if $(this).data('previous') or $(this).data('next')
        page = self._currentPage() + direction
        if page >= 0 and page <= self._totalPages() - 1
          self._setPage page
      else if $(this).data('last') != undefined
        self._setPage self._totalPages() - 1
      # Handle callback
      if self.options.onSelect
        self.options.onSelect obj, @_currentPage()
      e.preventDefault()
      false
    return

  # -- Page manipulation

  _setPage: (index) ->
    if index == undefined
      index = @options.initialPage
    # Hide all elements, and then show the current page.
    @_rows().hide()
      .slice(index * @options.limit, (index + 1) * @options.limit)
      .show()
    # Set the current button as active
    @nav.find('a').removeAttr('data-selected')
      .siblings('a[data-page=' + index + ']')
      .attr 'data-selected', true
    return

  _currentPage: ->
    @nav.find('a[data-selected=true]').data 'page'

  _totalRows: ->
    @_rows().length

  _rows: ->
    obj.find @options.childrenSelector

  _totalPages: ->
    Math.ceil @_totalRows() / @options.limit

export default Paginator
