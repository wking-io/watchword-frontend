import Elm from './app/Main.elm';
import './main.scss';

import './assets/images/cardback.jpg';

const mountNode = document.getElementById('app');
const app = Elm.Main.embed(mountNode);

if (module.hot) {
  module.hot.accept();
}
