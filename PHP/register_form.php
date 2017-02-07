<?php

if (!session_id())
	session_start();

// !!! Замените это значение на свой API-ключ из настроек https://smspilot.ru/my-settings.php#api
$SMSPILOT_APIKEY = 'XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ';

// Можно указать зарегистрированное имя отправителя https://smspilot.ru/my-sender.php
$SMSPILOT_FROM = '';

if (isset($_POST['ajax']) && $_POST['ajax'] == 'sms_code') {
	
	$error = false;
	
	if (!isset($_POST['phone']) || !is_string($_POST['phone'])) {
		$error = 'Неправильный запрос!';
	} else if (!strlen($_POST['phone'])) {
		$error = 'Введите номер телефона!';
	} else if (!preg_match('/^\d{10,15}$/', $_POST['phone'])) {
		$error = 'Неправильный номер телефона!';
	} else {
	
		$code = rand(10000,99999);
		
		$r = file_get_contents('http://smspilot.ru/api.php?send='.$code.'&to='.$_POST['phone'].'&from='.$SMSPILOT_FROM.'&apikey='.$SMSPILOT_APIKEY);
		if (strpos($r, 'SUCCESS') === 0) { // ok?
			
			$_SESSION['sms_phone'] = $_POST['phone'];
			$_SESSION['sms_code'] = $code;
			
			die('{"success":true}');
				
		} else {
			unset($_SESSION['sms_phone']);
			unset($_SESSION['sms_code']);
			$error = 'Оператор не поддерживается!';
			// $error = $r; // для вывода подробной ошибки
		}
	}
	die('{"success":false,"error":"'.$error.'"}');
	
}

$reg_error = false;

if (isset($_POST['email'])) {
	//
}

$title = 'Пример SMSPILOT: Страница регистрации с проверкой по SMS + Twitter Bootstrap';

?><!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title><?= $title ?></title>

	<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.0/css/bootstrap-combined.min.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

  </head>

  <body>

    <div class="container">
	<div class="page-header">
		<h1><?= $title ?></h1>
	</div>
<form action="" method="post" class="form-horizontal">
		<fieldset>
			<legend>Регистрация</legend>
			<?php if ($reg_error): ?>
			<div class="alert alert-error">
				<?= $reg_error ?>
			</div>
			<?php endif; ?>
			<div class="control-group">
				<label class="control-label" for="reg_name">ФИО</label>
				<div class="controls">
					<input type="text" name="reg_name" id="reg_name" value="<?= (isset($_POST['reg_name'])) ? $_POST['reg_name'] : '' ?>" placeholder="Например, Иванов Сергей Николаевич" class="input-xlarge" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="reg_email">Эл. почта</label>
				<div class="controls">
					<input type="text" name="reg_email" id="reg_email" value="<?= (isset($_POST['reg_email'])) ? $_POST['reg_email'] : '' ?>" placeholder="Например, ivanov@mail.ru" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="reg_phone">Телефон</label>
				<div class="controls">
					<div style="position: relative">
						<div style="position: absolute; top: 6px; left: 5px">+</div>
						<input style="padding-left: 14px" type="text" name="reg_phone" id="reg_phone" value="<?= (isset($_POST['reg_phone'])) ? $_POST['reg_phone'] : '' ?>" placeholder="Например, 79121112233" />
						&nbsp;&nbsp;
						<input type="text" name="sms_code" id="sms_code" value="<?= (isset($_POST['sms_code'])) ? $_POST['sms_code'] : '' ?>" <?= (isset($_SESSION['sms_code'])) ? '' : ' style="display: none"' ?> />
						<button type="button" class="btn" name="sms_code_button" id="sms_code_button" onclick="send_sms_code('reg_phone')" <?= (isset($_SESSION['sms_code'])) ? ' style="display: none"' : '' ?>>SMS-код</button>
					</div>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="reg_phone">Пароль</label>
				<div class="controls">
					<input type="password" name="reg_password" id="reg_password" autocomplete="off" value="<?= (isset($_POST['reg_password'])) ? $_POST['reg_password'] : '' ?>" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="reg_phone">Пароль ещё раз</label>
				<div class="controls">
					<input type="password" name="reg_password2" id="reg_password2" autocomplete="off" value="<?= (isset($_POST['reg_password2'])) ? $_POST['reg_password2'] : '' ?>" />
				</div>
			</div>
			<div class="control-group">
				<div class="controls">
					<input type="submit" value="Зарегистрироваться" class="btn btn-primary" />
				</div>
			</div>
		</fieldset>
	</form>

    </div> <!-- /container -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.0/js/bootstrap.min.js"></script>
<script>
function send_sms_code( phone_id ) {
	
	var p = $('#'+phone_id).val();
	
//	if ($('#sender option[value='+p+']').length > 0)
//		return alert('Такой телефон уже добавлен!');
	
	$('#sms_code_button')[0].disabled = true
	
	$.post('register.php', {
		ajax: 'sms_code',
		phone: $('#'+phone_id).val()
	}, function(data) {
		$('#sms_code_button')[0].disabled = false;
		if (data.success) {
			$('#sms_code_button').hide();
			$('#sms_code').show().focus();
		} else {
			$('#sms_code_button').show();
			$('#sms_code').hide();
			alert( data.error );
		}
	}, 'json');
}

</script>
</body>
</html>
