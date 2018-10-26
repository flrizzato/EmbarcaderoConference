object frmMenuConference2018: TfrmMenuConference2018
  Left = 0
  Top = 0
  Caption = 'frmMenuConference2018'
  ClientHeight = 487
  ClientWidth = 734
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
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 734
    Height = 446
    ActivePage = TabSheet4
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Enviar MSG'
      ExplicitLeft = 8
      object Label1: TLabel
        Left = 16
        Top = 18
        Width = 108
        Height = 13
        Caption = 'Handle do ComboBox1'
      end
      object Label2: TLabel
        Left = 16
        Top = 162
        Width = 146
        Height = 13
        Caption = 'Handle de envio de mensagem'
      end
      object btnAdicionarTextoCombo: TButton
        Left = 16
        Top = 208
        Width = 137
        Height = 25
        Caption = 'Adicionar Texto ao Combo'
        TabOrder = 0
        OnClick = btnAdicionarTextoComboClick
      end
      object edtHandleComboBox: TEdit
        Left = 16
        Top = 37
        Width = 137
        Height = 21
        TabOrder = 1
        Text = '0'
      end
      object ComboBox1: TComboBox
        Left = 16
        Top = 64
        Width = 137
        Height = 21
        TabOrder = 2
        Text = 'ComboBox1'
      end
      object edtTextoCombo: TEdit
        Left = 16
        Top = 239
        Width = 137
        Height = 21
        TabOrder = 3
        Text = 'Teste'
      end
      object btnAbreCombo: TButton
        Left = 16
        Top = 280
        Width = 137
        Height = 25
        Caption = 'Abrir ComboBox'
        TabOrder = 4
        OnClick = btnAbreComboClick
      end
      object edtHandleEnvioMsg: TEdit
        Left = 16
        Top = 181
        Width = 137
        Height = 21
        TabOrder = 5
        Text = '0'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Capturar Handle'
      ImageIndex = 1
      ExplicitHeight = 372
      object Label5: TLabel
        Left = 24
        Top = 128
        Width = 37
        Height = 13
        Caption = 'Handle:'
      end
      object Label6: TLabel
        Left = 26
        Top = 155
        Width = 35
        Height = 13
        Caption = 'Classe:'
      end
      object Label7: TLabel
        Left = 29
        Top = 182
        Width = 32
        Height = 13
        Caption = 'Texto:'
      end
      object Label8: TLabel
        Left = 3
        Top = 207
        Width = 58
        Height = 13
        Caption = 'Hnd Parent:'
      end
      object Label9: TLabel
        Left = 29
        Top = 235
        Width = 31
        Height = 13
        Caption = 'Nome:'
      end
      object edtHandlePos: TEdit
        Left = 67
        Top = 124
        Width = 142
        Height = 21
        TabOrder = 0
      end
      object GroupBox1: TGroupBox
        Left = 24
        Top = 45
        Width = 185
        Height = 73
        Caption = 'Posi'#231#227'o'
        TabOrder = 1
        object Label3: TLabel
          Left = 16
          Top = 23
          Width = 10
          Height = 13
          Caption = 'X:'
        end
        object Label4: TLabel
          Left = 16
          Top = 48
          Width = 10
          Height = 13
          Caption = 'Y:'
        end
        object lbX: TLabel
          Left = 40
          Top = 23
          Width = 6
          Height = 13
          Caption = '0'
        end
        object lbY: TLabel
          Left = 40
          Top = 48
          Width = 6
          Height = 13
          Caption = '0'
        end
      end
      object edtClasse: TEdit
        Left = 67
        Top = 151
        Width = 142
        Height = 21
        TabOrder = 2
      end
      object edtTexto: TEdit
        Left = 67
        Top = 178
        Width = 142
        Height = 21
        TabOrder = 3
      end
      object chxCapturarHandle: TCheckBox
        Left = 25
        Top = 16
        Width = 183
        Height = 17
        Caption = 'Capturar Handle'
        TabOrder = 4
        OnClick = chxCapturarHandleClick
      end
      object edtHandleParent: TEdit
        Left = 67
        Top = 205
        Width = 142
        Height = 21
        TabOrder = 5
      end
      object edtNome: TEdit
        Left = 67
        Top = 232
        Width = 142
        Height = 21
        TabOrder = 6
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Mapear Handles'
      ImageIndex = 2
      ExplicitHeight = 372
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 726
        Height = 377
        Align = alClient
        DataSource = dscHandle
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Nodo'
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Handle'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Classe'
            Width = 130
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Text'
            Width = 142
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Name'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Nivel'
            Visible = True
          end>
      end
      object Panel2: TPanel
        Left = 0
        Top = 377
        Width = 726
        Height = 41
        Align = alBottom
        TabOrder = 1
        ExplicitTop = 331
        object Label10: TLabel
          Left = 272
          Top = 16
          Width = 6
          Height = 13
          Caption = '0'
        end
        object chxAtivarHandleParent: TCheckBox
          Left = 14
          Top = 12
          Width = 97
          Height = 17
          Caption = 'Ativar'
          TabOrder = 0
          OnClick = chxAtivarHandleParentClick
        end
        object chxDestacarHandle: TCheckBox
          Left = 117
          Top = 12
          Width = 97
          Height = 17
          Caption = 'Destacar Handle'
          TabOrder = 1
          OnClick = chxDestacarHandleClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Hook'
      ImageIndex = 3
      ExplicitHeight = 372
      object lblInstalled: TLabel
        Left = 24
        Top = 13
        Width = 177
        Height = 21
        Alignment = taCenter
        AutoSize = False
        Caption = 'Hook n'#227'o instalado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object lblKey: TLabel
        Left = 152
        Top = 56
        Width = 95
        Height = 45
        Caption = 'lblKey'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -37
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object btnInstallHook: TButton
        Left = 24
        Top = 40
        Width = 75
        Height = 25
        Caption = '&InstallHook'
        TabOrder = 0
        OnClick = btnInstallHookClick
      end
      object btnUninstallHook: TButton
        Left = 24
        Top = 88
        Width = 75
        Height = 25
        Caption = '&UninstallHook'
        TabOrder = 1
        OnClick = btnUninstallHookClick
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'WebBrowser'
      ImageIndex = 4
      ExplicitHeight = 372
      object btnWebLogin: TButton
        Left = 16
        Top = 16
        Width = 153
        Height = 25
        Caption = 'WebLogin'
        TabOrder = 0
        OnClick = btnWebLoginClick
      end
      object btnWebMaps: TButton
        Left = 16
        Top = 56
        Width = 153
        Height = 25
        Caption = 'WebMaps'
        TabOrder = 1
        OnClick = btnWebMapsClick
      end
      object Translate: TButton
        Left = 16
        Top = 100
        Width = 153
        Height = 25
        Caption = 'Translate'
        TabOrder = 2
        OnClick = TranslateClick
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Manipular DFM'
      ImageIndex = 5
      object Button3: TButton
        Left = 14
        Top = 17
        Width = 153
        Height = 25
        Caption = 'Extrator Imagens DFM'
        TabOrder = 0
        OnClick = Button3Click
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 734
    Height = 41
    Align = alTop
    TabOrder = 1
  end
  object tmrHandle: TTimer
    Enabled = False
    Interval = 250
    OnTimer = tmrHandleTimer
    Left = 496
    Top = 160
  end
  object dscHandle: TDataSource
    DataSet = cdsHandle
    Left = 320
    Top = 208
  end
  object cdsHandle: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 324
    Top = 153
    object cdsHandleHandle: TIntegerField
      FieldName = 'Handle'
    end
    object cdsHandleClasse: TStringField
      FieldName = 'Classe'
      Size = 50
    end
    object cdsHandleName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object cdsHandleText: TStringField
      DisplayWidth = 50
      FieldName = 'Text'
      Size = 255
    end
    object cdsHandleNivel: TIntegerField
      FieldName = 'Nivel'
    end
    object cdsHandleNodo: TStringField
      Alignment = taRightJustify
      FieldName = 'Nodo'
      Size = 200
    end
  end
  object tmrHandleParent: TTimer
    Enabled = False
    OnTimer = tmrHandleParentTimer
    Left = 498
    Top = 106
  end
  object tmrDestacarHandle: TTimer
    Enabled = False
    Interval = 250
    OnTimer = tmrDestacarHandleTimer
    Left = 492
    Top = 217
  end
end
