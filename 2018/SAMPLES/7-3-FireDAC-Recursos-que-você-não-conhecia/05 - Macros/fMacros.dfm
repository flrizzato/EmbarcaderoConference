object FrmMacros: TFrmMacros
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '05 - Macros'
  ClientHeight = 439
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object memSQL: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 394
    Height = 78
    Align = alTop
    Lines.Strings = (
      'SELECT'
      #9'&Fields'
      'FROM'
      #9'&Table')
    TabOrder = 0
  end
  object btnExecuteFirebird: TButton
    AlignWithMargins = True
    Left = 3
    Top = 159
    Width = 394
    Height = 63
    Align = alTop
    Caption = 'Execute'
    TabOrder = 1
    OnClick = btnExecuteFirebirdClick
    ExplicitLeft = 334
    ExplicitTop = 87
    ExplicitWidth = 349
  end
  object griFirebird: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 228
    Width = 394
    Height = 208
    Align = alClient
    DataSource = DSFirebird
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object panParams: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 87
    Width = 394
    Height = 66
    Align = alTop
    BevelOuter = bvNone
    Caption = 'panParams'
    ShowCaption = False
    TabOrder = 3
    object lblFields: TLabel
      Left = 57
      Top = 11
      Width = 27
      Height = 13
      Caption = 'Fields'
    end
    object lblTable: TLabel
      Left = 58
      Top = 38
      Width = 26
      Height = 13
      Caption = 'Table'
    end
    object edtFields: TEdit
      Left = 88
      Top = 8
      Width = 257
      Height = 21
      TabOrder = 0
    end
    object edtTable: TEdit
      Left = 88
      Top = 35
      Width = 257
      Height = 21
      TabOrder = 1
    end
  end
  object DSFirebird: TDataSource
    DataSet = DMMacros.Query
    Left = 40
    Top = 344
  end
end
