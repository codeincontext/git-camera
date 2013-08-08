var page = require('webpage').create();

var url = phantom.args[0]
  , destination = phantom.args[1];
console.log(JSON.stringify(phantom.args)); 

page.open(url, function () {
    page.render(destination);
    phantom.exit();
});
