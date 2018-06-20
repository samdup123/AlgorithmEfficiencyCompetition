const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const exec = require('child_process').exec;
const path = require('path');

app.get('/', (req, res) => {
  res.sendFile(path.resolve('../../web/build/index.html'));
});

app.post('/apicalllog', (req, res) => {
  console.log(req.body);
  const filePath = path.normalize(path.normalize(path.join(__dirname, '../sandbox_stub.lua')));
  const sandbox = exec('lua ' + filePath, (_, stdout, stderr) => {
    console.log(stdout);
      res.send({ apiCalls: JSON.parse(stdout) });
    });
});

app.listen(process.env.PORT || 8080, () => console.log('Example app listening on port 3000!'))
