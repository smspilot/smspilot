#!/usr/bin/perl -w
use Output;
use Socket;
$send = "Hello World!";  # текст сообщения
$to = "79087964781";  # номер телефона в международном формате
# !!! Замените API-ключ на свой https://www.smspilot.ru/my-settings.php#api
$apikey = "XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ";
$host="smspilot.ru";
$port="80";
socket(SOCK, PF_INET, SOCK_STREAM, getprotobyname('tcp'));
$iaddr = inet_aton($host);
$paddr = sockaddr_in($port, $iaddr);
connect(SOCK, $paddr);
$send =~ s/([^A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg;
send (SOCK, "GET /api.php?send=$send&to=$to&apikey=$apikey HTTP/1.0\nHOST:$host\n\n", 0);
@data=;
close(SOCK);
print $data;