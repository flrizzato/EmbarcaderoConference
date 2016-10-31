object frmPrincipalExemplo1: TfrmPrincipalExemplo1
  Left = 0
  Top = 0
  Caption = 'Exemplo Fast 1'
  ClientHeight = 358
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 24
    Top = 8
    Width = 129
    Height = 121
    Caption = 'Relat'#243'rio Wizard'
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 24
      Top = 48
      Width = 75
      Height = 25
      Caption = 'Exibir'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 175
    Top = 8
    Width = 98
    Height = 121
    Caption = 'Exporta'#231#227'o'
    TabOrder = 1
    object BitBtn2: TBitBtn
      Left = 3
      Top = 48
      Width = 75
      Height = 25
      Caption = 'To PDF'
      TabOrder = 0
      OnClick = BitBtn2Click
    end
    object CheckBox1: TCheckBox
      Left = 3
      Top = 25
      Width = 97
      Height = 17
      Caption = 'Abrir Dialogo'
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 3
      Top = 79
      Width = 75
      Height = 25
      Caption = 'To PDF'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 281
    Top = 8
    Width = 264
    Height = 121
    Caption = 'Parametros'
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 25
      Width = 13
      Height = 13
      Caption = 'De'
    end
    object Label2: TLabel
      Left = 135
      Top = 25
      Width = 17
      Height = 13
      Caption = 'At'#233
    end
    object DtpInicial: TDateTimePicker
      Left = 16
      Top = 44
      Width = 113
      Height = 21
      Date = 42287.625228078700000000
      Time = 42287.625228078700000000
      TabOrder = 0
    end
    object dtpFinal: TDateTimePicker
      Left = 135
      Top = 44
      Width = 113
      Height = 21
      Date = 42287.625228078700000000
      Time = 42287.625228078700000000
      TabOrder = 1
    end
    object BitBtn4: TBitBtn
      Left = 16
      Top = 79
      Width = 75
      Height = 25
      Caption = 'Exibir'
      TabOrder = 2
      OnClick = BitBtn4Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 24
    Top = 144
    Width = 329
    Height = 73
    Caption = 'Carregar'
    TabOrder = 3
    object BitBtn5: TBitBtn
      Left = 184
      Top = 45
      Width = 75
      Height = 25
      Caption = 'Exibir'
      TabOrder = 0
      OnClick = BitBtn5Click
    end
    object edtNomeRelatorio: TEdit
      Left = 24
      Top = 24
      Width = 235
      Height = 21
      TabOrder = 1
    end
    object BitBtn6: TBitBtn
      Left = 265
      Top = 24
      Width = 36
      Height = 25
      Caption = '...'
      TabOrder = 2
      OnClick = BitBtn6Click
    end
  end
  object GroupBox5: TGroupBox
    Left = 368
    Top = 144
    Width = 145
    Height = 74
    Caption = 'Formularios'
    TabOrder = 4
    object BitBtn7: TBitBtn
      Left = 32
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Exibir'
      TabOrder = 0
      OnClick = BitBtn7Click
    end
  end
  object GroupBox6: TGroupBox
    Left = 24
    Top = 232
    Width = 185
    Height = 81
    Caption = 'Codigo Barras'
    TabOrder = 5
    object BitBtn8: TBitBtn
      Left = 38
      Top = 37
      Width = 75
      Height = 25
      Caption = 'Emitir'
      TabOrder = 0
      OnClick = BitBtn8Click
    end
  end
  object frxReport: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42297.440822511600000000
    ReportOptions.LastChange = 42297.452346168980000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      ''
      'begin'
      ''
      'end.')
    Left = 360
    Top = 240
    Datasets = <
      item
        DataSet = frxDBDatasetEmployee
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 2
      ColumnWidth = 95.000000000000000000
      ColumnPositions.Strings = (
        '0'
        '95')
      OnBeforePrint = 'Page1OnBeforePrint'
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 149.133890000000000000
        Top = 18.897650000000000000
        Width = 359.055350000000000000
        DataSet = frxDBDatasetEmployee
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object frxDBDataset1Nome: TfrxMemoView
          Left = 18.897650000000000000
          Top = 3.779530000000001000
          Width = 294.803340000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDatasetEmployee
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."Nome"] [frxDBDataset1."Sobrenome"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Barcode2D1: TfrxBarcode2DView
          Left = 230.551330000000000000
          Top = 34.015770000000000000
          Width = 84.000000000000000000
          Height = 100.000000000000000000
          BarType = bcCodeQR
          BarProperties.Encoding = qrAuto
          BarProperties.QuietZone = 0
          BarProperties.ErrorLevels = ecL
          BarProperties.PixelSize = 4
          DataField = 'Nome'
          DataSet = frxDBDatasetEmployee
          DataSetName = 'frxDBDataset1'
          Rotation = 0
          ShowText = True
          Text = 'www.google.com.br'
          Zoom = 1.000000000000000000
          FontScaled = True
          QuietZone = 0
        end
        object BarCode1: TfrxBarCodeView
          Left = 18.897650000000000000
          Top = 45.354360000000000000
          Width = 90.000000000000000000
          Height = 45.354360000000000000
          BarType = bcCodeEAN128
          Expression = '<frxDBDataset1."Cod">'
          Rotation = 0
          Text = '12345678'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
      end
    end
  end
  object frxDBDatasetEmployee: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'EMP_NO=Cod'
      'FIRST_NAME=Nome'
      'LAST_NAME=Sobrenome'
      'PHONE_EXT=Telefone'
      '-HIRE_DATE=HIRE_DATE'
      '-DEPT_NO=DEPT_NO'
      '-JOB_CODE=JOB_CODE'
      '-JOB_GRADE=JOB_GRADE'
      'JOB_COUNTRY=Local'
      'SALARY=SALARY'
      'FULL_NAME=Nome')
    DataSet = DMConsultas.qryEmployee
    BCDToCurrency = False
    Left = 448
    Top = 240
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 448
    Top = 296
  end
  object frxHTMLExport1: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    FixedWidth = True
    Background = False
    Centered = False
    EmptyLines = True
    Print = False
    PictureType = gpPNG
    Left = 552
    Top = 296
  end
  object frxChartObject1: TfrxChartObject
    Left = 360
    Top = 296
  end
  object OpenDialog1: TOpenDialog
    Left = 552
    Top = 240
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 264
    Top = 296
  end
  object frxDialogControls1: TfrxDialogControls
    Left = 552
    Top = 184
  end
end
