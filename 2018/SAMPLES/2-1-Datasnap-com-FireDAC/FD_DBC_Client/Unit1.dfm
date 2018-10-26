object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Form6'
  ClientHeight = 435
  ClientWidth = 512
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 512
    Height = 435
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 120
    ExplicitTop = 128
    ExplicitWidth = 289
    ExplicitHeight = 193
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      ExplicitWidth = 281
      ExplicitHeight = 165
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 504
        Height = 214
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
        Top = 214
        Width = 504
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
        Top = 366
        Width = 504
        Height = 41
        Align = alBottom
        Caption = 'Panel1'
        ShowCaption = False
        TabOrder = 2
        ExplicitLeft = -3
        ExplicitTop = 390
        DesignSize = (
          504
          41)
        object Button1: TButton
          Left = 345
          Top = 8
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Apply'
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 430
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
          Width = 75
          Height = 25
          Caption = 'Refresh'
          TabOrder = 2
          OnClick = Button3Click
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 504
        Height = 366
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 160
        ExplicitTop = 160
        ExplicitWidth = 185
        ExplicitHeight = 89
      end
      object Panel2: TPanel
        Left = 0
        Top = 366
        Width = 504
        Height = 41
        Align = alBottom
        Caption = 'Panel1'
        ShowCaption = False
        TabOrder = 1
        ExplicitLeft = -3
        ExplicitTop = 390
        DesignSize = (
          504
          41)
        object Button4: TButton
          Left = 420
          Top = 8
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Apply'
          TabOrder = 0
          OnClick = Button4Click
        end
        object Button6: TButton
          Left = 6
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Refresh'
          TabOrder = 1
          OnClick = Button6Click
        end
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = Dtm.CdsClientes
    Left = 48
    Top = 56
  end
  object DataSource2: TDataSource
    DataSet = Dtm.CdsTelefones
    Left = 48
    Top = 112
  end
end
