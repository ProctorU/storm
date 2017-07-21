//= require ../utils/namespace

const selector = '[data-behavior="copy-to-clipboard"]';

class CopyToClipboard {
  constructor() {
    this.clipboardButtons = document.querySelectorAll(selector);
    this.clipboard = null;
  }

  init() {
    this.clipboard = new Clipboard(selector, this.bindEventListeners());

    this.clipboard.on('success', event => {
      this.showTooltip(event.trigger);
    });
  }

  bindEventListeners() {
    this.clipboardButtons.forEach(button => {
      button.addEventListener('mouseleave', this.clearTooltip);
      button.addEventListener('blur', this.clearTooltip);
    });
  }

  clearTooltip(event) {
    event.currentTarget.removeAttribute('data-balloon-visible');
    event.currentTarget.removeAttribute('data-balloon');
    event.currentTarget.removeAttribute('data-balloon-pos');
  }

  showTooltip(el) {
    el.setAttribute('data-balloon-visible', true);
    el.setAttribute('data-balloon', 'Copied!');
    el.setAttribute('data-balloon-pos', 'up');
  }
}

namespace('Storm.Globals', exports => {
  exports.CopyToClipboard = CopyToClipboard;
});
