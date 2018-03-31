(function(){function r(e,n,t){function o(i,f){if(!n[i]){if(!e[i]){var c="function"==typeof require&&require;if(!f&&c)return c(i,!0);if(u)return u(i,!0);var a=new Error("Cannot find module '"+i+"'");throw a.code="MODULE_NOT_FOUND",a}var p=n[i]={exports:{}};e[i][0].call(p.exports,function(r){var n=e[i][1][r];return o(n||r)},p,p.exports,r,e,n,t)}return n[i].exports}for(var u="function"==typeof require&&require,i=0;i<t.length;i++)o(t[i]);return o}return r})()({1:[function(require,module,exports){
(function($) {
  var Paginator;
  Paginator = require('./paginator.coffee');
  $.fn.paginate = function(options) {
    return new Paginator($, this).build($.extend({}, $.fn.paginate.defaults, options));
  };
  $.fn.paginate.defaults = {
    limit: 20,
    initialPage: 0,
    previous: '<',
    next: '>',
    first: '<<',
    last: '>>',
    optional: true,
    onCreate: null,
    onSelect: null,
    childrenSelector: 'tbody > tr',
    navigationWrapper: null,
    navigationClass: 'page-navigation',
    pageToText: function(i) {
      return (i + 1).toString();
    }
  };
})(jQuery);


},{"./paginator.coffee":2}],2:[function(require,module,exports){
var Paginator;

Paginator = function($, target) {
  var addNavigationCallbacks, appendNavigation, createNavigation, createNavigationButton, createNavigationButtons, createNavigationWrapper, currentPage, jQuery, obj, rows, self, setPage, totalPages, totalRows;
  self = this;
  // Public properties
  // -----------------------------------
  self.options = null;
  self.nav = null;
  // Private properties
  // -----------------------------------
  obj = target;
  jQuery = $;
  // Public interface
  // -----------------------------------
  self.build = function(options) {
    self.options = options;
    if (!self.options.optional || totalRows() > self.options.limit) {
      createNavigation();
      setPage();
    }
    if (self.options.onCreate) {
      self.options.onCreate(obj);
    }
    return obj;
  };
  // Private interface
  // -----------------------------------

  // -- Initialization
  createNavigation = function() {
    createNavigationWrapper();
    createNavigationButtons();
    appendNavigation();
    addNavigationCallbacks();
  };
  createNavigationWrapper = function() {
    // TODO: Custom navigation wrapper option
    self.nav = $('<div>', {
      class: self.options.navigationClass
    });
  };
  createNavigationButtons = function() {
    var i, j, ref;
    // Add 'first' button
    if (self.options.first) {
      createNavigationButton(self.options.first, {
        'data-first': true
      });
    }
    // Add 'previous' button
    if (self.options.previous) {
      createNavigationButton(self.options.previous, {
        'data-direction': -1,
        'data-previous': true
      });
    }
// Add page buttons
    for (i = j = 0, ref = totalPages(); (0 <= ref ? j < ref : j > ref); i = 0 <= ref ? ++j : --j) {
      createNavigationButton(self.options.pageToText(i), {
        'data-page': i
      });
    }
    // Add 'next' button
    if (self.options.next) {
      createNavigationButton(self.options.next, {
        'data-direction': 1,
        'data-next': true
      });
    }
    // Add 'last' button
    if (self.options.last) {
      createNavigationButton(self.options.last, {
        'data-last': true
      });
    }
  };
  createNavigationButton = function(text, options) {
    // TODO: Custom navigation button option
    self.nav.append($('<a>', $.extend(options, {
      href: '#',
      text: text
    })));
  };
  appendNavigation = function() {
    // Add the content to the navigation block
    if (self.options.navigationWrapper) {
      self.options.navigationWrapper.append(self.nav);
    } else {
      obj.after(self.nav);
    }
  };
  addNavigationCallbacks = function() {
    self.nav.find('a').click(function(e) {
      var direction, page;
      direction = $(this).data('direction') * 1;
      // 'First' button
      if ($(this).data('first')) {
        setPage(0);
      } else if ($(this).data('page') !== void 0) {
        setPage($(this).data('page') * 1);
      } else if ($(this).data('previous') || $(this).data('next')) {
        page = currentPage() + direction;
        if (page >= 0 && page <= totalPages() - 1) {
          setPage(page);
        }
      } else if ($(this).data('last') !== void 0) {
        setPage(totalPages() - 1);
      }
      // Handle callback
      if (self.options.onSelect) {
        self.options.onSelect(self.obj, currentPage());
      }
      e.preventDefault();
      return false;
    });
  };
  // -- Page manipulation
  setPage = function(index) {
    if (index === void 0) {
      index = self.options.initialPage;
    }
    // Hide all elements, and then show the current page.
    rows().hide().slice(index * self.options.limit, (index + 1) * self.options.limit).show();
    // Set the current button as active
    self.nav.find('a').removeAttr('data-selected').siblings('a[data-page=' + index + ']').attr('data-selected', true);
  };
  currentPage = function() {
    return self.nav.find('a[data-selected=true]').data('page');
  };
  totalRows = function() {
    return rows().length;
  };
  rows = function() {
    return obj.find(self.options.childrenSelector);
  };
  totalPages = function() {
    return Math.ceil(totalRows() / self.options.limit);
  };
};

module.exports = Paginator;


},{}]},{},[1]);
