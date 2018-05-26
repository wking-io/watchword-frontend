const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const WebpackMd5Hash = require('webpack-md5-hash');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const webpack = require('webpack');

module.exports = env => {
  const elmOptions =
    env.NODE_ENV === 'production'
      ? ''
      : '?verbose=true&warn=true&forceWatch=true&debug=true';

  const cssLoader =
    env.NODE_ENV === 'production'
      ? [
          'style-loader',
          MiniCssExtractPlugin.loader,
          'css-loader',
          'postcss-loader',
          'sass-loader',
        ]
      : ['style-loader', 'css-loader', 'postcss-loader', 'sass-loader'];
  return {
    entry: { main: './src/main.js' },
    output: {
      path: path.resolve(__dirname, 'dist'),
      filename: '[name].[hash].js',
    },
    devServer: {
      contentBase: './dist',
      index: 'index.html',
      hot: true,
    },
    module: {
      noParse: /\.elm$/,
      rules: [
        {
          test: /\.js$/,
          exclude: [/elm-stuff/, /node_modules/],
          use: {
            loader: 'babel-loader',
          },
        },
        {
          test: /\.scss$/,
          use: cssLoader,
        },
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          use: {
            loader: `elm-webpack-loader${elmOptions}`,
          },
        },
        {
          test: /\.(svg|woff|woff2|eot|ttf|otf)$/,
          loader: 'url-loader',
          options: { name: 'fonts/[name].[ext]', limit: 50 },
        },
        {
          test: /\.(png|jpg|gif)$/,
          loader: 'file-loader',
          options: {
            name: '[name].[ext]',
            publicPath: '/',
            outputPath: 'assets/images/',
          },
        },
      ],
    },
    plugins: [
      new CleanWebpackPlugin('dist', {}),
      new MiniCssExtractPlugin({ filename: '[name].[contenthash].css' }),
      new HtmlWebpackPlugin({
        inject: false,
        hash: true,
        template: './src/index.html',
        filename: 'index.html',
      }),
      new WebpackMd5Hash(),
      new webpack.NamedModulesPlugin(),
      new webpack.HotModuleReplacementPlugin(),
    ],
  };
};
