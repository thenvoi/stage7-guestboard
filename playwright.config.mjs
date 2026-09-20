import { defineConfig } from '@playwright/test';

export default defineConfig({
  testDir: './tests/browser',
  fullyParallel: false,
  workers: 1,
  retries: 0,
  reporter: [['list'], ['html', { open: 'never' }]],
  use: {
    baseURL: 'http://127.0.0.1:4174',
    viewport: { width: 1440, height: 1100 },
    screenshot: 'only-on-failure',
    trace: 'retain-on-failure',
    video: 'retain-on-failure',
  },
  webServer: {
    command: 'node server.mjs',
    env: { PORT: '4174', HOST: '127.0.0.1' },
    url: 'http://127.0.0.1:4174',
    reuseExistingServer: false,
  },
});
