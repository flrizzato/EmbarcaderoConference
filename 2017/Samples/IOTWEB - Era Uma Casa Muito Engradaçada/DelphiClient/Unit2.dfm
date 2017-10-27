object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 419
  ClientWidth = 793
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Enviar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 0
    Top = 39
    Width = 793
    Height = 380
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 18
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 721
  end
  object Edit1: TEdit
    Left = 89
    Top = 10
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '192.168.0.135'
  end
  object Button2: TButton
    Left = 456
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Edit2: TEdit
    Left = 216
    Top = 10
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'H'
  end
  object Button3: TButton
    Left = 343
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 5
    OnClick = Button3Click
  end
  object CheckBox1: TCheckBox
    Left = 552
    Top = 8
    Width = 97
    Height = 17
    Caption = 'Recebe dados'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object ToggleSwitch1: TToggleSwitch
    Left = 672
    Top = 8
    Width = 72
    Height = 20
    TabOrder = 7
    OnClick = ToggleSwitch1Click
  end
  object IdUDPClient1: TIdUDPClient
    Host = '192.168.0.135'
    Port = 8888
    Left = 328
    Top = 184
  end
end
