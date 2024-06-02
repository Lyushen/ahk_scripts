const puppeteer = require('puppeteer');
const arg_mail = process.argv[2]
if (!arg_mail || arg_mail instanceof String)
//if (!arg_mail || isNaN(Parse(arg_mail)))
{
    console.error('enter email')
    process.exit(1)
}

(async () => {
    const browser = await puppeteer.launch({headless: false});
    const page = await browser.newPage();
    await page.goto('https://github.com/login?return_to=%2Fpuppeteer%2Fpuppeteer%2Fblob%2Fv9.1.1%2Fdocs%2Fapi.md');

    await page.waitForSelector('input[name=login]');

    // await page.type('input[name=search]', 'Adenosine triphosphate');
    //await page.$eval('input[name=login]', el => el.value = '1123213@gmail.com');
    //await page.$eval('input[name=password]', el => el.value = 'ASDGFASDDF');
    await page.type('#login_field',arg_mail)
    await page.type('#password','1123213@gmail.com')
   // await page.keyboard.press('Enter');
   await Promise.all([
    page.waitForNavigation(),
    page.click('input[type=submit]')
   ]);
    await page.waitForSelector('p[class="grid--cell s-input-message js-error-message"]');
    const text = await page.evaluate(() => {
        const anchor = document.querySelector('p[class="grid--cell s-input-message js-error-message"]');
        return anchor.textContent;
    });
    console.log(text);
    await browser.close();
})();