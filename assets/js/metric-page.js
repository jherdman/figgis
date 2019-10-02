import socket from './socket';
import MetricChart from './metric-chart';

window.addEventListener('unload', function () {
  socket.disconnect();
});

export default class MetricPage {
  static init () {
    let page = new this.prototype.constructor();

    if (page.chartTag) {
      page.setUpChart();
      page.setUpChannel();
    }

    return page;
  }

  get metricId () {
    return document.location.pathname.split('/').pop();
  }

  get chartTag () {
    return document.querySelector('.js-chart');
  }

  get spinner () {
    return document.querySelector('.js-spinner');
  }

  showData () {
    document.querySelector('.js-no-data-section').classList.add('hidden');
    document.querySelector('.js-chart-section').classList.remove('hidden');
  }

  showInstallInstructions () {
    document.querySelector('.js-no-data-section').classList.remove('hidden');
  }

  removeSpinner () {
    this.spinner.remove();
  }

  setUpChannel () {
    this.channel = socket.channel(`metric:${this.metricId}`, {});
    this.channel.join();

    this.channel.on('data', ({ data }) => {
      this.removeSpinner();

      if (data.length) {
        this.showData();

        this.chart.update(data);
      } else {
        this.showInstallInstructions();
      }
    });

    this.channel.on('new_data', (datum) => {
      this.showData();

      this.chart.update(Array(datum));
    });
  }

  setUpChart () {
    this.chart = new MetricChart(this.metricId, this.chartTag);
  }
}