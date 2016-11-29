<?php
// Скрипт простой формы для отправки SMS через шлюз http://www.smspilot.ru/

// включаем отображение всех ошибок
ini_set('error_reporting', E_ALL );
ini_set('display_errors', true );

// загружаем настройки
require_once __DIR__ . '/smspilot.config.php';

// выводим шапку страницы с формой
echo '<html><head><title>SMSPILOT.RU SMS</title></head><h1>Отправить SMS через шлюз <a href="http://www.smspilot.ru/">SMSPILOT.RU</a></h1>';

// если нажата кнопка "Отправить SMS"
if ( isset($_POST['phone'], $_POST['text']) ) {
	$error = false;
	// введен телефон?
	if ( $_POST['phone'] === '' ) {
		$error .= 'Введите телефон!<br/>';
	}
	if ( $_POST['text'] === '' ) {
		$error .= 'Введите текст сообщения!<br/>';
	}

	if ( !$error ) {

		// собираем URL для отправки sms http://www.smspilot.ru/apikey.php
		$api_url = 'http://smspilot.ru/api.php'
			. '?send=' . urlencode($_POST['text'])
			. '&to=' . urlencode($_POST['phone'])
			. '&from=' . SMSPILOT_FROM
			. '&apikey=' . SMSPILOT_APIKEY
			. '&format=json';
		echo '<pre>'.$api_url.'</pre>';
		// получили JSON ответ
		$json = file_get_contents($api_url);
		echo '<pre>'.$json.'</pre>';
		if ($json) {
			// преобразуем его в массив
			$j = json_decode($json, true);
			// если вернулась ошибка то выводим ее стандартной функцией
			if (isset($j['error'])) {
				$error = '[smspilot] '.$j['error']['description_ru'];
			} else {
				// $j['send'][0]['server_id'] - хранить ID сообщений
				echo '<p style="color: green">Сообщение отправлено, можно <a href="?check=' . $j['send'][0]['server_id'] . '" target="_blank">проверить статус</a>.</p>';
			}
		} else {
			$error = 'Ошибка интернет соединения!';
		}
	}
	if ( $error ) {
		echo '<p style="color: red">'.$error.'</p>';
	}
}

// проверка статуса
if ( isset($_GET['check']) && ctype_digit( $_GET['check']) ) {
	// собираем URL для проверки статуса sms http://www.smspilot.ru/apikey.php
	$api_url = 'http://smspilot.ru/api.php'
		. '?check=' . $_GET['check']
		. '&apikey=' . SMSPILOT_APIKEY
		. '&format=json';
	echo '<pre>'.$api_url.'</pre>';
	$json = file_get_contents($api_url);
	echo '<pre>'.$json.'</pre>';
	if ($json) {
		// преобразуем его в массив
		$j = json_decode($json, true);
		// если вернулась ошибка то выводим ее стандартной функцией
		if (isset($j['error'])) {
			$error = '[smspilot] '.$j['error']['description_ru'];
		} else {
			$s = array(
				-2 => 'Ошибка',
				-1 => 'Не доставлено',
				0 => 'Новое',
				1 => 'В очереди',
				2 => 'Доставлено'
			);
			echo '<p>Телефон '.$j['check'][0]['phone'].', статус: '.$s[ $j['check'][0]['status'] ].'</p>';
		}
	} else {
		$error = 'Ошибка интернет соединения!';
	}

}
// html форма для отправки SMS
echo '<form action="send_sms.php" method="POST">
<table cellpadding="5">
	<tr><th>Телефон</th><td><input type="text" name="phone" size="40" value="'.((isset($_POST['phone'])) ? $_POST['phone'] : '').'" /> напр. 79999999999</td></tr>
	<tr><th>Текст</th><td><textarea name="text" cols="60" rows="4">'.((isset($_POST['text'])) ? $_POST['text'] : 'проверка').'</textarea></td></tr>
	<tr><th>&nbsp;</th><td><input type="submit" value="Отправить SMS" /></td></tr>
</table>
</form>';

echo '</body></html>';