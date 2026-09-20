import { test, expect } from '@playwright/test';

// No expected-failure annotation: this must be genuinely red until the app is repaired.
test('case/space variants produce two visible cards and a count of two', async ({ page }, testInfo) => {
  await page.goto('/');
  await page.getByLabel('Guest handles').fill('Ada\n ada \nLin');
  await page.getByRole('button', { name: 'Import guests' }).click();
  await page.screenshot({ path: testInfo.outputPath('import-result.png'), fullPage: true });
  await expect(page.locator('.guest-name')).toHaveText(['ada', 'lin']);
  await expect(page.locator('#guest-count')).toHaveText('2');
});
