<?php // скрипт send.php массовая отправка с сохранением server_id и статуса
/* создайте БД pilot, и в ней таблицу:
CREATE TABLE `sms_out` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `server_id` int(10) unsigned NOT NULL,
  `phone` varchar(15) NOT NULL,
  `message` text NOT NULL,
  `zone` tinyint(3) unsigned NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `server_id` (`server_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8
*/
include('smspilot.class.php');

mysql_connect('localhost','root','');
mysql_select_db('mypilot');

$message = 'hello';
$phones = array(
	'79087964781',
	'7908111111'
);

$sms = new SMSPilot('XYZ');
$sms->send($phones,$message);

foreach( $phones as $phone) {
	$status = $sms->statusByPhone( $phone );
	$sql = "INSERT INTO sms_out SET server_id=$status[id],phone='$phone',message='$message',zone='$status[zone]', status='$status[status]'";
	mysql_query( $sql );
}
// конец скрипта send.php
?>
<?php // скрипт check.php проверка статусов, лучше настроить крон
include('smspilot.class.php');

mysql_connect('localhost','root','');
mysql_select_db('mypilot');

$sql = "SELECT server_id FROM sms_out WHERE status=0 OR status=1";
$result = mysql_query( $sql );
$ids = array();
while( $r = mysql_fetch_assoc($result) )
	$ids[] = $r['server_id'];

$sms = new SMSPilot('XYZ');
$sms->check( $ids );
foreach( $sms->status as $s) {
	$sql = "UPDATE sms_out SET status='$s[status]' WHERE server_id='$s[id]'";
	mysql_query( $sql );
}
// конец скрипта check.php
?>
<?php //скрипт status.php вывод всех текущих статусов
include('smspilot.class.php');

mysql_connect('localhost','root','');
mysql_select_db('mypilot');

$sql = 'SELECT * FROM sms_out ORDER BY id DESC';
$result = mysql_query( $sql );
echo '<table><tr><th>ID</th><th>SERVER_ID</th><th>PHONE</th><th>MESSAGE</th><th>ZONE</th><th>STATUS</th></tr>';
while( $r = mysql_fetch_assoc( $result ) )
	echo '<tr><td>'.$r['id'].'</td><td>'.$r['server_id'].'</td><td>'.$r['phone'].'</td><td>'.$r['message'].'</td><td>'.$r['zone'].'</td><td>'.$r['status'].'</td></tr>';
echo '</table>';
// конец скрипта status.php
?>