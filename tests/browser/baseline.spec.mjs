import { test, expect } from '@playwright/test';

test('renders a real board, imports distinct guests, and resets', async ({ page }, testInfo) => {
  await page.goto('/');
  await expect(page.getByRole('heading', { name: 'Make room for everyone.' })).toBeVisible();
  await expect(page.locator('.guest-card')).toHaveCount(6);
  await page.getByLabel('Guest handles').fill('Maya\nLin');
  await page.getByRole('button', { name: 'Import guests' }).click();
  await expect(page.locator('.guest-name')).toHaveText(['maya', 'lin']);
  await expect(page.locator('#guest-count')).toHaveText('2');
  await page.getByRole('button', { name: 'Reset demo' }).click();
  await expect(page.locator('.guest-card')).toHaveCount(6);
  await page.screenshot({ path: testInfo.outputPath('board-desktop.png'), fullPage: true });
});

test('empty import renders an empty state', async ({ page }) => {
  await page.goto('/');
  await page.getByLabel('Guest handles').fill(' \n ');
  await page.getByRole('button', { name: 'Import guests' }).click();
  await expect(page.locator('.guest-card')).toHaveCount(0);
  await expect(page.getByRole('heading', { name: 'The room is yours.' })).toBeVisible();
});

test('treats guest handles as text, not markup', async ({ page }) => {
  await page.goto('/');
  await page.getByLabel('Guest handles').fill('<img src=x onerror=alert(1)>');
  await page.getByRole('button', { name: 'Import guests' }).click();
  await expect(page.locator('.guest-name')).toHaveText('<img src=x onerror=alert(1)>');
  await expect(page.locator('.guest-card img')).toHaveCount(0);
});

test('invalid input leaves the previous board intact', async ({ page }) => {
  await page.goto('/');
  await page.getByLabel('Guest handles').fill('a'.repeat(41));
  await page.getByRole('button', { name: 'Import guests' }).click();
  await expect(page.getByRole('alert')).toHaveText('Keep each guest handle under 41 characters.');
  await expect(page.locator('.guest-card')).toHaveCount(6);
});

test('small screen has reachable controls without horizontal overflow', async ({ page }, testInfo) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto('/');
  await expect(page.getByRole('button', { name: 'Import guests' })).toBeVisible();
  expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
  await page.screenshot({ path: testInfo.outputPath('board-mobile.png'), fullPage: true });
});

test('imports from the keyboard and announces the result', async ({ page }) => {
  await page.goto('/');
  await page.getByLabel('Guest handles').fill('Ada\nLin');
  await page.getByLabel('Guest handles').press('Tab');
  await page.keyboard.press('Enter');
  await expect(page.getByRole('status')).toContainText('2 guests imported.');
});
