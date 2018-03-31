(($) ->
  Paginator = require('./paginator.coffee')

  $.fn.paginate = (options) ->
    new Paginator($, this).build($.extend({}, $.fn.paginate.defaults, options))

  $.fn.paginate.defaults =
    limit: 20
    initialPage: 0
    previous: '<'
    next: '>'
    first: '<<'
    last: '>>'
    optional: true
    onCreate: null
    onSelect: null
    childrenSelector: 'tbody > tr'
    navigationWrapper: null
    navigationClass: 'page-navigation'
    pageToText: (i) -> (i + 1).toString()
  return
) jQuery
