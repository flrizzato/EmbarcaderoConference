object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Restaurante'
  ClientHeight = 520
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 16
    Top = 16
    Width = 449
    Height = 81
    Caption = 'Identifica'#231#227'o do Cliente'
    TabOrder = 0
    object edtNome: TLabeledEdit
      Left = 160
      Top = 44
      Width = 265
      Height = 21
      EditLabel.Width = 90
      EditLabel.Height = 13
      EditLabel.Caption = 'Nome do cliente'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      TabOrder = 0
    end
    object edtDocumento: TLabeledEdit
      Left = 16
      Top = 44
      Width = 129
      Height = 21
      EditLabel.Width = 65
      EditLabel.Height = 13
      EditLabel.Caption = 'Documento'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      TabOrder = 1
    end
  end
  object grbPedido: TGroupBox
    Left = 16
    Top = 103
    Width = 449
    Height = 266
    Caption = 'Identifica'#231#227'o do Cliente'
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 29
      Width = 45
      Height = 13
      Caption = 'Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SpeedButton1: TSpeedButton
      Left = 402
      Top = 48
      Width = 23
      Height = 22
      Caption = '+'
      OnClick = SpeedButton1Click
    end
    object cbxProduto: TComboBox
      Left = 16
      Top = 48
      Width = 308
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'Pizza Calabresa'
      Items.Strings = (
        'Pizza Calabresa'
        'Pizza cora'#231#227'o de galinha'
        'Pizza Tudo'
        'Refrigerante 2L')
    end
    object edtQTD: TLabeledEdit
      Left = 330
      Top = 48
      Width = 66
      Height = 21
      EditLabel.Width = 20
      EditLabel.Height = 13
      EditLabel.Caption = 'Qtd'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 1
    end
    object dbgPedido: TDBGrid
      Left = 16
      Top = 75
      Width = 409
      Height = 174
      DataSource = dtsPedido
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Caption = 'Produto'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'qtd'
          Title.Caption = 'QTD'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = True
        end>
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 375
    Width = 449
    Height = 81
    Caption = ' TOTAL '
    TabOrder = 2
    object lblTotal: TLabel
      Left = 353
      Top = 21
      Width = 80
      Height = 25
      Alignment = taRightJustify
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object mtblPedido: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 136
    Top = 480
    object mtblPedidodocumento: TStringField
      FieldName = 'documento'
      Size = 18
    end
    object mtblPedidonome: TStringField
      FieldName = 'nome'
      Size = 30
    end
    object mtblPedidoproduto: TIntegerField
      FieldName = 'produto'
    end
    object mtblPedidoqtd: TIntegerField
      FieldName = 'qtd'
    end
    object mtblPedidodescricao: TStringField
      FieldName = 'descricao'
      Size = 30
    end
    object mtblPedidototal: TFloatField
      FieldName = 'total'
    end
  end
  object dtsPedido: TDataSource
    DataSet = mtblPedido
    Left = 72
    Top = 480
  end
end
