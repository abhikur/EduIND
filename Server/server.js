var express = require('express');
var app = express();

app.get('/', function(req,res) {
	var result = {Name:'Abhishek', last:'Thakur'};
	res.send(JSON.stringify(result));
});

app.post('/saveUser', function(req, res) {
	console.log("req url = " + req.url);
	console.log("req body = " + req.body);
	res.send("{result:'successfully saved'}");
})

app.listen(3000);