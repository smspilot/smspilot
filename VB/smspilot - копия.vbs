' Собственнно функция для отправки SMS http://www.smspilot.ru/apikey.php
Phone = "79087964781"
Text = "Отправка SMS через SMSPILOT WSH VBS"
APIKEY = "6512BD43D9CAA6E02C990B0A82652DCAD645920E395FEDAD7BBBED0ECA3FE2E0"

  SMS = False
  
  Set HttpReq = CreateObject("WinHttp.WinHttpRequest.5.1")
  
  URL = "http://smspilot.ru/api.php"
  URL = URL & "?send=" & URLEncode(Text)
  URL = URL & "&to=" & Phone
  
  ' Своя подпись
  ' URL = URL & "&from=smspilot"
  
  ' (!) Замените на свой API-ключ
  URL = URL & "&apikey=" & APIKEY
  
  URL = URL & "&charset=windows-1251"
  
  If HttpReq.Open("GET", URL, False) <> 0 Then
    wscript.echo "Connection error"
  Else If HttpReq.Send() <> 0 Then
    wscript.echo "Open URL " & URL & " error"
  Else
    wscript.echo HttpReq.responseText


' Кодирование URL параметров http://ru.wikipedia.org/wiki/URL
Function URLEncode(StringVal)

  StringLen = Len(StringVal)

  If StringLen > 0 Then
'    ReDim result(StringLen) As String
'    Dim i As Long, CharCode As Integer
'    Dim Char As String, Space As String

    If False Then Space = "+" Else Space = "%20"

    For i = 1 To StringLen
      Char = Mid(StringVal, i, 1)
      CharCode = Asc(Char)
      Select Case CharCode
        Case 97 To 122, 65 To 90, 48 To 57, 45, 46, 95, 126
          result(i) = Char
        Case 32
          result(i) = Space
        Case 0 To 15
          result(i) = "%0" & Hex(CharCode)
        Case Else
          result(i) = "%" & Hex(CharCode)
      End Select
    Next i
    URLEncode = Join(result, "")
  End If
End Function