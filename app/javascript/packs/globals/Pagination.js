import 'whatwg-fetch';

const loadMoreSelector = '[data-behavior="load-more"]';
const paginationWrapperSelector = '[data-behavior="pagination-wrapper"]';

export default class Pagination {
  constructor(resource) {
    this.resourceWrapperEl = document.querySelector(
      `[data-behavior="${resource}-list"]`
    );
    this.paginationWrapperEl = document.querySelector(
      paginationWrapperSelector
    );

    this.handleClick = this.handleClick.bind(this);
  }

  get params() {
    const token = document
      .querySelector('[name="csrf-token"]')
      .getAttribute('content');

    return {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        Accept: 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-Token': token
      },
      credentials: 'same-origin'
    };
  }

  init() {
    this.bindEventListeners();
  }

  bindEventListeners() {
    // account for dynamic appended elements to the DOM.
    document.body.addEventListener('click', event => {
      if (event.target.getAttribute('data-behavior') === 'load-more') {
        this.handleClick(event);
      }
    });
  }

  handleClick(event) {
    event.preventDefault();

    const target = event.target;
    this.addLoadingText(target);
    this.fetchNextPage(target);
  }

  addLoadingText(el) {
    this.cachedText = el.textContent;
    el.textContent = 'Fetching...';
    el.setAttribute('disabled', true);
  }

  removeLoadingText(el) {
    el.textContent = this.cachedText;
    el.removeAttribute('disabled');
  }

  fetchNextPage(el) {
    const nextUrl = el.getAttribute('data-url');

    fetch(nextUrl, this.params)
      .then(response => {
        this.removeLoadingText(el);

        return response.json();
      })
      .then(response => {
        this.resourceWrapperEl.insertAdjacentHTML('beforeend', response.next);
        this.paginationWrapperEl.innerHTML = response.link;
      })
      .catch(ex => {
        console.log('Failed to load next page of results', ex);
      });
  }
}
