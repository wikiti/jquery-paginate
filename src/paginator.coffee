import Content from './paginator/content.coffee'
import Navigator from './paginator/navigator.coffee'

class Paginator
  # -- Public properties

  target: null # Paginable container
  options: null # Pagination options

  # -- Private properties

  $ = null # jQuery ref
  content = null # Content manager
  navigator = null # Navigator manager

  # -- Public interface

  constructor: (jQuery, target, options) ->
    @target = target
    @options = options
    $ = jQuery
    content = new Content($, target, options)
    navigator = new Navigator($, target, options)
    @_setupEvents()
    return

  # -- Private interface
  _setupEvents: ->
    # TODO
    return

export default Paginator
