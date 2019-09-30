// https://stackoverflow.com/a/21961005
process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = 0;

const fetch = require('node-fetch');
const { addDays } = require('date-fns');

const METRIC_ID = 'e05747a6-a8a0-46ae-8f71-42c40fc84e8b';
const URL = `https://localhost:4000/api/metrics/${METRIC_ID}/data`;
const BASE_DATE = new Date();

async function doRequest(body) {
  let resp = await fetch(URL, {
    method: 'POST',
    headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
    },
    body: JSON.stringify(body),
  });

  let json = await resp.json();

  if (resp.ok) {
    console.log('Created record', json.data.id);
  } else {
    console.error('ERROR:', json);
  }
}

for (let i = 0; i < 10; i++) {
  const yValue = addDays(BASE_DATE, i);

  const xValue = Math.floor(Math.random() * 10000).toString();

  const body = {
    data: {
      type: 'datum',
      attributes: {
        xValue,
        yValue,
      },
    },
  };

  doRequest(body);
}
