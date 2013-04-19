<?php
include('get_zone.php');
$test = array(
	'79087964781', '380964000000','','123456789','1234567890123456'
);
echo '<pre>';
foreach( $test as $phone ) {
	echo 'phone = '.$phone."\r\nzone = ";
	$z = get_zone( $phone );
	print_r( $z );
	echo "\r\n\r\n";
}
echo '</pre>';
?>