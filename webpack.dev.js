/**
 * Webpack configuration for development.
 */
const webpack = require('webpack');
const merge = require('webpack-merge');
const common = require('./webpack.common');
const AppConfig = require('./app.confg');

module.exports = merge.smart(common, {
  mode: 'development',
  devtool: 'inline-source-map',
  entry: {
    main: [
      // This is the main entry
      AppConfig.entries.main,
    ],
  },
  devServer: {
    contentBase: AppConfig.paths.build,
    index: 'index.html',
    hot: true,
  },
  output: {
    publicPath: '/build',
    // Output files in the build directory in the memory
    path: AppConfig.paths.build,
  },
  plugins: [
    // Both plugins are needed for hot reloading
    new webpack.NoEmitOnErrorsPlugin(),
    new webpack.NamedModulesPlugin(),
    new webpack.HotModuleReplacementPlugin(),
  ],
});
