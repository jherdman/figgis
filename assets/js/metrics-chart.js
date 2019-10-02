import Chart from 'chart.js';
import 'chartjs-adapter-date-fns';

import socket from './socket';

window.addEventListener('unload', function () {
  socket.disconnect();
});

class MetricsPage {
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
    this.chart = new MetricsChart(this.metricId, this.chartTag);
  }
}

class MetricsChart {
  constructor(id, ctx) {
    this.id = id;

    this.chart = new Chart(ctx, {
      type: 'line',
      data: {
        datasets: [
          {
            data: [],
            backgroundColor: '#e9d8fd',
            borderColor: '#6b46c1',
            label: 'Change over time',
          },
        ],
      },
      options: {
        title: {
          display: false,
        },
        scales: {
          xAxes: [{
            type: 'time',
            time: {
              unit: 'day',
            },
          }],
        },
      },
    });
  }

  normalizeData({ xValue, yValue }) {
    return { x: xValue, y: yValue };
  }

  update(data) {
    let normalizedData = data.map(this.normalizeData);

    this.chart.data.datasets.forEach(function (dataset) {
      dataset.data.push(...normalizedData);
    });

    this.chart.update();
  }
}

document.addEventListener('DOMContentLoaded', function () {
  MetricsPage.init();
});
