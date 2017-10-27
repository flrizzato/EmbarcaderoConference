object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 398
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBText1: TDBText
    Left = 496
    Top = 360
    Width = 65
    Height = 17
    DataField = 'TotalVenda'
    DataSource = DataSource1
  end
  object DBText2: TDBText
    Left = 48
    Top = 360
    Width = 65
    Height = 17
    DataField = 'QtdMarcado'
    DataSource = DataSource1
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 684
    Height = 354
    Align = alTop
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Selecionado'
        Title.Caption = ' '
        Width = 20
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IdVenda'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IdProduto'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Qtd'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ValorTotal'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ValorTotal1'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TotalVenda'
        Visible = True
      end>
  end
  object ExtremedelphiConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=ExtremeDelphi')
    Connected = True
    LoginPrompt = False
    Left = 301
    Top = 66
  end
  object DataSource1: TDataSource
    DataSet = VendaprodutosTable
    Left = 304
    Top = 168
  end
  object VendaprodutosTable: TFDQuery
    Active = True
    OnCalcFields = VendaprodutosTableCalcFields
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'IxVenda'
        Fields = 'IdVenda'
      end>
    IndexName = 'IxVenda'
    AggregatesActive = True
    Connection = ExtremedelphiConnection
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'SELECT 0 as Selecionado, * FROM DelphiExtreme.dbo.VendaProdutos')
    Left = 303
    Top = 118
    object VendaprodutosTableSelecionado: TIntegerField
      FieldName = 'Selecionado'
      Origin = 'Selecionado'
      Required = True
    end
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
    object VendaprodutosTableValorTotal: TFloatField
      DisplayLabel = 'Valor Total'
      FieldKind = fkCalculated
      FieldName = 'ValorTotal'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object VendaprodutosTableValorTotal1: TFloatField
      DefaultExpression = 'Qtd*Valor'
      FieldKind = fkInternalCalc
      FieldName = 'ValorTotal1'
      DisplayFormat = '#,##0.00'
    end
    object VendaprodutosTableTotalVenda: TAggregateField
      FieldName = 'TotalVenda'
      OnGetText = VendaprodutosTableTotalVendaGetText
      Active = True
      DisplayName = ''
      DisplayFormat = '#,##0.00'
      Expression = 'Sum(Qtd*Valor)'
      GroupingLevel = 1
    end
    object VendaprodutosTableQtdMarcado: TAggregateField
      FieldName = 'QtdMarcado'
      Active = True
      DisplayName = ''
      Expression = 'Count(IIF(Selecionado = 1,1,NULL))'
    end
  end
end
