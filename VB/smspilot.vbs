' SMS через SMSPILOT.RU
Phone = "79087964781"

' Для поддержки кириллицы нужен очень длинный скрипт, поэтому используем транслит
Text = "Otpravka SMS cherez SMSPILOT WSH VBS"

' (!!!) Замените на свой API-ключ https://www.smspilot.ru/my-settings.php#api
APIKEY = "XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ"


Set HttpReq = CreateObject("WinHttp.WinHttpRequest.5.1")

URL = "http://smspilot.ru/api.php"
URL = URL & "?send=" & Replace(Text," ", "%20")
URL = URL & "&to=" & Phone

' Своя подпись
' URL = URL & "&from=smspilot"

URL = URL & "&apikey=" & APIKEY

If HttpReq.Open("GET", URL, False) <> 0 Then
  wscript.echo "Connection error"
ElseIf HttpReq.Send() <> 0 Then
  wscript.echo "Open URL " & URL & " error"
Else
  wscript.echo HttpReq.responseText
End If