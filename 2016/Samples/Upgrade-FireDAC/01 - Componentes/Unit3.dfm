object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Componentes de Acesso a Dados'
  ClientHeight = 400
  ClientWidth = 650
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
    Left = 458
    Top = 9
    Width = 184
    Height = 25
    Alignment = taRightJustify
    Caption = '0 Registro(s)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 40
    Width = 634
    Height = 305
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 8
    Top = 351
    Width = 136
    Height = 41
    Caption = 'FDTable'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 158
    Top = 351
    Width = 136
    Height = 41
    Caption = 'FDQuery'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 305
    Top = 351
    Width = 136
    Height = 41
    Caption = 'FDStroredProc'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = Button3Click
  end
  object ExtremedelphiConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=ExtremeDelphi')
    Connected = True
    LoginPrompt = False
    Left = 68
    Top = 85
  end
  object FDQuery1: TFDQuery
    Connection = ExtremedelphiConnection
    SQL.Strings = (
      'Select * From Clientes')
    Left = 72
    Top = 192
  end
  object FDTable1: TFDTable
    Connection = ExtremedelphiConnection
    UpdateOptions.UpdateTableName = 'DelphiExtreme.dbo.Clientes'
    TableName = 'DelphiExtreme.dbo.Clientes'
    Left = 72
    Top = 136
  end
  object FDStoredProc1: TFDStoredProc
    Connection = ExtremedelphiConnection
    StoredProcName = 'DelphiExtreme.dbo.SP_GetClientes'
    Left = 72
    Top = 240
    ParamData = <
      item
        Position = 1
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        ParamType = ptResult
      end>
  end
  object DataSource1: TDataSource
    Left = 256
    Top = 168
  end
end
