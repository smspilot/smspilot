// Отправка SMS на чистой Node.js через API-2 sms-шлюза SMSPILOT.RU
var http = require("http");

apikey = 'XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ';
from = '';
to = '79087964781';
text = 'Привет!\nВторая строка!';

var data = JSON.stringify({
		apikey: apikey,
		send: [
			{from: from, to: to, text: text}
		]
	});

var request = http.request({
	host: 'smspilot.ru',
	port: 80,
	path: '/api2.php',
	method: 'POST',
	headers: {
		'Content-Type': 'application/json',
		'Content-Length': Buffer.byteLength(data, 'utf8'),
	}
}, function(res) {
	console.log('STATUS: ' + res.statusCode);
	console.log('HEADERS: ' + JSON.stringify(res.headers));
	res.setEncoding('utf8');
	res.on('data', function (chunk) {
		console.log('BODY: ' + chunk);
	});
});

request.on('error', function(e) {
	console.log('Problem with request: ' + e.message);
});
request.end(data);
//request.end(data);