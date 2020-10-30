object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'EC2016 | PPL | Provas de Conceitos '
  ClientHeight = 627
  ClientWidth = 840
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LinkLabel1: TLinkLabel
    AlignWithMargins = True
    Left = 5
    Top = 595
    Width = 830
    Height = 27
    Cursor = crHandPoint
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    Alignment = taRightJustify
    Caption = 
      '<a href="http://eugostododelphi.blogspot.com.br">Eu Gosto do Del' +
      'phi</a>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnLinkClick = LinkLabel1LinkClick
    ExplicitWidth = 165
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 830
    Height = 204
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    BevelInner = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object Label5: TLabel
      Left = 200
      Top = 22
      Width = 222
      Height = 13
      Caption = 'TThreadPool.Default.QueueWorkItem()'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 200
      Top = 53
      Width = 85
      Height = 13
      Caption = 'TParallel.Join()'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 200
      Top = 84
      Width = 69
      Height = 13
      Caption = 'TTask.Run()'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 200
      Top = 126
      Width = 126
      Height = 13
      Caption = 'TTask , ITask , IFuture'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 16
      Top = 48
      Width = 169
      Height = 25
      Caption = '&1 - BAIXAR DADOS P'#218'BLICOS'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 16
      Top = 79
      Width = 169
      Height = 25
      Caption = '&2 - DESCOMPACTAR'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 16
      Top = 121
      Width = 169
      Height = 25
      Caption = '&3 - ANALISAR ARQUIVOS'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 16
      Top = 17
      Width = 169
      Height = 25
      Caption = '&0 - LIMPAR DIRET'#211'RIO'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button7: TButton
      Left = 16
      Top = 152
      Width = 75
      Height = 25
      Caption = 'START'
      TabOrder = 4
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 110
      Top = 152
      Width = 75
      Height = 25
      Caption = 'CANCEL'
      TabOrder = 5
      OnClick = Button8Click
    end
  end
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 5
    Top = 219
    Width = 830
    Height = 366
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ActivePage = TabSheet1
    Align = alClient
    Style = tsButtons
    TabOrder = 2
    object TabSheet3: TTabSheet
      Caption = 'Informa'#231#245'es'
      ImageIndex = 2
      object Label1: TLabel
        Left = 24
        Top = 16
        Width = 46
        Height = 19
        Caption = 'Label1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 24
        Top = 41
        Width = 46
        Height = 19
        Caption = 'Label2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 24
        Top = 66
        Width = 46
        Height = 19
        Caption = 'Label3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 24
        Top = 91
        Width = 46
        Height = 19
        Caption = 'Label4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Button5: TButton
        Left = 187
        Top = 300
        Width = 169
        Height = 25
        Caption = 'NOVO VALOR M'#205'NIMO'
        TabOrder = 0
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 12
        Top = 299
        Width = 169
        Height = 25
        Caption = 'NOVO VALOR M'#193'XIMO'
        TabOrder = 1
        OnClick = Button6Click
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Arquivos para download'
      object mLinks: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 816
        Height = 329
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Consolas'
        Font.Style = []
        Lines.Strings = (
          
            'http://agencia.tse.jus.br/estatistica/sead/odsele/consulta_cand/' +
            'consulta_cand_2016.zip'
          
            'http://agencia.tse.jus.br/estatistica/sead/odsele/consulta_cand/' +
            'consulta_cand_2014.zip'
          
            'http://agencia.tse.jus.br/estatistica/sead/odsele/consulta_cand/' +
            'consulta_cand_2010.zip'
          
            'http://agencia.tse.jus.br/estatistica/sead/odsele/consulta_cand/' +
            'consulta_cand_2006.zip'
          
            'http://agencia.tse.jus.br/estatistica/sead/odsele/consulta_cand/' +
            'consulta_cand_2002.zip')
        ParentFont = False
        TabOrder = 0
      end
    end
    object tsLog: TTabSheet
      Caption = 'LOG'
      ImageIndex = 1
      object mLog: TMemo
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 812
        Height = 325
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        Color = clGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clLime
        Font.Height = -16
        Font.Name = 'Consolas'
        Font.Style = []
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Threads acionadas'
      ImageIndex = 3
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 822
        Height = 335
        Align = alClient
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = FDMemTable1
    Left = 137
    Top = 486
  end
  object FDMemTable1: TFDMemTable
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'FDMemTable1Index1'
        Fields = 'THREADID'
        Options = [ixPrimary]
      end>
    IndexFieldNames = 'THREADID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 209
    Top = 486
    object FDMemTable1THREADID: TIntegerField
      FieldName = 'THREADID'
    end
    object FDMemTable1QUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
  end
end
