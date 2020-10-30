object Form8: TForm8
  Left = 0
  Top = 0
  Caption = 'Campo Auto Incremento'
  ClientHeight = 387
  ClientWidth = 501
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 485
    Height = 321
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 11
    Top = 335
    Width = 480
    Height = 44
    DataSource = DataSource1
    TabOrder = 1
  end
  object Ec2014Connection: TFDConnection
    Params.Strings = (
      'ConnectionDef=EC-2014')
    Connected = True
    LoginPrompt = False
    Left = 52
    Top = 35
  end
  object FDQueryVendas: TFDQuery
    Active = True
    Connection = Ec2014Connection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'GEN_VENDAS'
    UpdateOptions.AutoIncFields = 'ID'
    SQL.Strings = (
      'Select * from Vendas')
    Left = 52
    Top = 88
    object FDQueryVendasID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQueryVendasDATA: TDateField
      FieldName = 'DATA'
      Origin = 'DATA'
      Required = True
    end
    object FDQueryVendasIDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      Origin = 'IDCLIENTE'
      Required = True
    end
  end
  object DataSource1: TDataSource
    DataSet = FDQueryVendas
    Left = 56
    Top = 144
  end
end
