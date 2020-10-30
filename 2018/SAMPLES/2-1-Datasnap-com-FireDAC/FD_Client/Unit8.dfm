object Form8: TForm8
  Left = 0
  Top = 0
  Caption = 'Form8'
  ClientHeight = 419
  ClientWidth = 609
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
    Left = 0
    Top = 25
    Width = 609
    Height = 201
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 226
    Width = 609
    Height = 152
    Align = alBottom
    DataSource = DataSource2
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 378
    Width = 609
    Height = 41
    Align = alBottom
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 2
    DesignSize = (
      609
      41)
    object Button1: TButton
      Left = 442
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Apply'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 527
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 6
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Clientes'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 113
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Telefones'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 223
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Clientes/Telefones'
      TabOrder = 4
      OnClick = Button5Click
    end
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 0
    Width = 609
    Height = 25
    DataSource = DataSource1
    Align = alTop
    TabOrder = 3
  end
  object DataSource1: TDataSource
    DataSet = Dtm.MtClientes
    Left = 320
    Top = 88
  end
  object DataSource2: TDataSource
    DataSet = Dtm.MtTelefones
    Left = 304
    Top = 256
  end
end
