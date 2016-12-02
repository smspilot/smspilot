require 'net/http'
require 'json'
uri = URI('http://smspilot.ru/api.php')
params = {
	:send => 'проверка', # текст сообщения
	:to => '79087964781', # номер телефона в международном формате
	# !!! Замените API-ключ на свой https://www.smspilot.ru/my-settings.php#api
	:apikey => 'XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ',
	:format => 'json'
}
uri.query = URI.encode_www_form(params)

res = Net::HTTP.get_response(uri)
j = JSON.parse( res.body )
puts j
if ( j['error'] )
	puts j['error']['description_ru']
else
	puts j['send'][0]['server_id'] # id сообщения
end