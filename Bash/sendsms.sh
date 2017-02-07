#!/bin/bash
# Отправка SMS через шлюз SMSPILOT.RU на Bash
#
# ./sendsms.sh "test" "79087964781"
#
text=$1
phone=$2

# (!!!) Замените XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ
# на свой API-ключ: https://smspilot.ru/my-settings.php#api

apikey=XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ

curl -v --data-urlencode send="$text" --data-urlencode to="$phone" --data apikey="$apikey" http://smspilot.ru/api.php

# альтернативный вариант это запрос через wget, замените XYZ на свой API-ключ
# wget -q http://smspilot.ru/api.php?send=Hello&to=79087964781&apikey=XYZ"