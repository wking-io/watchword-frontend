import Elm from './app/Main.elm';
import './main.scss';

import './assets/images/cardback.jpg';
import './assets/images/logo.png';
import './assets/images/info.png';
import './assets/images/contact.png';

const mountNode = document.getElementById('app');
const app = Elm.Main.embed(mountNode);

if (module.hot) {
  module.hot.accept();
}
