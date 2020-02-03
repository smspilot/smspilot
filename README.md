# SMSPILOT.RU примеры, классы, библиотеки и проекты

Примеры отправки SMS через sms-шлюз SMSPILOT.RU на разных языках программирования.

#API-1
Для отправки SMS сделайте HTTP-запрос к серверу smspilot.ru.

Пример запроса с обязательными параметрами

`http://smspilot.ru/api.php?send=test&to=79037672215&apikey=XYZ`

test - текст сообщения<br/>
79037672215 - номер телефона<br/>
XYZ - нужно заменить на API-ключ из настроек в личном кабинете https://smspilot.ru/my-settings.php#api


## Альтернативный PHP-клиент SMSPILOT Олега Штанко
https://github.com/xiaklizrum/smspilot-client
