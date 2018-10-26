object SearchDlg: TSearchDlg
  Left = 226
  Top = 118
  ActiveControl = DBGrid1
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'SearchDlg'
  ClientHeight = 299
  ClientWidth = 282
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 11
    Width = 69
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Search Field:'
  end
  object Label2: TLabel
    Left = 7
    Top = 40
    Width = 71
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Search Text:'
  end
  object SearchButton: TSpeedButton
    Left = 248
    Top = 36
    Width = 23
    Height = 23
    Hint = 'Search'
    Enabled = False
    Glyph.Data = {
      CA010000424DCA01000000000000760000002800000022000000110000000100
      04000000000054010000CE0E0000D80E00001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003333333FBFFF
      FFFFF3333333333333333300000033333333FBBFFFFBF3333333333333333300
      00003333333FBFFFFBFFF333333333333333330000003333333FBFFFFBFBF333
      3333333333333300000033333333FBBFFFFFF333333333333333330000003333
      333444FBFFFBF3333333888333333300000033333344834FBFFFF33333388738
      333333000000333334847F84BFFFF33333878737833333000000333334484F84
      FBBFB333338878378333330000003333348F74483FF3F3333387338873333300
      0000333344FFF743333333333883333833333300000033448F84443333333338
      873388873333330000003448F74333333333338873387773333333000000348F
      77333333333333873337333333333300000034F7743333333333338333873333
      3333330000003444433333333333338888733333333333000000333333333333
      3333333333333333333333000000}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = SearchButtonClick
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 66
    Width = 264
    Height = 181
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'PartNo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Description'
        Width = 181
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VendorNo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OnHand'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OnOrder'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BackOrd'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cost'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ListPrice'
        Visible = True
      end>
  end
  object OKBtn: TButton
    Left = 115
    Top = 265
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object CancelBtn: TButton
    Left = 199
    Top = 265
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object SearchEd: TEdit
    Left = 80
    Top = 36
    Width = 161
    Height = 21
    TabOrder = 1
    OnChange = SearchEdChange
    OnKeyPress = SearchEdKeyPress
  end
  object OrderCombo: TComboBox
    Left = 80
    Top = 8
    Width = 192
    Height = 21
    Style = csDropDownList
    TabOrder = 0
    OnChange = OrderComboChange
  end
  object DataSource: TDataSource
    DataSet = MastData.Parts
    Left = 47
    Top = 253
  end
end
