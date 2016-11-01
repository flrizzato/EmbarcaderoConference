object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Servidor de Impress'#227'o'
  ClientHeight = 442
  ClientWidth = 574
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 13
    Width = 31
    Height = 13
    Caption = 'Porta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 142
    Height = 13
    Caption = 'Texto recebido do Mobile'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button2: TButton
    Left = 183
    Top = 30
    Width = 121
    Height = 25
    Caption = 'Imprimir Teste'
    TabOrder = 0
    OnClick = Button2Click
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 32
    Width = 169
    Height = 21
    Style = csDropDownList
    TabOrder = 1
    Items.Strings = (
      'COM1'
      'COM2'
      'COM3'
      'COM4'
      'COM5'
      'COM6')
  end
  object memTeste: TMemo
    Left = 8
    Top = 83
    Width = 558
    Height = 351
    TabOrder = 2
  end
  object Button1: TButton
    Left = 310
    Top = 30
    Width = 121
    Height = 25
    Caption = 'Imprimir Memo'
    TabOrder = 3
    OnClick = Button1Click
  end
  object TetheringManager1: TTetheringManager
    OnRequestManagerPassword = TetheringManager1RequestManagerPassword
    Password = '1234'
    Text = 'PrinterServer'
    AllowedAdapters = 'Network'
    Left = 64
    Top = 112
  end
  object TetheringAppProfile1: TTetheringAppProfile
    Manager = TetheringManager1
    Text = 'PrinterServer'
    Actions = <>
    Resources = <>
    OnResourceReceived = TetheringAppProfile1ResourceReceived
    Left = 64
    Top = 168
  end
end
