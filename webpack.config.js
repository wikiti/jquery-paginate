const webpack = require('webpack')
const path = require('path');

module.exports = {
  devtool: 'source-map',
  mode: 'production',
  entry: {
    main: './src/index.coffee'
  },
  output: {
    path: path.join(__dirname, 'dist'),
    filename: 'jquery-paginate.min.js'
  },
  module: {
    rules: [
      {
        test: /\.coffee$/,
        use: 'coffee-loader'
      }
    ]
  }
};
