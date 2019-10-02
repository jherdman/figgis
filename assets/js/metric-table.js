import parse from 'date-fns/parse';
import format from 'date-fns/format';

class MetricTable {
  constructor () {
    this.enqueuedData = [];
  }

  setUp () {
    let link = document.querySelector('.js-data-table-toggle');

    link.addEventListener('click', (event) => {
      event.preventDefault();

      link.classList.add('hidden');

      this.show();
    });
  }

  get isVisible () {
    return !this.table.classList.contains('hidden');
  }

  get template () {
    return document.querySelector('.js-datum-row-template');
  }

  get tableBody () {
    return document.querySelector('.js-data-table-body');
  }

  get table () {
    return document.querySelector('.js-data-table');
  }

  get tableSection () {
    return document.querySelector('.js-data-table-section');
  }

  show () {
    this.tableSection.classList.remove('hidden');
  }

  get xValueType () {
    return this.table.dataset.tableXType;
  }

  get yValueType () {
    return this.table.dataset.tableYType;
  }

  _formatValue(cell, value, type) {
    switch (type) {
      case 'number':
        cell.classList.add('Td--mono');
        cell.innerText = value;
        break;

      case 'date':
        let parsedValue = parse(value);
        let formattedValue = format(parsedValue, 'MMM D, YYYY, HH:mm:ss')

        let timeNode = document.createElement('time');
        timeNode.dateTime = value;
        timeNode.innerText = formattedValue;

        cell.appendChild(timeNode);
        break;

      default:
        cell.innerText = value;
        break;
    }
  }

  prepareNewRow ({ xValue, yValue }) {
    const content = this.template.content;
    const clone = document.importNode(content, true);

    const xValueCell = clone.querySelector('.js-datum-row-x-value');
    const yValueCell = clone.querySelector('.js-datum-row-y-value');

    this._formatValue(xValueCell, xValue, this.xValueType); 
    this._formatValue(yValueCell, yValue, this.yValueType);

    return clone;
  }

  update (data) {
    this.pushData(data);

    this.updateTable();
  }

  updateTable () {
    const {
      enqueuedData,
      tableBody,
    } = this;

    enqueuedData.forEach((datum) => {
      const newRow = this.prepareNewRow(datum);

      tableBody.appendChild(newRow);
    });

    this.enqueuedData = [];
  }

  pushData (data) {
    this.enqueuedData.push(...data);
  }
}

export default MetricTable;
