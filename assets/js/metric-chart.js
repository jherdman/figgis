import Chart from 'chart.js';
import 'chartjs-adapter-date-fns';

export default class MetricChart {
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
