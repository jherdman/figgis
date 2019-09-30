'use strict';

module.exports = {
  launch: {
    args: [
      // Required for Docker version of Puppeteer
      process.env.CI ? '--no-sandbox' : null,
      '--disable-setuid-sandbox',
      // This will write shared memory files into /tmp instead of /dev/shm,
      // because Docker’s default for /dev/shm is 64MB
      '--disable-dev-shm-usage',
    ].filter(Boolean),
    headless: process.env.HEADLESS !== 'false',
  },
  server: {
    command: 'cd .. && MIX_ENV=test mix phx.server',
    launchTimeout: 10000,
    port: 4002,
  },
};
