import * as d3 from 'd3';
import 'whatwg-fetch';

export default class PingChart {
  constructor(selector) {
    this.selector = selector;
    this.chartEl = document.querySelector(selector);
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

  get defaults() {
    return {
      width: this.chartEl.clientWidth,
      height: 400,
      margin: {
        top: 15,
        right: 15,
        bottom: 35,
        left: 15
      },
      axis: true,
      axisPadding: 5,
      tickSize: 10,
      barPadding: this.chartEl.clientWidth < 1000 ? 5 : 10,
      ease: d3.easeLinear,
      nice: false,
      type: 'rounded'
    };
  }

  init() {
    const url = this.chartEl.getAttribute('data-url');

    this.listenForWindowResize();

    fetch(url, this.params).then(response => response.json()).then(response => {
      this.cachedResponse = response;
      this.renderChart(response);
    });
  }

  renderChart(response) {
    const [innerWidth, innerHeight] = this.dimensions();
    const { margin, tickSize, axisPadding, width, height } = this.defaults;

    this.graph = d3.select(this.selector);
    this.chartEl.innerHTML = '';

    const svg = (this.svg = this.graph
      .append('svg')
      .attr('width', width)
      .attr('height', height)
      .append('g')
      .attr('transform', `translate(${margin.left}, ${margin.top})`));

    const scaleX = (this.scaleX = d3.scaleLinear().range([0, innerWidth]));

    const scaleY = (this.scaleY = d3.scaleLinear().range([innerHeight, 0]));

    const xAxis = (this.xAxis = d3
      .axisBottom(scaleX)
      .ticks(6)
      .tickPadding(8)
      .tickFormat(time => {
        return `${time}ms`;
      })
      .tickSize(tickSize));

    svg
      .append('g')
      .attr('class', 'chart-axis chart-axis--x')
      .attr('transform', `translate(0, ${innerHeight + axisPadding})`)
      .call(xAxis);

    svg.getElements;

    this.render(response);
  }

  dimensions() {
    const defaults = this.defaults;

    return [
      defaults.width - defaults.margin.left - defaults.margin.right,
      defaults.height - defaults.margin.top - defaults.margin.bottom
    ];
  }

  renderAxis(data, options) {
    let { svg } = this;

    svg = options.animate ? svg.transition() : svg;

    svg.select('.chart-axis--x').call(this.xAxis);
  }

  renderBars(data, options) {
    const { svg, scaleX, scaleY } = this;
    const { barPadding, ease, type } = this.defaults;
    const [innerWidth, innerHeight] = this.dimensions();
    const barWidth = innerWidth / data.length - barPadding;

    const column = svg.selectAll('.chart-column').data(data);

    column.enter().append('rect').attr('class', 'chart-column');

    (options.animate
      ? svg.selectAll('.chart-column').transition().ease(ease)
      : svg.selectAll('.chart-column'))
      .attr('x', data => scaleX(data.time) - barWidth / 2)
      .attr('rx', type === 'rounded' ? barWidth / 2 : 0)
      .attr('ry', type === 'rounded' ? barWidth / 2 : 0)
      .attr('width', barWidth)
      .attr('height', innerHeight);

    column.exit().remove();

    const bar = svg.selectAll('.chart-bar').data(data);

    bar.enter().append('rect').attr('class', 'chart-bar');

    (options.animate
      ? svg.selectAll('.chart-bar').transition().ease(ease)
      : svg.selectAll('.chart-bar'))
      .attr('x', data => scaleX(data.time) - barWidth / 2)
      .attr('y', data => scaleY(data.value))
      .attr('rx', type === 'rounded' ? barWidth / 2 : 0)
      .attr('ry', type === 'rounded' ? barWidth / 2 : 0)
      .attr('width', barWidth)
      .attr('height', data => innerHeight - scaleY(data.value));

    bar.exit().remove();
  }

  render(data, options = {}) {
    const { scaleX, scaleY } = this;
    const domainX = scaleX.domain(d3.extent(data, data => data.time));
    const domainY = scaleY.domain([0, d3.max(data, data => data.value)]);

    if (this.defaults.nice) {
      domainX.nice();
      domainY.nice();
    }

    if (this.defaults.axis) {
      this.renderAxis(data, options);
    }

    this.renderBars(data, options);
  }

  listenForWindowResize() {
    const waitForFinalEvent = (() => {
      const timers = {};
      return (callback, ms, uniqueId) => {
        if (!uniqueId) {
          uniqueId = "Don't call this twice without a uniqueId";
        }
        if (timers[uniqueId]) {
          clearTimeout(timers[uniqueId]);
        }
        timers[uniqueId] = setTimeout(callback, ms);
      };
    })();

    window.onresize = () => {
      waitForFinalEvent(
        () => {
          this.renderChart(this.cachedResponse);
        },
        500,
        'response-time'
      );
    };
  }
}
