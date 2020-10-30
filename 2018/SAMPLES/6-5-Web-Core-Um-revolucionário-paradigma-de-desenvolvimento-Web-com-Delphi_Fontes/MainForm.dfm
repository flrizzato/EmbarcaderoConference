object Form3: TForm3
  Left = 0
  Top = 0
  Width = 530
  Height = 371
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TabOrder = 1
  OnCreate = WebFormCreate
  object cbNota: TWebComboBox
    Left = 2
    Top = 2
    Width = 255
    Height = 21
    Anchors = []
    ElementClassName = 'form-control'
    HeightStyle = ssAuto
    ItemIndex = 0
    Items.Strings = (
      '0'
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10')
    TabOrder = 0
    Text = '0'
  end
  object btRegistrar: TWebButton
    Left = 2
    Top = 74
    Width = 255
    Height = 25
    Anchors = []
    Caption = 'Aguarde...'
    ElementClassName = 'btn btn-primary'
    Enabled = False
    HeightStyle = ssAuto
    TabOrder = 1
    OnClick = btRegistrarClick
  end
  object WebTimer1: TWebTimer
    Left = 264
    Top = 120
    Width = 24
    Height = 24
    Interval = 5000
    OnTimer = WebTimer1Timer
  end
  object XDataWebConnection1: TXDataWebConnection
    URL = 'http://localhost:2001/tms/nota'
    Connected = True
    Left = 48
    Top = 112
  end
  object XDataWebClient1: TXDataWebClient
    Connection = XDataWebConnection1
    OnLoad = XDataWebClient1Load
    Left = 160
    Top = 112
  end
end
