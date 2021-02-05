// https://stackoverflow.com/a/21961005
process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = 0;

const fetch = require('node-fetch');
const addDays = require('date-fns').addDays;

const BASE_DATE = new Date();
const METRIC_ID = process.env.METRIC_ID;
const URL = `https://localhost:4000/api/metrics/${METRIC_ID}/data`;
const LIMIT = parseInt(process.env.LIMIT);

async function doRequest (i) {
  const xValue = addDays(BASE_DATE, i);

  const yValue = Math.floor(Math.random() * 10000).toString();

  const body = {
    data: {
      type: 'datum',
      attributes: {
        xValue,
        yValue,
      },
    },
  };

  const resp = await fetch(URL, {
    method: 'POST',
    headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
    },
    body: JSON.stringify(body),
  });

  const json = await resp.json();

  if (resp.ok) {
    console.log('Created record', json.data.id);
  } else {
    console.error('ERROR:', json);
  }
}

async function delay (ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function runLoop () {
  let i = 0;

  while (true) {
    if (i === LIMIT) {
      break;
    }

    await doRequest(i);

    await delay(400);

    i++;
  }
}

runLoop();
