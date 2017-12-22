/* eslint no-console:0 */

import { namespace } from './utils/namespace';
import CopyToClipboard from './globals/CopyToClipboard';
import Pagination from './globals/Pagination';
import PingChart from './websites/PingChart';
import Polyglot from 'node-polyglot';

class Dispatcher {
  constructor() {
    this.pageName = document.body.dataset.page;
  }

  route() {
    switch (this.pageName) {
      case 'websites:index':
        new Pagination('websites').init();
        break;
      case 'websites:response_time:index':
        new PingChart('[data-behavior="response-time-chart"]').init();
        break;
      case 'tokens:index':
      case 'users:instructions:index':
        new CopyToClipboard().init();
        break;
    }
  }

  feather() {
    feather.replace();
  }

  translate() {
    const phrases = document
      .querySelector('[data-behavior="translations"]')
      .getAttribute('data-phrases');

    window.polyglot = new Polyglot({ phrases: JSON.parse(phrases) });
  }
}

document.addEventListener('turbolinks:load', () => {
  const dispatcher = new Dispatcher();

  dispatcher.feather();
  dispatcher.route();
  dispatcher.translate();
});
