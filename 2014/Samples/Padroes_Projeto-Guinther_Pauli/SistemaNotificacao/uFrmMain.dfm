object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Notifica'#231#227'o'
  ClientHeight = 210
  ClientWidth = 422
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object edtMensagem: TEdit
    Left = 32
    Top = 24
    Width = 225
    Height = 21
    TabOrder = 0
  end
  object btnNotificar: TButton
    Left = 32
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Notificar'
    TabOrder = 1
    OnClick = btnNotificarClick
  end
  object cmbFormaEnvio: TComboBox
    Left = 32
    Top = 112
    Width = 129
    Height = 21
    TabOrder = 2
    Items.Strings = (
      'Email'
      'SMS'
      'VoiceMail'
      'FAX')
  end
end
