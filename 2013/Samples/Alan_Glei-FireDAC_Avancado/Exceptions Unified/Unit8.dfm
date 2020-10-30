object Form8: TForm8
  Left = 0
  Top = 0
  Caption = 'Form8'
  ClientHeight = 417
  ClientWidth = 347
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 23
  object Button1: TButton
    Left = 16
    Top = 92
    Width = 313
    Height = 50
    Caption = 'INTERBASE'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 251
    Width = 313
    Height = 50
    Caption = 'SQL SERVER'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 148
    Width = 313
    Height = 97
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object Memo2: TMemo
    Left = 16
    Top = 305
    Width = 313
    Height = 97
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 13
    Width = 249
    Height = 29
    Caption = 'EFDDBEngineException'
    TabOrder = 4
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 16
    Top = 48
    Width = 249
    Height = 29
    Caption = 'FDGUIxErrorDialog'
    Enabled = False
    TabOrder = 5
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=localhost:C:\Programacao\EC 2013\Exempos\DB\EC-2013.GDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 180
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from TesteTipos')
    Left = 152
    Top = 180
    object FDQuery1CAMPO01: TSQLTimeStampField
      FieldName = 'CAMPO01'
      Origin = 'CAMPO01'
    end
    object FDQuery1CAMPO02: TSingleField
      FieldName = 'CAMPO02'
      Origin = 'CAMPO02'
    end
    object FDQuery1CAMPO03: TFloatField
      FieldName = 'CAMPO03'
      Origin = 'CAMPO03'
    end
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 264
    Top = 180
  end
end
