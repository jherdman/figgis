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

      await expect(page).toMatch('My New Project');

      await expect(page).toMatch('Project created successfully');

      await expect(page).toClick('[data-test-selector="edit-project"]');

      await page.waitForNavigation();

      await expect(page).toFillForm('[data-test-selector="new-project-form"]', {
        'project[name]': 'My Updated Project',
      });

      await expect(page).toClick('[data-test-selector="save-button"]');

      await page.waitForNavigation();

      await expect(page).toMatch('Project updated successfully');

      await expect(page).toMatch('My Updated Project');

      await expect(page).toClick('[data-test-selector="delete-project"]');

      await page.waitForNavigation();

      await page.screenshot({ path: '__tests__/artifacts/project-final.png' });

      await expect(page).toMatch('Project deleted successfully');
    } catch (err) {
      const screenshotPath = '__tests__/artifacts/project-failure.png';

      await page.screenshot({ path: screenshotPath });

      console.error('Screenshot:', screenshotPath);

      throw err;
    }
  });
});
