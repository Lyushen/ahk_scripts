let blob = new Blob([
    'this.onmessage = function(message) {\n' +
      'postMessage(JSON.parse(message.data));\n' +
    '};'
    ], { type: "text/javascript" });
  let workerUrl = URL.createObjectURL(blob);