import Chart from 'chart.js';
import 'chartjs-adapter-date-fns';

import socket from './socket';

const metricId = document.location.pathname.split('/').pop();

window.addEventListener('unload', function () {
  socket.disconnect();
});

const ctx = document.querySelector('.js-chart');

const chart = new Chart(ctx, {
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

const channel = socket.channel(`metric:${metricId}`, {});

channel.join();

channel.on('data', function ({ data }) {
  console.log('data received:', data);
  updateChart(chart, data);
});

channel.on('new_data', function (datum) {
  console.log('new data receieved:', datum);
  updateChart(chart, Array(datum));
});

function normalizeData({ xValue, yValue }) {
  return { x: xValue, y: yValue };
}

function updateChart(chart, data) {
  let normalizedData = data.map(normalizeData);

  chart.data.datasets.forEach(function (dataset) {
    dataset.data.push(...normalizedData);
  });

  chart.update();
}
