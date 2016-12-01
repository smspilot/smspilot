// отправка SMS на чистой Node
var http                = require('http');
var querystring         = require('querystring');

var phone = '79037672215'; // номер телефона
var text = 'проверка'; // текст
var from = ''; // имя отправителя из списка https://www.smspilot.ru/my-sender.php
// !!! Замените API-ключ на свой https://www.smspilot.ru/my-settings.php#api
var apikey = 'XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ';
var uri = [
	'http://smspilot.ru/api.php',
	'?send=', querystring.escape( text ),
	'&to=', phone,
	'&from=', from,
	'&apikey=', apikey,
	'&format=json'
].join('');

http.get(uri, function(res) {
	var str = ''
	res.on('data', function (chunk) {
		str += chunk;
	});

	res.on('end', function () {
		console.log('ответ сервера: '+str);
		var parsedData = JSON.parse(str);
		console.log('server_id='+parsedData.send[0].server_id);
	});

}).on('error', function(err) {
	console.log('ошибка сети '+err);
});