' SMS через SMSPILOT.RU
Phone = "79087964781"
Text = "Otpravka SMSPILOT WSH VBS"
APIKEY = "6512BD43D9CAA6E02C990B0A82652DCAD645920E395FEDAD7BBBED0ECA3FE2E0"

SMS = False

Set HttpReq = CreateObject("WinHttp.WinHttpRequest.5.1")

URL = "http://smspilot.ru/api.php"
URL = URL & "?send=" & Replace(Text," ", "%20")
URL = URL & "&to=" & Phone

' Своя подпись
' URL = URL & "&from=smspilot"

' (!) Замените на свой API-ключ
URL = URL & "&apikey=" & APIKEY

If HttpReq.Open("GET", URL, False) <> 0 Then
  wscript.echo "Connection error"
ElseIf HttpReq.Send() <> 0 Then
  wscript.echo "Open URL " & URL & " error"
Else
  wscript.echo HttpReq.responseText
End If