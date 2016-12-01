object Form1: TForm1
  Left = 192
  Top = 107
  Width = 443
  Height = 673
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 112
    Width = 58
    Height = 13
    Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077
  end
  object Label2: TLabel
    Left = 8
    Top = 360
    Width = 63
    Height = 13
    Caption = 'HTTP '#1047#1072#1087#1088#1086#1089
  end
  object Label3: TLabel
    Left = 8
    Top = 488
    Width = 60
    Height = 13
    Caption = 'HTTP '#1054#1090#1074#1077#1090
  end
  object ed_from: TLabeledEdit
    Left = 8
    Top = 32
    Width = 121
    Height = 21
    EditLabel.Width = 101
    EditLabel.Height = 13
    EditLabel.Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1077#1083#1100' (from)'
    TabOrder = 0
    Text = 'smspilot.ru'
  end
  object ed_to: TLabeledEdit
    Left = 8
    Top = 80
    Width = 121
    Height = 21
    EditLabel.Width = 82
    EditLabel.Height = 13
    EditLabel.Caption = #1055#1086#1083#1091#1095#1072#1090#1077#1083#1100' (to)'
    TabOrder = 1
    Text = '79087964781'
  end
  object ed_send: TMemo
    Left = 8
    Top = 128
    Width = 417
    Height = 113
    Lines.Strings = (
      'hello')
    TabOrder = 2
  end
  object Button1: TButton
    Left = 8
    Top = 320
    Width = 145
    Height = 25
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' SMS'
    TabOrder = 3
    OnClick = Button1Click
  end
  object ed_apikey: TLabeledEdit
    Left = 8
    Top = 272
    Width = 417
    Height = 21
    EditLabel.Width = 127
    EditLabel.Height = 13
    EditLabel.Caption = #1050#1083#1102#1095' SMS '#1055#1080#1083#1086#1090' (apikey)'
    TabOrder = 4
    Text = 'XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ'
  end
  object ed_response: TMemo
    Left = 8
    Top = 504
    Width = 417
    Height = 129
    TabOrder = 5
  end
  object ed_request: TMemo
    Left = 8
    Top = 376
    Width = 417
    Height = 89
    TabOrder = 6
  end
  object Memo1: TMemo
    Left = 168
    Top = 16
    Width = 257
    Height = 105
    BorderStyle = bsNone
    Color = clBtnFace
    Lines.Strings = (
      #1055#1088#1080#1084#1077#1088' '#1086#1090#1087#1088#1072#1074#1082#1080' SMS '#1089' '#1087#1086#1084#1086#1097#1100#1102' '#1082#1086#1084#1087#1086#1085#1077#1085#1090#1072' '
      'TidHTTP '#1080#1079' '#1082#1086#1083#1083#1077#1082#1094#1080#1080' Indy'
      ''
      #1048#1089#1087#1086#1083#1100#1079#1091#1077#1090#1089#1103' '#1096#1083#1102#1079' SMS '#1055#1080#1083#1086#1090
      'http://www.smspilot.ru'
      ''
      #1040#1074#1090#1086#1088' '#1057#1077#1088#1075#1077#1081' '#1065#1091#1095#1082#1080#1085' (info@smspilot.ru)')
    TabOrder = 7
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 160
    Top = 320
  end
end
