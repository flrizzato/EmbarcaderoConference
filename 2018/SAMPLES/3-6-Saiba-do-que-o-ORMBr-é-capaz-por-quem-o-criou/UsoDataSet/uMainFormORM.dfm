object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 653
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
  OnDestroy = FormDestroy
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
    Width = 30
    Height = 13
    Caption = 'Itens'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 591
    Top = 382
    Width = 138
    Height = 13
    Caption = '(Aggregate) Total Detalhes :'
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
  object Button1: TButton
    Left = 132
    Top = 437
    Width = 109
    Height = 25
    Caption = 'Update via Objeto'
    TabOrder = 11
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 740
    Top = 437
    Width = 116
    Height = 25
    Caption = 'Show SQL Monitor'
    TabOrder = 12
    OnClick = Button3Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 464
    Width = 848
    Height = 183
    ScrollBars = ssVertical
    TabOrder = 13
  end
  object dtsMestre: TDataSource
    DataSet = FDMestre
    Left = 424
    Top = 60
  end
  object dtsDetalhe: TDataSource
    DataSet = FDDetalhe
    Left = 422
    Top = 112
  end
  object dtsCliente: TDataSource
    AutoEdit = False
    DataSet = FDCliente
    Left = 426
    Top = 168
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\ORMBr ECON\Database\Firebird\DB_LIVE.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 182
    Top = 46
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 86
    Top = 42
  end
  object FDMestre: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 354
    Top = 36
  end
  object FDDetalhe: TFDMemTable
    OnCalcFields = FDDetalheCalcFields
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 354
    Top = 88
  end
  object FDCliente: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 354
    Top = 144
  end
  object FDStatus: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 352
    Top = 198
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 784
    Top = 60
  end
  object OpenDialog1: TOpenDialog
    Left = 426
    Top = 364
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 788
    Top = 12
  end
end
