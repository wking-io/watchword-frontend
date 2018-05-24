/**
 * Script for building application for production.
 */

import webpack from 'webpack';
import chalk from 'chalk';
import webpackDev from './webpack/webpack.dev';
import webpackProd from './webpack/webpack.prod';

// Webpack bundler with production or development configuration
process.env.NODE_ENV = process.env.NODE_ENV || 'production';
const bundler =
  process.env.NODE_ENV === 'production'
    ? webpack(webpackProd)
    : webpack(webpackDev);

console.log(chalk.blue('Generating bundle. This may take a while...'));

bundler.run((err, stats) => {
  if (err) {
    console.log(chalk.red(err));
    return 1;
  }
  console.log(chalk.green('Build was successful.'));
  return 0;
});
