const puppeteer = require('puppeteer');
const browserFetcher = puppeteer.createBrowserFetcher();
const fs = require('fs');





async function testfunc(page) {
 let steamid=1196590
 await page.goto('https://store.steampowered.com/api/appdetails?appids='+steamid);
  let gamejson = await page.evaluate(()=>{return JSON.parse(document.querySelector("body").innerText);});
  await page.waitForNavigation();
  console.log(gameinfo[1196590]["data"].short_description);
}


(async () => {//run a head
  const platforme = await browserFetcher.platform();
  const config = { ...(
      platforme === "win64" || platforme === "win32" ? { headless: false, 
        slowMo: 0, 
        ignoreHTTPSErrors: true, 
        defaultViewport: null, 
        devtools: true,
        args: [
          '--start-maximized',
          '--force-renderer-accessibility',
          '--disable-setuid-sandbox',
          '--disable-dev-shm-usage',
          '--disable-accelerated-2d-canvas',
          '--no-first-run',
          '--no-zygote',
          '--disable-notifications',
          '--timeout=5000'
        ] } :
      platforme === "linux" ? { headless: true, 
        args: [
         '--no-sandbox',
         '--disable-setuid-sandbox',
         '--disable-dev-shm-usage',
         '--disable-accelerated-2d-canvas',
         '--disable-gpu',
         '--no-first-run',
         '--no-zygote',
         '--disable-notifications',
         '--single-process',
         '--timeout=30000'
         ]} :
      {})};
    console.log(platforme);

  const browser = await puppeteer.launch(config);
  const page = await browser.newPage();
  //main(browser,page);
  testfunc(browser,page);
  })();


async function main(browser,page) {
try {

  if (fs.existsSync('cookies.json'))
  {
  console.log("cockie exist");
  const cookies = fs.readFileSync('cookies.json', 'utf8')
  const deserializedCookies = JSON.parse(cookies)
  await page.setCookie(...deserializedCookies)
  }
  await page.goto('https://store.steampowered.com/login/?redir=search', {waitUntil: 'load', timeout: 0});
try {
    await page.waitForSelector('#account_pulldown');
    console.log("cockie valid");
    } catch (error) {
    console.log("cockie not valid, perform login");
    await page.waitForSelector("#input_username")
    await page.type('#input_username',"Lyushenn1")
    await page.type('#input_password',"Tst1E0ptEzcxY4HOVipiJ3m0")
    await page.click('button[type=submit]')
    await page.waitForNavigation();
    await page.waitForSelector('#account_pulldown',{timeout: 3000}).then(() => console.log('Login: ok'));
    const cookies = await page.cookies()
    const cookieJson = JSON.stringify(cookies)
    fs.writeFileSync('cookies.json', cookieJson)
    }
 
  await page.waitForSelector("#search_results_filtered_warning_persistent"); //wait for apply steam filter
  await page.waitForSelector("#search_resultsRows > a"); //and list
  await page.click('#search_resultsRows > a:not(.ds_ignored):not(.ds_wishlist)'); //press no-hiden no-wishlisted
  await page.waitForNavigation();
  let url = await page.evaluate(() => document.location.href.includes("agecheck"));
  if (url)    { //Age check
      let rngyear = (Math.floor(Math.random() * 50) + 1950)
      await page.waitForSelector('#ageYear')
      console.log(rngyear);
      await page.select('select#ageYear',rngyear.toString());
      await page.click("[onclick='ViewProductPage()']");
      await page.waitForNavigation();
      }
  let steamid = await page.evaluate(() => document.location.href.match(/\/(app|apps|bundle)\/([0-9]+)/)[2]);
  let headerimgurl = 'https://cdn.akamai.steamstatic.com/steam/apps/'+steamid+'/header.jpg';
  await page.goto('https://store.steampowered.com/api/appdetails?appids='+steamid);
  let gamejson = await page.evaluate(()=>{return JSON.parse(document.querySelector("body").innerText);});
   
  //fs.writeFileSync('/games/'+a+'.json', gamejson)
  console.log(gamejson[1196590]["data"].short_description);
  
  
  //await page.click('*.queue_btn_ignore > *'); //press ignore

  //await page.evaluate(() => {debugger;});
  // page.on('console', (msg) => console.log('PAGE LOG:', msg.text()));
  // await page.evaluate(() => console.log(`url is ${location.href}`));
  
  //document.querySelector("div.agegate_birthday_selector")
  //agegate_birthday_selector

 } catch (error) {
  console.log(error);
  //await browser.close();
  //main(browser,page)
  
  //process.exit(0);
 }
 
 /* {RIPository
 let row=1
  while(true)
  {
    
    let checkrow2 = await page.$eval('#search_resultsRows > a:nth-child('+row+')', (elem) => elem.hasClassName("ds_wishlist"));
    console.log('Checking element '+row);
    
   if (checkrow !== true || checkrow2 !== true)
   {
    page.click('#search_resultsRows > a:nth-child('+row+')');
    break;
   }
   row++;
  }
 let checkrow = await page.$eval('#search_resultsRows > a:nth-child('+row+')', (elem) => elem.hasClassName("ds_ignored"));
 
 
 let checkrow = await page.evaluate(() => {
   return document.querySelector('#search_resultsRows > a:nth-child('+row+')').hasClassName("ds_ignored")
 });*/




 //document.querySelector("div.col.search_price.responsive_secondrow").textContent.include("Бесплатно")

  //page.click('[id^="account_pulldown"]');
  

  /*const a_price = await page.$eval('div.col.search_price.responsive_secondrow', (el) => el.innerText);
  console.log('Price: '+a_price);
  if (a_price == "Бесплатно" || "Free")
  {
    await page.click(".ds_options");
    await page.click(".ds_options_tooltip > div:nth-child(2)");
    console.log('Free is hided');
  }*/

  //await browser.close();
  //process.exit(0);}
}