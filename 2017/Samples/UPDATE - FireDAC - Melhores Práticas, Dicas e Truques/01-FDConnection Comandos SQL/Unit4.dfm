object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 260
  ClientWidth = 723
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 23
  object Button1: TButton
    Left = 8
    Top = 16
    Width = 169
    Height = 41
    Caption = 'Comandos DDL'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 63
    Width = 169
    Height = 41
    Caption = 'Insert direto'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 110
    Width = 169
    Height = 41
    Caption = 'Insert par'#226'metro'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 200
    Top = 21
    Width = 89
    Height = 31
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 295
    Top = 21
    Width = 418
    Height = 31
    TabOrder = 4
  end
  object Button4: TButton
    Left = 8
    Top = 204
    Width = 169
    Height = 41
    Caption = 'Resultset'
    TabOrder = 5
    OnClick = Button4Click
  end
  object DBGrid1: TDBGrid
    Left = 200
    Top = 63
    Width = 513
    Height = 182
    DataSource = DataSource1
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -19
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button5: TButton
    Left = 8
    Top = 157
    Width = 169
    Height = 41
    Caption = 'ExecScalar'
    TabOrder = 7
    OnClick = Button5Click
  end
  object Conexao: TFDConnection
    Params.Strings = (
      'ConnectionDef=CursoFireDAC')
    ResourceOptions.AssignedValues = [rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    LoginPrompt = False
    Left = 540
    Top = 104
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 344
    Top = 120
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 432
    Top = 112
  end
end
