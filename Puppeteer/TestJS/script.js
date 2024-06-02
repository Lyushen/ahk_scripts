const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({headless: false});
  const page = await browser.newPage();
  await page.goto('https://2ip.ru/');
  await page.screenshot({ path: 'example.png' });

  await browser.close();
})();