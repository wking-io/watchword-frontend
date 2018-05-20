/**
 * Stores paths used by webpack
 */
import path from 'path';

const AppConfig = {
  paths: {
    root: path.resolve(__dirname),
    src: path.resolve(__dirname, 'src'), // dir for source filed to compile
    build: path.resolve(__dirname, 'build'), // dir to output development build (in memory)
    dist: path.resolve(__dirname, 'dist'), // dir to output production build
  },
  entries: {
    frontend: path.resolve(__dirname, 'src/frontend/main.js'),
    backend: path.resolve(__dirname, 'src/backend/main.js')
  },
};

export default AppConfig;
