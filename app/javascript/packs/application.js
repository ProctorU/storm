/* eslint no-console:0 */

import { namespace } from './utils/namespace';
import CopyToClipboard from './globals/CopyToClipboard';

class Dispatcher {
  constructor() {
    this.pageName = document.body.dataset.page;
  }

  route() {
    switch (this.pageName) {
      case 'users:instructions:index':
        new CopyToClipboard().init();
        break;
    }
  }
}

document.addEventListener('turbolinks:load', () => {
  new Dispatcher().route();
});
