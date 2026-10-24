# dd
const { test, expect } = require('@playwright/test');
const LoginPage = require('../pages/LoginPage');

test.only('login page opens', async ({ page }) => {
  const loginPage = new LoginPage(page);

  await loginPage.open();
  await loginPage.login();
  await loginPage.verifyProductsPage();

  const selectedProductTitles = await loginPage.addProductsToCart([
    'sauce-labs-backpack',
    'sauce-labs-bike-light',
  ]);

  console.log('Selected products:', selectedProductTitles);

  await loginPage.verifyCartCount(2);
  await loginPage.openCart();

  const cartTitles = await loginPage.getCartPageItemTitles();
  console.log('Products in cart:', cartTitles);

  expect(cartTitles).toEqual(selectedProductTitles);

  await loginPage.checkout();
  await loginPage.fillCheckoutInformation('John', 'Doe', '12345');
  await loginPage.finishCheckout();

  const orderConfirmation = await loginPage.getConfirmationText();
  console.log('Captured order confirmation:', orderConfirmation);
  expect(orderConfirmation).toBeTruthy();
});
