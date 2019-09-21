import fetch from 'node-fetch';
import expect from 'expect-puppeteer';

const ROOT_URL = 'http://localhost:4002';
const SANDBOX_URL = `${ROOT_URL}/phoenix/sandbox`;

let sandboxMeta;

describe('Project Management', function() {
  beforeEach(async function() {
    let response = await fetch(SANDBOX_URL, { method: 'POST' });
    sandboxMeta = await response.text();

    return await page.setUserAgent(sandboxMeta);
  });

  afterEach(async function() {
    return await fetch(SANDBOX_URL, {
      method: 'DELETE',
      headers: {
        'User-Agent': sandboxMeta,
      },
    });
  });

  test('CRUD operations', async function() {
    try {
      await page.goto(ROOT_URL);

      await expect(page).toClick('[data-test-selector="new-project-button"]');

      await page.waitForNavigation();

      await expect(page).toFillForm('[data-test-selector="new-project-form"]', {
        'project[name]': 'My New Project',
      });

      await expect(page).toClick('[data-test-selector="save-button"]');

      await page.waitForNavigation();

      await expect(page).toClick('[data-test-selector="new-metric-button"]');

      await expect(page).toFillForm('[data-test-selector="new-project-form"]', {
        'metric[name]': 'CSS Bundle Size',
        'metric[x_axis_label]': 'Date',
        'metric[x_axis_type]': 'date',
        'metric[y_axis_label]': 'Kilobytes',
        'metric[y_axis_type]': 'number',
      });

      await expect(page).toClick('[data-test-selector="save-button"]');

      await page.waitForNavigation();

      await expect(page).toMatch('Metric created successfully');

      await page.screenshot({ path: '__tests__/artifacts/metrics-current.png' });
    } catch (err) {
      const screenshotPath = '__tests__/artifacts/metrics-failure.png';

      await page.screenshot({ path: screenshotPath });

      console.error('Screenshot:', screenshotPath);

      throw err;
    }
  });
});
