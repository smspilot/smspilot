# SMSPILOT.RU примеры, классы, библиотеки и проекты

Примеры отправки SMS через sms-шлюз SMSPILOT.RU на разных языках программирования.

#API-1
Для отправки SMS сделайте HTTP-запрос к серверу smspilot.ru.

Пример запроса с обязательными параметрами

`http://smspilot.ru/api.php?send=test&to=79037672215&apikey=XYZ`

test - текст сообщения<br/>
to - номер телефона<br/>
apikey - берём из настроек в личном кабинете https://www.smspilot.ru/my-settings.php#api
