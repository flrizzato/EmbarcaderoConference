object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 327
  ClientWidth = 885
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 23
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 105
    Height = 33
    Caption = 'ExecSQL'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 47
    Width = 869
    Height = 226
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -19
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'IdCliente'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nome'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Logradouro'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Numero'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IdBairro'
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 279
    Width = 432
    Height = 33
    DataSource = DataSource1
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh, nbApplyUpdates, nbCancelUpdates]
    TabOrder = 2
  end
  object Button2: TButton
    Left = 772
    Top = 279
    Width = 105
    Height = 33
    Caption = 'Apply'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 661
    Top = 279
    Width = 105
    Height = 33
    Caption = 'Refresh'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Conexao: TFDConnection
    Params.Strings = (
      'ConnectionDef=CursoFireDAC')
    Connected = True
    LoginPrompt = False
    Left = 745
    Top = 125
  end
  object FDQuery1: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'update clientes set idBairro = 6 where IdCliente = 36')
    Left = 344
    Top = 152
  end
  object FDQuery2: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'update clientes set idBairro = 2 where IdCliente = 37')
    Left = 400
    Top = 152
  end
  object FDQuery3: TFDQuery
    CachedUpdates = True
    Connection = Conexao
    SQL.Strings = (
      'select * from Clientes')
    Left = 72
    Top = 104
    object FDQuery3IdCliente: TFDAutoIncField
      FieldName = 'IdCliente'
      Origin = 'IdCliente'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery3Nome: TStringField
      DisplayWidth = 20
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 80
    end
    object FDQuery3Logradouro: TStringField
      DisplayWidth = 20
      FieldName = 'Logradouro'
      Origin = 'Logradouro'
      Size = 100
    end
    object FDQuery3Numero: TStringField
      DisplayWidth = 20
      FieldName = 'Numero'
      Origin = 'Numero'
      Size = 6
    end
    object FDQuery3IdBairro: TIntegerField
      FieldName = 'IdBairro'
      Origin = 'IdBairro'
    end
  end
  object DataSource1: TDataSource
    DataSet = FDQuery3
    Left = 72
    Top = 160
  end
  object FDTransaction1: TFDTransaction
    Connection = Conexao
    Left = 744
    Top = 176
  end
end
