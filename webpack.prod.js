/**
 * Webpack configuration for production
 */
const UglifyJsWebpackPlugin = require('uglifyjs-webpack-plugin');
const ExtractTextWebpackPlugin = require('extract-text-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const Webpack = require('webpack');
const merge = require('webpack-merge');
const common = require('./webpack.common');
const AppConfig = require('./app.confg');

module.exports = merge.smart(common, {
  mode: 'production',
  // let's include source map for easier debugging
  devtool: 'source-map',
  entry: { main: AppConfig.entries.main },
  output: {
    publicPath: './',
    path: AppConfig.paths.dist,
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        // extracts bundled css into separate stylesheet
        use: ExtractTextWebpackPlugin.extract({
          use: [
            {
              loader: 'css-loader',
            },
            {
              loader: 'sass-loader',
            },
          ],
          // use style-loader in development
          fallback: 'style-loader',
        }),
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: {
          loader: 'elm-webpack-loader',
        },
      },
    ],
  },
  plugins: [
    // clean distribution folder
    new CleanWebpackPlugin(['dist']),
    // file to extract css
    new ExtractTextWebpackPlugin('[name].css'),
    // minimize JavaScript file
    new UglifyJsWebpackPlugin({ sourceMap: true }),
    // minimize css
    new Webpack.LoaderOptionsPlugin({ debug: false, minimize: true }),
  ],
});
