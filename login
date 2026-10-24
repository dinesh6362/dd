const { test, expect } = require('@playwright/test');

test('login page opens', async ({ page }) => {
  await page.goto('https://www.saucedemo.com');
  await expect(page).toHaveTitle('Swag Labs');
});