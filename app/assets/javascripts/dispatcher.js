//= require ./utils/namespace

namespace('Storm', exports => {
  exports.Dispatcher = class Dispatcher {
    constructor() {
      this.pageName = document.body.dataset.page;
    }

    route() {
      switch (this.pageName) {
        case 'users:instructions:index':
          new Storm.Globals.CopyToClipboard().init();
          break;
      }
    }
  };
});

document.addEventListener('turbolinks:load', () => {
  new Storm.Dispatcher().route();
});
