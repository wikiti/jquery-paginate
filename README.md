# jQuery paginate

## Summary

`jquery-paginate` is a simple [`jquery`](https://jquery.com/) plugin that allows html websites to paginate tables and other kind of containers.

A working example can be found [here](https://wikiti.github.io/jquery-paginate/).

## Installation

Install this package as a bower dependecy with:

```
bower install jquery-paginate
```

or with:

```
npm install jquery-paginate
```

or download the `jquery-paginate.min.js` file and include it in your website:

```html
<!-- Add it after your jquery file! -->
<script src='jquery.min.js'></script>
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
      <td>Row 1 Col 1</td>
      <td>Row 1 Col 2</td>
    </tr>
    <tr>
      <td>Row 2 Col 1</td>
      <td>Row 2 Col 2</td>
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
| `previous` | `'<'` | *Previous* button, to move to the previous page. Set to `null ` or `undefined` to disable it. |
| `next` | `'>'` | *Next* button, to move to the next page. Set to `null ` or `undefined` to disable it. |
| `first` | `'<<'` | *First* button, to move to first page. Set to `null ` or `undefined` to disable it. |
| `last` | `'>>'` | *Last* button, to move to last page. Set to `null ` or `undefined` to disable it. |
| `optional` | `true` | If this option is `true`, then the pagination menu will be added only if the container has more elements than the `limit` value. i.e. Will be added only if there are more than 1 page. |
| `childrenSelector` | `'tbody > tr'` | A **jquery selector string** to extract the table children. This can be handy if you are working with *divs* instead of *tables*. |
| `navigationParent` | `null` | A **jquery object** o **css selector** to append the navigation bar to. This can be used to put your navigation bar on a sticky footer, for example. If `null`, the navigation bar will be added after the table element. |
| `pageToText` | `function(i) { return (i + 1).toString(); }` | A javascript function to transform the current page index (*0...N-1*) to a string, shown in the navigation menu. |

For example, a working example with all options:

```js
'TODO'
```

## Events

This library supports some jQuery events:

```
| Event name | Description |
| ---------- | ----------- |
| `jp:create` | The pagination is initialized. |
| `jp:change` | A new page is selected. The new page and the old page are passed as arguments. |

For example:

```js
$('#myTable').paginate(/* ... */)

$('#myTable').on('jp:created', function(event) {
  console.log('Pagination was set up')
})

$('#myTable').on('jp:select', function(event, newPage, oldPage) {
  console.log('Page changed from ' + oldPage + ' to ' + newPage)
})
```

## Development

First, install the project's dependencies:

```
npm install
```

To keep building the files with each change (i.e. _watching_ them), use the `dev` script:

```
npm run dev
```

To simply build the production minified files, use the `build` script:

```
npm run build
```

Build files will be placed on `dist/`.

## Authors

This project has been developed by:

| Avatar | Name | Nickname | Email |
| ------- | ------------- | --------- | ------------------ |
| ![](http://www.gravatar.com/avatar/2ae6d81e0605177ba9e17b19f54e6b6c.jpg?s=64)  | Daniel Herzog | Wikiti | [wikiti.doghound@gmail.com](mailto:wikiti.doghound@gmail.com) |
