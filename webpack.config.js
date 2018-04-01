const webpack = require('webpack')
const path = require('path');

module.exports = {
  devtool: 'source-map',
  mode: 'production',
  entry: {
    main: './src/main.js'
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
      },
      {
        test: /\.js$/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: [
              ["env", { targets: { browsers: "> 1%" } }]
            ]
          }
        }
      }
    ]
  }
};
