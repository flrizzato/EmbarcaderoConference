object frmExtrairImagemDfm: TfrmExtrairImagemDfm
  Left = 0
  Top = 0
  Caption = 'frmExtrairImagemDfm'
  ClientHeight = 708
  ClientWidth = 783
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 783
    Height = 97
    Align = alTop
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      783
      97)
    object Label1: TLabel
      Left = 12
      Top = 17
      Width = 69
      Height = 13
      Caption = 'Diret'#243'rio DFM:'
    end
    object Label7: TLabel
      Left = 12
      Top = 44
      Width = 74
      Height = 13
      Caption = 'Icones originais'
    end
    object Label9: TLabel
      Left = 12
      Top = 71
      Width = 68
      Height = 13
      Caption = 'Icones novos:'
    end
    object edtDirDfm: TEdit
      Left = 111
      Top = 14
      Width = 654
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'C:\Muka\Delphi\'
    end
    object edtIconesOriginais: TEdit
      Left = 111
      Top = 41
      Width = 654
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Text = 'C:\Muka\Delphi\Conference 2018\Exemplo Palestra\Imagens\'
    end
    object edtIconesNovos: TEdit
      Left = 111
      Top = 68
      Width = 654
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 97
    Width = 783
    Height = 611
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Lista DFMs'
      object Gauge1: TGauge
        AlignWithMargins = True
        Left = 3
        Top = 525
        Width = 769
        Height = 25
        Align = alBottom
        Progress = 0
        ExplicitTop = 732
        ExplicitWidth = 830
      end
      object Gauge2: TGauge
        AlignWithMargins = True
        Left = 3
        Top = 556
        Width = 769
        Height = 24
        Align = alBottom
        Progress = 0
        ExplicitTop = 590
        ExplicitWidth = 714
      end
      object memArquivos: TMemo
        Left = 0
        Top = 51
        Width = 775
        Height = 471
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
        ExplicitTop = 50
        ExplicitHeight = 532
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 775
        Height = 51
        Align = alTop
        TabOrder = 1
        object btnListarArquivosDFM: TBitBtn
          Left = 9
          Top = 11
          Width = 97
          Height = 25
          Caption = 'Listar Arquivos'
          TabOrder = 0
          OnClick = btnListarArquivosDFMClick
        end
        object btnExtrairImagens: TBitBtn
          Left = 112
          Top = 11
          Width = 104
          Height = 25
          Caption = 'Extrair Imagens'
          TabOrder = 1
          OnClick = btnExtrairImagensClick
        end
        object btnEliminarDuplicados: TButton
          Left = 523
          Top = 11
          Width = 119
          Height = 25
          Caption = 'Eliminar Duplicados'
          TabOrder = 2
        end
        object GroupBox1: TGroupBox
          Left = 225
          Top = 2
          Width = 274
          Height = 42
          Caption = 'Extrair imagens de:'
          TabOrder = 3
          object cbxButtons: TCheckBox
            Left = 110
            Top = 17
            Width = 68
            Height = 17
            Caption = 'Buttons'
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
          object cbxImages: TCheckBox
            Left = 203
            Top = 17
            Width = 61
            Height = 17
            Caption = 'Images'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object cbxImageList: TCheckBox
            Left = 17
            Top = 17
            Width = 84
            Height = 17
            Caption = 'ImageList'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
        end
      end
    end
    object tbsFerramentas: TTabSheet
      Caption = 'Ferramentas'
      ImageIndex = 1
      object Splitter2: TSplitter
        Left = 0
        Top = 385
        Width = 775
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ResizeStyle = rsUpdate
        ExplicitTop = 305
        ExplicitWidth = 712
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 775
        Height = 37
        Align = alTop
        TabOrder = 0
        DesignSize = (
          775
          37)
        object Label2: TLabel
          Left = 10
          Top = 9
          Width = 133
          Height = 13
          Caption = 'Imagem nova com 4 icones:'
        end
        object edtImagemNova: TEdit
          Left = 149
          Top = 6
          Width = 567
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'D:\Muka\ImageDfmExtrator2\Win32\Debug\Novos\icones-agenda_03.bmp'
        end
        object Button4: TButton
          Left = 721
          Top = 4
          Width = 47
          Height = 25
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 1
        end
      end
      object memArquivosBmp: TMemo
        Left = 0
        Top = 169
        Width = 775
        Height = 216
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 1
        WordWrap = False
      end
      object image: TPanel
        Left = 0
        Top = 37
        Width = 775
        Height = 132
        Align = alTop
        TabOrder = 2
        object Shape8: TShape
          Left = 674
          Top = 17
          Width = 47
          Height = 47
          Brush.Color = clSilver
        end
        object Shape7: TShape
          Left = 288
          Top = 17
          Width = 47
          Height = 47
          Brush.Color = clSilver
        end
        object Shape4: TShape
          Left = 423
          Top = 17
          Width = 127
          Height = 47
          Brush.Color = clSilver
        end
        object Shape3: TShape
          Left = 229
          Top = 17
          Width = 47
          Height = 47
          Brush.Color = clSilver
        end
        object Shape2: TShape
          Left = 170
          Top = 17
          Width = 47
          Height = 47
          Brush.Color = clSilver
        end
        object Shape1: TShape
          Left = 6
          Top = 17
          Width = 154
          Height = 47
          Brush.Color = clSilver
        end
        object imgBase: TImage
          Left = 10
          Top = 21
          Width = 146
          Height = 39
          Center = True
        end
        object imgSubstituto: TImage
          Left = 428
          Top = 21
          Width = 116
          Height = 39
          Center = True
        end
        object imgNova: TImage
          Left = 235
          Top = 21
          Width = 36
          Height = 39
          Center = True
        end
        object imgOriginal: TImage
          Left = 175
          Top = 21
          Width = 36
          Height = 39
          Center = True
        end
        object Label3: TLabel
          Left = 10
          Top = 1
          Width = 64
          Height = 13
          Caption = 'Imagem Base'
        end
        object Label4: TLabel
          Left = 176
          Top = 1
          Width = 36
          Height = 13
          Caption = 'Original'
        end
        object Label5: TLabel
          Left = 240
          Top = 1
          Width = 25
          Height = 13
          Caption = 'Nova'
        end
        object Label6: TLabel
          Left = 440
          Top = 1
          Width = 89
          Height = 13
          Caption = 'Imagem substituta'
        end
        object Label10: TLabel
          Left = 562
          Top = 1
          Width = 47
          Height = 13
          Caption = 'Atual Dfm'
        end
        object Shape5: TShape
          Left = 562
          Top = 17
          Width = 47
          Height = 47
          Brush.Color = clSilver
        end
        object imgAtualDfm: TImage
          Left = 568
          Top = 21
          Width = 36
          Height = 39
          Center = True
        end
        object Label11: TLabel
          Left = 621
          Top = 1
          Width = 47
          Height = 13
          Caption = 'Novo Dfm'
        end
        object Shape6: TShape
          Left = 619
          Top = 17
          Width = 47
          Height = 47
          Brush.Color = clSilver
        end
        object imgDfmNovo: TImage
          Left = 624
          Top = 20
          Width = 36
          Height = 39
          Center = True
          Transparent = True
        end
        object SpeedButton1: TSpeedButton
          Left = 677
          Top = 21
          Width = 41
          Height = 38
        end
        object Label15: TLabel
          Left = 282
          Top = 1
          Width = 58
          Height = 13
          Caption = 'Pressionada'
        end
        object imgPressionado: TImage
          Left = 293
          Top = 21
          Width = 37
          Height = 39
          Center = True
        end
        object Label16: TLabel
          Left = 693
          Top = 1
          Width = 45
          Height = 13
          Caption = 'Exemplos'
        end
        object Shape9: TShape
          Left = 347
          Top = 17
          Width = 47
          Height = 47
          Brush.Color = clSilver
        end
        object ImgDown: TImage
          Left = 352
          Top = 21
          Width = 37
          Height = 39
          Center = True
        end
        object Label18: TLabel
          Left = 356
          Top = 1
          Width = 27
          Height = 13
          Caption = 'Down'
        end
        object btnCarregarImagem: TButton
          Left = 6
          Top = 73
          Width = 80
          Height = 45
          Caption = 'Carregar Imagem'
          TabOrder = 0
          WordWrap = True
        end
        object btnLocalizarIcones: TButton
          Left = 101
          Top = 73
          Width = 80
          Height = 45
          Caption = 'Localizar Icones'
          TabOrder = 1
          WordWrap = True
        end
        object Button6: TButton
          Left = 193
          Top = 73
          Width = 80
          Height = 45
          Caption = ' Trocar   Imagem'
          TabOrder = 2
          WordWrap = True
        end
        object btnSalvaComoNovaImg: TButton
          Left = 502
          Top = 73
          Width = 80
          Height = 45
          Caption = 'Salvar como Nova Imagem'
          TabOrder = 3
          WordWrap = True
        end
        object ToolBar1: TToolBar
          Left = 726
          Top = 17
          Width = 44
          Height = 48
          Align = alNone
          ButtonHeight = 48
          ButtonWidth = 44
          Caption = 'ToolBar1'
          Color = clGray
          GradientEndColor = clGray
          ParentColor = False
          TabOrder = 4
          Transparent = False
          object ToolButton1: TToolButton
            Left = 0
            Top = 0
          end
        end
        object cbxAtualizarDfm: TCheckBox
          Left = 290
          Top = 98
          Width = 97
          Height = 17
          Caption = 'Atualizar Dfm'
          TabOrder = 5
        end
        object btnSalvarNovaImg: TButton
          Left = 588
          Top = 73
          Width = 89
          Height = 45
          Caption = 'Salvar Nova Imagem'
          TabOrder = 6
          WordWrap = True
        end
        object Button1: TButton
          Left = 712
          Top = 88
          Width = 75
          Height = 25
          Caption = 'Button1'
          TabOrder = 7
        end
        object Button2: TButton
          Left = 393
          Top = 78
          Width = 75
          Height = 35
          Caption = 'Button2'
          TabOrder = 8
        end
      end
      object Panel8: TPanel
        Left = 0
        Top = 388
        Width = 775
        Height = 195
        Align = alBottom
        Caption = 'Panel8'
        TabOrder = 3
        object Label12: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 767
          Height = 13
          Align = alTop
          Caption = 'Log:'
          ExplicitWidth = 21
        end
        object memImagem: TMemo
          Left = 1
          Top = 20
          Width = 773
          Height = 174
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Processamento'
      ImageIndex = 2
      object Splitter1: TSplitter
        Left = 587
        Top = 0
        Height = 583
        Align = alRight
        ExplicitLeft = 352
        ExplicitTop = 184
        ExplicitHeight = 100
      end
      object trvImagens: TTreeView
        Left = 0
        Top = 0
        Width = 587
        Height = 583
        Align = alClient
        HideSelection = False
        Indent = 19
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
      end
      object Panel5: TPanel
        Left = 590
        Top = 0
        Width = 185
        Height = 583
        Align = alRight
        TabOrder = 1
        object Label14: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 414
          Width = 177
          Height = 13
          Align = alBottom
          Caption = 'Localizar Classes:'
          ExplicitWidth = 84
        end
        object ScrollBox1: TScrollBox
          AlignWithMargins = True
          Left = 4
          Top = 300
          Width = 177
          Height = 74
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 0
          object imgAmostra: TImage
            Left = 3
            Top = 2
            Width = 113
            Height = 39
            AutoSize = True
            Proportional = True
            Stretch = True
          end
        end
        object Panel6: TPanel
          Left = 1
          Top = 1
          Width = 183
          Height = 296
          Align = alTop
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 1
          object Bevel1: TBevel
            AlignWithMargins = True
            Left = 3
            Top = 137
            Width = 177
            Height = 4
            Align = alTop
            Shape = bsTopLine
            ExplicitLeft = 5
            ExplicitTop = 106
          end
          object Bevel2: TBevel
            AlignWithMargins = True
            Left = 3
            Top = 65
            Width = 177
            Height = 4
            Align = alTop
            Shape = bsTopLine
          end
          object btnIdentificarImagens: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 177
            Height = 25
            Align = alTop
            Caption = 'Identificar todas Imagens'
            TabOrder = 0
          end
          object btnExpNaoLoc: TButton
            AlignWithMargins = True
            Left = 3
            Top = 209
            Width = 177
            Height = 25
            Align = alTop
            Caption = 'Exportar n'#227'o localizados'
            TabOrder = 1
          end
          object btnSubstituirImgSel: TButton
            AlignWithMargins = True
            Left = 3
            Top = 178
            Width = 177
            Height = 25
            Align = alTop
            Caption = 'Substituir imagem selecionada'
            TabOrder = 2
          end
          object btnSubstituirTodasImg: TButton
            AlignWithMargins = True
            Left = 3
            Top = 34
            Width = 177
            Height = 25
            Align = alTop
            Caption = 'Substituir todas imagens'
            TabOrder = 3
          end
          object btnListarImagensNovas: TButton
            AlignWithMargins = True
            Left = 3
            Top = 106
            Width = 177
            Height = 25
            Align = alTop
            Caption = 'Listar Imagens Novas'
            TabOrder = 4
          end
          object btnIdentificarImagemSel: TButton
            AlignWithMargins = True
            Left = 3
            Top = 147
            Width = 177
            Height = 25
            Align = alTop
            Caption = 'Identificar Imagem Selecionada'
            TabOrder = 5
          end
          object btnAddImagemAvulsa: TButton
            AlignWithMargins = True
            Left = 3
            Top = 75
            Width = 177
            Height = 25
            Align = alTop
            Caption = 'Adicional imagem avulsa'
            TabOrder = 6
          end
          object btnSalvarListagem: TButton
            AlignWithMargins = True
            Left = 3
            Top = 240
            Width = 177
            Height = 25
            Align = alTop
            Caption = 'Salvar Listagem'
            TabOrder = 7
          end
          object btnCarregarListagem: TButton
            AlignWithMargins = True
            Left = 3
            Top = 271
            Width = 177
            Height = 25
            Align = alTop
            Caption = 'Carregar Listagem'
            TabOrder = 8
          end
        end
        object Panel7: TPanel
          Left = 1
          Top = 377
          Width = 183
          Height = 34
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 2
          object btnZoomMenos: TButton
            Left = 5
            Top = 3
            Width = 36
            Height = 25
            Caption = '-'
            TabOrder = 0
          end
          object btnZoomMais: TButton
            Left = 47
            Top = 3
            Width = 36
            Height = 25
            Caption = '+'
            TabOrder = 1
          end
        end
        object clbClasses: TCheckListBox
          Left = 1
          Top = 430
          Width = 183
          Height = 152
          Align = alBottom
          ItemHeight = 13
          Items.Strings = (
            'TImageList'
            'TspImageList'
            'TSpeedButton'
            'TSpeedButtonEx'
            'TspSpeedButton'
            'TspBitBtn'
            'TBitBtn'
            'TspBotaoBitmap'
            'TImage'
            'TspImage'
            'TspTituloAbreFecha')
          TabOrder = 3
        end
      end
    end
  end
end
