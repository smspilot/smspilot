Sub Кнопка1_Щелчок()

If SMS("79087964781", "Привет") Then MsgBox ("Сообщение отправлено") Else MsgBox SMSError()

End Sub

' Собственнно функция для отправки SMS http://www.smspilot.ru/apikey.php
Public Function SMS(Phone As String, Text As String) As Boolean

  SMS = False

  Set HttpReq = CreateObject("WinHttp.WinHttpRequest.5.1")

  URL = "http://smspilot.ru/api.php"
  URL = URL & "?send=" & URLEncode(Text)
  URL = URL & "&to=" & Phone

  ' Своя подпись
  ' URL = URL & "&from="

  ' (!) Замените на свой API-ключ https://www.smspilot.ru/my-settings.php#api
  URL = URL & "&apikey=XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ"

  URL = URL & "&charset=windows-1251"

  If HttpReq.Open("GET", URL, False) <> 0 Then
    SMSError ("Connection error")
    Exit Function
  End If
  If HttpReq.Send() <> 0 Then
    SMSError ("Open URL " & URL & " error")
    Exit Function
  End If

  If Left$(HttpReq.responseText, 7) <> "SUCCESS" Then
    SMSError (HttpReq.responseText)
    Exit Function
  End If

  SMS = True
  SMSError ("")

End Function


' Функция для хранения последней ошибки
Public Function SMSError(Optional SetErr As String = "") As String
    Static Err
    If SetErr <> "" Then Err = SetErr
    SMSError = Err
End Function


' Кодирование URL параметров http://ru.wikipedia.org/wiki/URL
Public Function URLEncode(StringVal As String, Optional SpaceAsPlus As Boolean = False) As String

  Dim StringLen As Long: StringLen = Len(StringVal)

  If StringLen > 0 Then
    ReDim result(StringLen) As String
    Dim i As Long, CharCode As Integer
    Dim Char As String, Space As String

    If SpaceAsPlus Then Space = "+" Else Space = "%20"

    For i = 1 To StringLen
      Char = Mid$(StringVal, i, 1)
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
