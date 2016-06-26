# jQuery paginate

## Summary

`jquery-paginate` is a simple [`jquery`](https://jquery.com/) plugin that allows html websites to paginate tables and other kind of containers.

A working example can be found [here](https://wikiti-random-stuff.gitlab.io/jquery-paginate/example.html).

## Installation

Install this package as a bower dependecy with:

```
bower install jquery-paginate
```

or download the `jquery-paginate.min.js` file and include it in your website:

```html
<script src='jquery.min.js'></script>
<!-- Add it after your jquery file! -->
<script src='jquery-paginate.min.js'></script>
```

## Basic usage

Imagine the following html table:

```html
<table id="myTable">
  <thead>
    <tr>
      <td>Header 1</td>
      <td>Header 2</td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Row 1.1</td>
      <td>Row 1.2</td>
    </tr>
    <tr>
      <td>Row 2.1</td>
      <td>Row 2.2</td>
    </tr>
    <!-- ... -->
  </tbody>
</table>
```

You can paginate your table by using the `paginate` method on your selector object:

```js
$('#myTable').paginate({ limit: 10 });
```

A navigation bar will be created under the table, and the table will show 10 elements per page. You can style that navigation bar with the your custom css:

```css
.page-navigation a {
  margin: 0 2px;
  display: inline-block;
  padding: 3px 5px;
  color: #ffffff;
  background-color: #70b7ec;
  border-radius: 5px;
  text-decoration: none;
  font-weight: bold;
}

.page-navigation a[data-selected] {
  background-color: #3d9be0;
}
```

See [this working demo](https://wikiti-random-stuff.gitlab.io/jquery-paginate/example.html). You can see the available options in the [Advanced options](#advanced-options) section.

## Advanced options

| Option name | Default value | Description |
|--------|--------|--------|
| `limit` | `20` | Elements shown per page. |
| `initialPage` | `0` | Default selected page, being 0 the first one. |
| `previous` | `true` | *Previous* button, to move to the previous page. |
| `previousText` | `'<'` | Text for *Previous* button. Will be shown only if `previous` is `true`. |
| `next` | `true` | *Next* button, to move to the next page. |
| `nextText` | `'>'` | Text for *Next* button. Will be shown only if `next` is `true`. |
| `first` | `true` | *First* button, to move to first page. |
| `firstText` | `'>'` | Text for *First* button. Will be shown only if `first` is `true`. |
| `last` | `true` | *Last* button, to move to last page. |
| `lastText` | `'>'` | Text for *Last* button. Will be shown only if `last` is `true`. |
| `optional` | `true` | If this option is `true`, then the pagination menu will be added only if the container has more elements than the `limit` value. i.e. Will be added only if there are more than 1 page. |
| `onCreate` | `null` | A callback to be called when the pagination is initialized. Should have the following structure: `function(jquery_table_object) {}` |
| `onSelect` | `null` | A callback to be called when any page is selected. Should have the following structure: `function(jquery_table_object, current_page_index) {}` |
| `childrenSelector` | `'tbody > tr'` | A **jquery selector string** to extract the table children. This can be handy if you are working with *divs* instead of *tables*. |
| `navigationWrapper` | `null` | A **jquery object** to append the navigation bar to it. This can be used to put your navigation bar on a sticky footer, for example. If `null`, then it will be added after the table. |
| `navigationClass` | `'page-navigation'` | A **css class name** applied to the navigation menu bar. Can contain multiple classes names, separated with spaces. |
| `pageToText` | `function(i) { return (i + 1).toString(); }` | A javascript function to transform the current page index (*0...N-1*) to a string, shown in the navigation menu. |

For example, a working example with all options:

```js
$('#myTable').paginate({
  limit: 10, // 10 elements per page
  initialPage: 1, // Start on second page
  previous: true, // Show previous button
  previousText: 'Previous page', // Change previous button text
  next: true, // Show previous button
  nextText: 'Next page', // Change next button text
  first: true, // Show first button
  firstText: 'First', // Change first button text
  last: true, // Show last button
  lastText: 'Last', // Change last button text
  optional: false, // Always show the navigation menu
  onCreate: function(obj) { console.log('Pagination done!'); } // `onCreate` callback
  onSelect: function(obj, i) { console.log('Page ' + i + ' selected!'); } // `onSelect` callback
  childrenSelector: 'tbody > tr.ugly', // Paginate the rows with the `ugly` class
  navigationWrapper: $('div#myNavWrapper'), // Append the navigation menu to the `#myNavWrapper` div
  navigationClass: 'my-page-navigation', // New css class added to the navigation menu
  pageToText: function(i) { return (i + 1).toString(16); } // Page numbers will be shown on hexadecimal notation
});
```

## Authors

This project has been developed by:

| Avatar | Name | Nickname | Email |
| ------- | ------------- | --------- | ------------------ |
| ![](http://www.gravatar.com/avatar/2ae6d81e0605177ba9e17b19f54e6b6c.jpg?s=64)  | Daniel Herzog | Wikiti | [wikiti.doghound@gmail.com](mailto:wikiti.doghound@gmail.com) |
