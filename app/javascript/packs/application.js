/* eslint no-console:0 */

import { namespace } from './utils/namespace';
import CopyToClipboard from './globals/CopyToClipboard';
import Pagination from './globals/Pagination';
import PingChart from './websites/PingChart';

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
      case 'users:instructions:index':
        new CopyToClipboard().init();
        break;
    }
  }
}

document.addEventListener('turbolinks:load', () => {
  new Dispatcher().route();
});
