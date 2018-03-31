Paginator = ($, target) ->
  self = this

  # Public properties
  # -----------------------------------

  self.options = null
  self.nav = null

  # Private properties
  # -----------------------------------

  obj = target
  jQuery = $

  # Public interface
  # -----------------------------------

  self.build = (options) ->
    self.options = options
    if !self.options.optional or totalRows() > self.options.limit
      createNavigation()
      setPage()
    if self.options.onCreate
      self.options.onCreate obj
    obj

  # Private interface
  # -----------------------------------

  # -- Initialization

  createNavigation = ->
    createNavigationWrapper()
    createNavigationButtons()
    appendNavigation()
    addNavigationCallbacks()
    return

  createNavigationWrapper = ->
    # TODO: Custom navigation wrapper option
    self.nav = $('<div>', class: self.options.navigationClass)
    return

  createNavigationButtons = ->
    # Add 'first' button
    if self.options.first
      createNavigationButton self.options.first, 'data-first': true

    # Add 'previous' button
    if self.options.previous
      createNavigationButton self.options.previous,
        'data-direction': -1
        'data-previous': true

    # Add page buttons
    for i in [0...totalPages()]
      createNavigationButton self.options.pageToText(i), 'data-page': i

    # Add 'next' button
    if self.options.next
      createNavigationButton self.options.next,
        'data-direction': 1
        'data-next': true

    # Add 'last' button
    if self.options.last
      createNavigationButton self.options.last, 'data-last': true

    return

  createNavigationButton = (text, options) ->
    # TODO: Custom navigation button option
    self.nav.append $('<a>', $.extend(options, href: '#', text: text))
    return

  appendNavigation = ->
    # Add the content to the navigation block
    if self.options.navigationWrapper
      self.options.navigationWrapper.append self.nav
    else
      obj.after self.nav
    return

  addNavigationCallbacks = ->
    self.nav.find('a').click (e) ->
      direction = $(this).data('direction') * 1
      # 'First' button
      if $(this).data('first')
        setPage 0
      else if $(this).data('page') != undefined
        setPage $(this).data('page') * 1
      else if $(this).data('previous') or $(this).data('next')
        page = currentPage() + direction
        if page >= 0 and page <= totalPages() - 1
          setPage page
      else if $(this).data('last') != undefined
        setPage totalPages() - 1
      # Handle callback
      if self.options.onSelect
        self.options.onSelect self.obj, currentPage()
      e.preventDefault()
      false
    return

  # -- Page manipulation

  setPage = (index) ->
    if index == undefined
      index = self.options.initialPage
    # Hide all elements, and then show the current page.
    rows().hide()
      .slice(index * self.options.limit, (index + 1) * self.options.limit)
      .show()
    # Set the current button as active
    self.nav.find('a').removeAttr('data-selected')
      .siblings('a[data-page=' + index + ']')
      .attr 'data-selected', true
    return

  currentPage = ->
    self.nav.find('a[data-selected=true]').data 'page'

  totalRows = ->
    rows().length

  rows = ->
    obj.find self.options.childrenSelector

  totalPages = ->
    Math.ceil totalRows() / self.options.limit

  return

module.exports = Paginator
