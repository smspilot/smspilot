<?php // Отправка нескольких SMS через SMSPILOT.RU (API-2)
// !!! Замените API-ключ на свой https://smspilot.ru/my-settings.php#api
$apikey = 'XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ';

$send = array(
	'apikey' => $apikey,
	'send' => array(
		array('from' => 'smspilot.ru', 'to' => '79087964781', 'text' => "Перенос\nстроки"),
		array('from' => 'smspilot.ru', 'to' => '79131437355', 'text' => 'Отложенная отправка', 'send_datetime' => time() + 24 * 3600),
		array('from' => 'ОШИБКА', 'to' => '791122233322', 'text' => 'Неправильное имя отправителя')
	)
);

$result = file_get_contents('http://smspilot.ru/api2.php', false, stream_context_create(array(
	'http' => array(
		'method' => 'POST',
		'header' => "Content-Type: application/json\r\n",
		'content' => json_encode( $send ),
	),
)));


echo '<pre>request data --
'.print_r( $send, true ).'

raw response --
'.$result.'

json_decode --
'.print_r( json_decode( $result ), true ).'

</pre>';