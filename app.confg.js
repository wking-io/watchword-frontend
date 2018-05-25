/**
 * Stores paths used by webpack
 */
const path = require('path');

module.exports = {
  paths: {
    root: path.resolve(__dirname),
    src: path.resolve(__dirname, 'src'), // dir for source filed to compile
    build: path.resolve(__dirname, 'build'), // dir to output development build (in memory)
    dist: path.resolve(__dirname, 'dist'), // dir to output production build
  },
  entries: {
    main: path.resolve(__dirname, 'src/main.js'),
  },
};
