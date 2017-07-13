<?php
// send_hlr.php
// Асинхронно отправляем HLR-запрос оператору, чтобы выяснить обслуживается данный номер или уже нет

$phone = '79999999999'; // замените на свой телефон
$callback  = 'http://example.com/hlr_callback.php'; // замените на свой скрипт для приёма статуса запроса
$apikey = 'XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ'; // замените на свой API-ключ https://smspilot.ru/my-settings.php#api

$json = file_get_contents('http://smspilot.ru/api.php?send=HLR&to='.urlencode($phone).'&apikey='.$apikey.'&callback='.urlencode($callback).'&format=json' );

$j = json_decode( $json );
if ( !isset($j->error) ) {
	echo 'HLR запрос успешно отправлен';
} else {
	trigger_error( $j->description_ru, E_USER_WARNING );
}