<?php
// hlr_callback.php
// Сюда приходит статус HLR-запроса
// Пишем данные в лог, поэтому создайте hlr.log в папке скрипта и дайте права на запись
file_put_contents( __DIR__ . '/hlr.log', "\r\n_GET = ".print_r( $_GET, true), FILE_APPEND );