class Content

  # Public properties
  # -----------------------------------

  options: null
  target: null

  # Private properties
  # -----------------------------------

  $ = null

  # Public interface
  # -----------------------------------

  constructor: (jQuery, target, options) ->
    $ = jQuery
    @options = options
    @target = target
    return


export default Content
