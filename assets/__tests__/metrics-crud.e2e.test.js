import fetch from 'node-fetch';

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

      await page.waitForNavigation();

      await expect(page).toFillForm('[data-test-selector="metric-form"]', {
        'metric[name]': 'CSS Bundle Size',
        'metric[description]': 'Tracks bundle size over time',
        'metric[x_axis_label]': 'Date',
        'metric[x_axis_type]': 'date',
        'metric[y_axis_label]': 'Kilobytes',
        'metric[y_axis_type]': 'number',
      });

      await expect(page).toClick('[data-test-selector="save-button"]');

      await page.waitForNavigation();

      await expect(page).toMatch('Metric created successfully');

      await expect(page).toClick('[data-test-selector="edit-metric-button"]');

      await page.waitForNavigation();

      await expect(page).toFillForm('[data-test-selector="metric-form"]', {
        'metric[name]': 'JavaScript Bundle Size',
      });

      await expect(page).toClick('[data-test-selector="save-button"]');

      await page.waitForNavigation();

      await expect(page).toMatch('Metric updated successfully');

      await expect(page).toMatch('JavaScript Bundle Size');

      await expect(page).toClick('[data-test-selector="project-link"]');

      await page.waitForNavigation();

      let metricHandles = await page.$$('[data-test-selector="metric-item"]');

      await expect(metricHandles).toHaveLength(1);

      await expect(page).toClick('[data-test-selector="metric-item"]:nth-of-type(1)');

      await page.waitForNavigation();

      await expect(page).toClick('[data-test-selector="delete-metric-button"]');

      await page.waitForNavigation();

      await expect(page).toMatch('Metric deleted successfully');

      await page.screenshot({ path: '__tests__/artifacts/metrics-final.png' });
    } catch (err) {
      const screenshotPath = '__tests__/artifacts/metrics-failure.png';

      await page.screenshot({ path: screenshotPath });

      console.error('Screenshot:', screenshotPath);

      throw err;
    }
  });

  test('with associated data', async function() {
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

      await page.waitForNavigation();

      await expect(page).toFillForm('[data-test-selector="metric-form"]', {
        'metric[name]': 'CSS Bundle Size',
        'metric[description]': 'Tracks bundle size over time',
        'metric[x_axis_label]': 'Date',
        'metric[x_axis_type]': 'date',
        'metric[y_axis_label]': 'Kilobytes',
        'metric[y_axis_type]': 'number',
      });

      await expect(page).toClick('[data-test-selector="save-button"]');

      await page.waitForNavigation();

      await expect(page).toMatch('Metric created successfully');

      await page.screenshot({ path: '__tests__/artifacts/metrics-with-data-current.png' });
    } catch (err) {
      const screenshotPath = '__tests__/artifacts/metrics-with-data-failure.png';

      await page.screenshot({ path: screenshotPath });

      console.error('Screenshot:', screenshotPath);

      throw err;
    }
  });
});
