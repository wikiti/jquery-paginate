import Paginator from './paginator.coffee'

# -- Paginator builder
$.fn.paginate = (options) ->
  new Paginator($, this, $.extend({}, $.fn.paginate.defaults, options))

# -- Getters and setters
# TODO

# -- Default paginator options
$.fn.paginate.defaults =
  limit: 20
  initialPage: 0
  previous: '<'
  next: '>'
  first: '<<'
  last: '>>'
  optional: true
  childrenSelector: 'tbody > tr'
  navigationParent: null
  pageToText: (i) -> (i + 1).toString()
