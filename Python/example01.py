# -*- coding: utf-8 -*-
# Отправка SMS на чистом Python через sms-шлюз SMSPILOT.RU
import urllib
import json

phone = '79037672215' # номер телефона в международном формате
text = 'проверка'; # текст сообщения
sender = 'INFORM'; #  имя отправителя из списка https://smspilot.ru/my-sender.php
# !!! Замените API-ключ на свой https://smspilot.ru/my-settings.php#api
apikey = 'XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ';

url = "http://smspilot.ru/api.php?send=%s&to=%s&from=%s&apikey=%s&format=json" % (text, phone, sender, apikey )

j = json.loads(urllib.urlopen(url).read())

if 'error' in j:
	print 'Ошибка: %s' % j.description_ru
else:
	print j
	# {u'balance': u'11908.50', u'cost': u'1.68', u'send': [{u'status': u'0', u'phone': u'79037672215', u'server_id': u'10000', u'price': u'1.68'}]}
	print 'ID: %s' % j['send'][0]['server_id']
	# ID: 10000