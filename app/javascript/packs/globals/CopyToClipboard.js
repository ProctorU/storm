const selector = '[data-behavior="copy-to-clipboard"]';

export default class CopyToClipboard {
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
      let title = button.getAttribute('title');
      button.addEventListener('mouseleave', this.revertTooltipTitle.bind(this, title));
    });
  }

  revertTooltipTitle(title, event) {
    setTimeout(() => {
      event.target.setAttribute('title', title);
    }, 380);
  }

  showTooltip(el) {
    el.setAttribute('title', polyglot.t('base.copied'));
  }
}
