let spinner;
spinner = new Ora({
  text: 'Fetching Birthday Data'.green.bold,
  stream: process.stdout
});
spinner.start();