var express = require('express');
var bodyParser = require('body-parser');
var app = express();

app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

app.get('/', function(req,res) {
	var result = {Name:'Abhishek', last:'Thakur'};
	res.send(JSON.stringify(result));
});

app.post('/saveUser', function(req, res) {
	var data = req.body;
	res.send(JSON.stringify({result:'successfully saved : '+ data.Name}));
})

app.listen(3000);
console.log('server started');