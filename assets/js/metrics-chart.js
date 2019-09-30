import Chart from 'chart.js';
import 'chartjs-adapter-date-fns';

document.addEventListener('DOMContentLoaded', function () {
  const ctx = document.querySelector('.js-chart');

  if (!ctx) {
    return;
  }

  const datumRows = document.querySelectorAll('.js-datum-row');
  const data = [];

  datumRows.forEach(function (row) {
    data.push({
      t: row.dataset.xValue,
      y: row.dataset.yValue,
    });
  });

  // eslint-disable-next-line no-new
  new Chart(ctx, {
    type: 'line',
    data: {
      datasets: [
        {
          data,
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
});
