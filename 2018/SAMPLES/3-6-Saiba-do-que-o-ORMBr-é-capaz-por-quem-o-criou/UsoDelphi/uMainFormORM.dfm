object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 717
  ClientWidth = 864
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 132
    Width = 47
    Height = 13
    Caption = 'Mestre ID'
  end
  object Label2: TLabel
    Left = 144
    Top = 132
    Width = 82
    Height = 13
    Caption = 'Mestre Descri'#231#227'o'
  end
  object Label3: TLabel
    Left = 12
    Top = 174
    Width = 47
    Height = 13
    Caption = 'Cliente ID'
  end
  object Label4: TLabel
    Left = 144
    Top = 174
    Width = 63
    Height = 13
    Caption = 'Cliente Nome'
  end
  object Label5: TLabel
    Left = 12
    Top = 218
    Width = 80
    Height = 13
    Caption = 'Mestre Cadastro'
  end
  object Label6: TLabel
    Left = 144
    Top = 218
    Width = 82
    Height = 13
    Caption = 'Mestre Altera'#231#227'o'
  end
  object Label7: TLabel
    Left = 8
    Top = 265
    Width = 33
    Height = 13
    Caption = 'Detail'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 668
    Top = 383
    Width = 61
    Height = 13
    Caption = 'Total Pre'#231'o :'
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 4
    Width = 848
    Height = 121
    DataSource = dtsMestre
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 406
    Width = 840
    Height = 25
    DataSource = dtsMestre
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 437
    Width = 113
    Height = 25
    Caption = 'ApplyUpdates'
    TabOrder = 2
    OnClick = Button2Click
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 279
    Width = 848
    Height = 96
    DataSource = dtsDetalhe
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBEdit1: TDBEdit
    Left = 12
    Top = 148
    Width = 121
    Height = 21
    DataField = 'Id'
    DataSource = dtsMestre
    TabOrder = 4
  end
  object DBEdit2: TDBEdit
    Left = 144
    Top = 148
    Width = 601
    Height = 21
    DataField = 'Descricao'
    DataSource = dtsMestre
    TabOrder = 5
  end
  object DBEdit3: TDBEdit
    Left = 12
    Top = 190
    Width = 121
    Height = 21
    DataField = 'Cliente_Id'
    DataSource = dtsMestre
    TabOrder = 6
  end
  object DBEdit4: TDBEdit
    Left = 144
    Top = 190
    Width = 601
    Height = 21
    DataField = 'Nome'
    DataSource = dtsCliente
    Enabled = False
    TabOrder = 7
  end
  object DBEdit5: TDBEdit
    Left = 12
    Top = 234
    Width = 121
    Height = 21
    DataField = 'DataCadastro'
    DataSource = dtsMestre
    TabOrder = 8
  end
  object DBEdit6: TDBEdit
    Left = 144
    Top = 234
    Width = 121
    Height = 21
    DataField = 'DataAlteracao'
    DataSource = dtsMestre
    TabOrder = 9
  end
  object DBEdit7: TDBEdit
    Left = 735
    Top = 379
    Width = 121
    Height = 21
    DataField = 'AggPRECO'
    DataSource = dtsDetalhe
    TabOrder = 10
  end
  object Button3: TButton
    Left = 740
    Top = 437
    Width = 116
    Height = 25
    Caption = 'Show SQL Monitor'
    TabOrder = 11
  end
  object Memo1: TMemo
    Left = 8
    Top = 468
    Width = 848
    Height = 245
    ScrollBars = ssVertical
    TabOrder = 12
  end
  object dtsMestre: TDataSource
    DataSet = FDMestre
    Left = 418
    Top = 60
  end
  object dtsDetalhe: TDataSource
    DataSet = FDDetalhe
    Left = 418
    Top = 118
  end
  object dtsCliente: TDataSource
    AutoEdit = False
    DataSet = FDCliente
    Left = 420
    Top = 170
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=D:\ORMBr Diversos\Live-08062017\Database\Firebird\DB_LI' +
        'VE.FDB'
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    Left = 154
    Top = 42
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 86
    Top = 42
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 230
    Top = 42
  end
  object FDMestre: TFDQuery
    AfterOpen = FDMestreAfterOpen
    BeforeClose = FDMestreBeforeClose
    Connection = FDConnection1
    SQL.Strings = (
      'select * from tab_mestre')
    Left = 356
    Top = 60
    object FDMestreID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDMestreDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 60
    end
    object FDMestreDATACADASTRO: TDateField
      FieldName = 'DATACADASTRO'
      Origin = 'DATACADASTRO'
      Required = True
    end
    object FDMestreDATAALTERACAO: TDateField
      FieldName = 'DATAALTERACAO'
      Origin = 'DATAALTERACAO'
      Required = True
    end
    object FDMestreCLIENTE_ID: TIntegerField
      FieldName = 'CLIENTE_ID'
      Origin = 'CLIENTE_ID'
      Required = True
    end
  end
  object FDDetalhe: TFDQuery
    MasterSource = dtsMestre
    MasterFields = 'ID'
    DetailFields = 'ID'
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'select * from tab_detalhe'
      'where mestre_id = :ID')
    Left = 356
    Top = 118
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 4
      end>
    object FDDetalheID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDDetalheMESTRE_ID: TIntegerField
      FieldName = 'MESTRE_ID'
      Origin = 'MESTRE_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDDetalheSTATUS_ID: TIntegerField
      FieldName = 'STATUS_ID'
      Origin = 'STATUS_ID'
      Required = True
    end
    object FDDetalheOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Origin = 'OBSERVACAO'
      Size = 30
    end
    object FDDetalhePRECO: TBCDField
      DefaultExpression = '0'
      FieldName = 'PRECO'
      Origin = 'PRECO'
      Required = True
      DisplayFormat = '#,###,##0.00'
      Precision = 18
      Size = 3
    end
    object FDDetalheAggPRECO: TAggregateField
      DefaultExpression = 'SUM(PRECO)'
      FieldName = 'AggPRECO'
      DisplayName = ''
      DisplayFormat = '#,###,#.00'
    end
  end
  object FDCliente: TFDQuery
    MasterSource = dtsMestre
    MasterFields = 'CLIENTE_ID'
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'select * from tab_cliente'
      'where id = :cliente_id')
    Left = 356
    Top = 170
    ParamData = <
      item
        Name = 'CLIENTE_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    object FDClienteID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDClienteNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 40
    end
  end
  object FDStatus: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from tab_status')
    Left = 356
    Top = 224
    object FDStatusID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDStatusDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 30
    end
  end
  object dtsStatus: TDataSource
    AutoEdit = False
    DataSet = FDCliente
    Left = 420
    Top = 224
  end
end
