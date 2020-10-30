object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 518
  ClientWidth = 684
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 684
    Height = 193
    Align = alTop
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -19
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 284
    Width = 684
    Height = 180
    Align = alClient
    DataSource = DataSource2
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -19
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 193
    Width = 684
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 2
    object BtnApply: TButton
      Left = 579
      Top = 6
      Width = 97
      Height = 41
      Caption = 'Apply'
      TabOrder = 0
      OnClick = BtnApplyClick
    end
    object BtnRefresh: TButton
      Left = 476
      Top = 6
      Width = 97
      Height = 41
      Caption = 'Refresh'
      TabOrder = 1
      OnClick = BtnRefreshClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 243
    Width = 684
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Erros Encontrados'
    TabOrder = 3
    ExplicitLeft = 256
    ExplicitTop = 256
    ExplicitWidth = 185
  end
  object Panel3: TPanel
    Left = 0
    Top = 464
    Width = 684
    Height = 54
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel3'
    ShowCaption = False
    TabOrder = 4
    object Button1: TButton
      Left = 579
      Top = 5
      Width = 97
      Height = 41
      Caption = 'Erro'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object ExtremedelphiConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=ExtremeDelphi')
    ResourceOptions.AssignedValues = [rvPersistent, rvBackup, rvDefaultStoreFolder, rvDefaultStoreFormat, rvBackupFolder, rvDefaultStoreExt]
    ResourceOptions.Persistent = True
    ResourceOptions.Backup = True
    ResourceOptions.DefaultStoreFolder = 'C:\Temp\bck'
    ResourceOptions.BackupFolder = 'C:\Temp\bck'
    ResourceOptions.DefaultStoreExt = 'fds'
    ResourceOptions.DefaultStoreFormat = sfXML
    LoginPrompt = False
    Left = 77
    Top = 49
  end
  object VendaprodutosTable: TFDQuery
    CachedUpdates = True
    Connection = ExtremedelphiConnection
    SQL.Strings = (
      'SELECT * FROM DelphiExtreme.dbo.VendaProdutos')
    Left = 77
    Top = 97
    object VendaprodutosTableIdVenda: TIntegerField
      FieldName = 'IdVenda'
      Origin = 'IdVenda'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object VendaprodutosTableIdProduto: TIntegerField
      FieldName = 'IdProduto'
      Origin = 'IdProduto'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object VendaprodutosTableQtd: TBCDField
      FieldName = 'Qtd'
      Origin = 'Qtd'
      Required = True
      Precision = 16
      Size = 2
    end
    object VendaprodutosTableValor: TBCDField
      FieldName = 'Valor'
      Origin = 'Valor'
      Required = True
      Precision = 16
      Size = 2
    end
  end
  object DataSource1: TDataSource
    DataSet = VendaprodutosTable
    Left = 72
    Top = 152
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 248
    Top = 304
  end
  object DataSource2: TDataSource
    DataSet = FDMemTable1
    Left = 248
    Top = 360
  end
end
