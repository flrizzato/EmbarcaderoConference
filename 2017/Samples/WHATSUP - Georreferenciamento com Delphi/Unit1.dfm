object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 
    'Geolocaliza'#231#227'o - 14'#186' Firebird Developers Day - Carlos Henrique C' +
    'antu (c)'
  ClientHeight = 603
  ClientWidth = 968
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 968
    Height = 603
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Clientes'
      object DBGrid1: TDBGrid
        Left = 0
        Top = 29
        Width = 960
        Height = 527
        Align = alClient
        DataSource = dsCadastros
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        OnTitleClick = DBGrid1TitleClick
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Title.Caption = 'C'#243'digo'
            Width = 40
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Title.Caption = 'Nome'
            Width = 320
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ENDERECO'
            Title.Caption = 'Endere'#231'o'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NUMERO'
            Title.Caption = 'N'#250'mero'
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BAIRRO'
            Title.Caption = 'Bairro'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CIDADE'
            Title.Caption = 'Cidade'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ESTADO'
            Title.Caption = 'UF'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CEP'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CGC_CPF'
            Title.Caption = 'CNPJ'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'LAT'
            Title.Caption = 'Latitude'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LNG'
            Title.Caption = 'Longitude'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LASTGEOTRY'
            Title.Caption = #218'lt Tentativa'
            Visible = True
          end>
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 960
        Height = 29
        Align = alTop
        TabOrder = 1
        object DBNavigator1: TDBNavigator
          Left = 1
          Top = 1
          Width = 456
          Height = 27
          DataSource = dsCadastros
          Align = alLeft
          TabOrder = 0
        end
        object edIncSearch: TEdit
          Left = 457
          Top = 1
          Width = 156
          Height = 27
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnKeyPress = edIncSearchKeyPress
          ExplicitHeight = 24
        end
        object BitBtn1: TBitBtn
          Left = 619
          Top = 2
          Width = 114
          Height = 25
          Caption = 'Geolocalizar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C30E0000C30E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF887C7873656175696789827FFF00FFFF00FFA39D
            9BAC6E61AB7064FF00FFFF00FFFF00FFFF00FFFF00FF74715E5C6E4DC58266CA
            8567C58265B8775E965E4EA69995B77561DFAA90DDA58ABF816FFF00FFFF00FF
            BCA69DB5735C2B97703FB9985E7E58DBB09DD8AE9BD6AC9AC6A494BC785DDDAA
            8EF1C8ACEEC2A9C48066FF00FFC6B0A8BE795FCE86655887603CC8A68CCFBD4A
            564A534D4A534D496A574DB17D63E3B598EABEA3CC8868FF00FFFF00FFB3715C
            DB906DDE956F4DA87C8FD6C44D514F8F9B91CEC9B4E3CCB9A4968C524D4BB582
            65BE8760BFB2AAFF00FFC2A397E09674EB9972A09066B9EFE14A6F658B968BD1
            DDC0E2D5ADF9D8B5F5DBC0989489625F54B6DED35E7758FF00FFBC826DEEA27B
            EAA37CB89D74BBEADE555755B9C3ADEFD1A4F7D29CF8D5A8D3DBB5BFD6C25655
            529DD6C8409A74FF00FFC27C5FEBA67E7CA57A3EB38CD1DECF615E5CD6C6B0EE
            D0A0F3CF92F5D39DCAD8ADBACFBB5F5D5CABDFD542BB9AABB3A5B77D5B3F9D71
            4EDAB6459C71CBE1D28F8279A89F95EFD8B4EFD19EF0D19EDDD1AC969D91647D
            76A8CFBF448A67AEB2A36D88654EDCB854E4C756E6C648D0A8DADDD26E6A68A9
            A196D9CAB1D8C7ACA39A8D666664B7DCCF29B288289F79BABCAFA0997F4DDCC2
            54E6CF54E6CF5EE8D194E9D3C6E2D68C87806C67666C67668F8279CFDFD395E4
            D471E6D0559370FF00FFFF00FF4EB1915EE9D76BEBDA4FC9AD73EEDA57CFB2EC
            EBE0FBF1E9FAEDE4FAEADD73B59261A67EA7A680AD8F72FF00FFFF00FF9F997B
            58DAC354C3A286B59132C19D80BFA05CC6A162C5A1DBD1B8F5CFB4F4C3A4F6B9
            97D78E67FF00FFFF00FFFF00FFFF00FF8F967345CAAA28A87F48D4B765B5913C
            CBA85CEACE42D4AEA7B896F8BFA0DF9A75D1BAA9FF00FFFF00FFFF00FFFF00FF
            FF00FFAF997939996E91B18C6CB79162E8CB74EFE076EDDB5AB792D69671FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBFA38672A58374
            B8996EAF8D8AA180C7BAA7FF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 2
          OnClick = BitBtn1Click
        end
      end
      object StatusBar1: TStatusBar
        Left = 0
        Top = 556
        Width = 960
        Height = 19
        Panels = <>
        SimplePanel = True
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Consulta'
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 960
        Height = 145
        Align = alTop
        Caption = 'Panel2'
        TabOrder = 0
        DesignSize = (
          960
          145)
        object PageControl2: TPageControl
          Left = 1
          Top = 1
          Width = 958
          Height = 143
          ActivePage = TabSheet3
          Align = alClient
          MultiLine = True
          TabOrder = 2
          TabPosition = tpLeft
          object TabSheet3: TTabSheet
            Caption = 'Query'
            object Memo1: TMemo
              Left = 0
              Top = 0
              Width = 930
              Height = 135
              Align = alClient
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -19
              Font.Name = 'Courier New'
              Font.Style = [fsBold]
              Lines.Strings = (
                'select *'
                'from CHC_GETCLIENTECOORD (-23.574859,-46.621226, 500)')
              ParentFont = False
              TabOrder = 0
            end
          end
          object TabSheet4: TTabSheet
            Caption = 'Plan'
            ImageIndex = 1
            object mePlan: TMemo
              Left = 0
              Top = 0
              Width = 930
              Height = 135
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
          end
        end
        object Button1: TButton
          Left = 876
          Top = 112
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Executar'
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 876
          Top = 81
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Fechar'
          TabOrder = 1
          OnClick = Button2Click
        end
      end
      object DBGrid2: TDBGrid
        Left = 0
        Top = 145
        Width = 960
        Height = 430
        Align = alClient
        DataSource = dsConsulta
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        OnTitleClick = DBGrid1TitleClick
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Title.Caption = 'C'#243'digo'
            Width = 40
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Title.Caption = 'Nome'
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LOCAL'
            Title.Caption = 'Endere'#231'o'
            Width = 350
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LONGITUDE'
            Title.Caption = 'Longitude'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LATITUDE'
            Title.Caption = 'Latitude'
            Visible = True
          end>
      end
    end
  end
  object DB: TIBODatabase
    CacheStatementHandles = False
    SQLDialect = 3
    Params.Strings = (
      'PATH=D:\varios\Palestras\14 FDD GIS\GIS.FDB'
      'CHARACTER SET=WIN1252'
      'USER NAME=SYSDBA'
      'BUFFERS=<default>'
      'SQL DIALECT=3'
      'SERVER=localhost'
      'PROTOCOL=TCP/IP')
    Isolation = tiCommitted
    DriverName = ''
    Left = 632
    Top = 80
    SavedPassword = '.JuMbLe.01.432B0639073E0E4B49'
  end
  object Cadastros: TIBOQuery
    IB_Connection = DB
    KeyLinks.Strings = (
      'CODIGO')
    KeyLinksAutoDefine = False
    PreparedEdits = True
    PreparedInserts = True
    RecordCountAccurate = True
    OnFilterRecord = CadastrosFilterRecord
    RequestLive = True
    SQL.Strings = (
      'select CODIGO'
      '     , NOME'
      '     , ENDERECO'
      '     , NUMERO'
      '     , CIDADE'
      '     , BAIRRO'
      '     , ESTADO'
      '     , CEP'
      '     , CGC_CPF'
      '     , LAT'
      '     , LNG'
      '     , LASTGEOTRY'
      'FROM CLIFOR'
      'ORDER BY CODIGO')
    Left = 628
    Top = 152
    object CadastrosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object CadastrosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 70
    end
    object CadastrosENDERECO: TStringField
      FieldName = 'ENDERECO'
      Required = True
      Size = 40
    end
    object CadastrosNUMERO: TStringField
      FieldName = 'NUMERO'
    end
    object CadastrosCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 55
    end
    object CadastrosBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 60
    end
    object CadastrosESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 2
    end
    object CadastrosCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object CadastrosCGC_CPF: TStringField
      FieldName = 'CGC_CPF'
      Size = 18
    end
    object CadastrosLAT: TIBOFmtBCDField
      FieldName = 'LAT'
      Precision = 9
      Size = 6
    end
    object CadastrosLNG: TIBOFmtBCDField
      FieldName = 'LNG'
      Precision = 9
      Size = 6
    end
    object CadastrosLASTGEOTRY: TDateTimeField
      FieldName = 'LASTGEOTRY'
    end
  end
  object dsCadastros: TDataSource
    DataSet = Cadastros
    Left = 628
    Top = 216
  end
  object IncSearchTimer: TTimer
    Enabled = False
    Interval = 150
    OnTimer = IncSearchTimerTimer
    Left = 624
    Top = 288
  end
  object tqConsulta: TIBOQuery
    IB_Connection = DB
    IB_Transaction = TransQuery
    PreparedEdits = True
    PreparedInserts = True
    RecordCountAccurate = True
    SQL.Strings = (
      'select *'
      'from CHC_GETCLIENTECOORD (-23.574859,-46.621226, 500)')
    Left = 876
    Top = 216
  end
  object dsConsulta: TDataSource
    AutoEdit = False
    DataSet = tqConsulta
    Left = 876
    Top = 284
  end
  object TransQuery: TIB_Transaction
    IB_Connection = DB
    ReadOnly = True
    Isolation = tiCommitted
    Left = 872
    Top = 352
  end
  object CriarDB: TIB_Script
    SQL.Strings = (
      'set auto ddl on;'
      ''
      'CREATE DOMAIN D_GPS AS'
      'NUMERIC(7,6);'
      ''
      'CREATE GENERATOR GEN_CLIFOR_ID;'
      ''
      ''
      'SET TERM ^ ;'
      ''
      'CREATE PROCEDURE CHC_GETCLIENTECOORD ('
      '    LAT DOUBLE PRECISION,'
      '    LNG DOUBLE PRECISION,'
      '    RAIO_METROS FLOAT)'
      'RETURNS ('
      '    CODIGO INTEGER,'
      '    NOME VARCHAR(70) /* TYPE OF COLUMN CLIFOR.NOME */,'
      '    LOCAL VARCHAR(150),'
      '    LONGITUDE D_GPS,'
      '    LATITUDE D_GPS)'
      'AS'
      'BEGIN'
      '  SUSPEND;'
      'END^'
      ''
      ''
      ''
      ''
      ''
      'CREATE PROCEDURE CHC_GETCLIENTECOORD_V1 ('
      '    LAT DOUBLE PRECISION,'
      '    LNG DOUBLE PRECISION,'
      '    RAIO_METROS FLOAT)'
      'RETURNS ('
      '    CODIGO INTEGER,'
      '    NOME VARCHAR(70) /* TYPE OF COLUMN CLIFOR.NOME */,'
      '    LOCAL VARCHAR(150),'
      '    LONGITUDE D_GPS,'
      '    LATITUDE D_GPS)'
      'AS'
      'BEGIN'
      '  SUSPEND;'
      'END^'
      ''
      'SET TERM ; ^'
      ''
      'CREATE TABLE CLIFOR ('
      '    CODIGO      INTEGER NOT NULL,'
      '    NOME        VARCHAR(70) NOT NULL,'
      '    ENDERECO    VARCHAR(40) NOT NULL,'
      '    NUMERO      VARCHAR(20),'
      '    CIDADE      VARCHAR(55),'
      '    BAIRRO      VARCHAR(60),'
      '    ESTADO      VARCHAR(2),'
      '    CEP         VARCHAR(9),'
      '    CGC_CPF     VARCHAR(18),'
      '    LAT         D_GPS,'
      '    LNG         D_GPS,'
      '    LASTGEOTRY  TIMESTAMP'
      ');'
      ''
      'ALTER TABLE CLIFOR ADD CONSTRAINT UNQ1_CLIFOR UNIQUE (CGC_CPF);'
      ''
      
        'ALTER TABLE CLIFOR ADD CONSTRAINT PK_CLIFOR PRIMARY KEY (CODIGO)' +
        ';'
      ''
      'CREATE INDEX IDX_CLIFOR_LAT ON CLIFOR (LAT);'
      'CREATE INDEX IDX_CLIFOR_LNG ON CLIFOR (LNG);'
      ''
      'SET TERM ^ ;'
      ''
      '/* Trigger: CLIFOR_BI */'
      'CREATE TRIGGER CLIFOR_BI FOR CLIFOR'
      'ACTIVE BEFORE INSERT POSITION 0'
      'as'
      'begin'
      '  if (new.codigo is null) then'
      '    new.codigo = gen_id(gen_clifor_id,1);'
      'end'
      '^'
      ''
      'ALTER PROCEDURE CHC_GETCLIENTECOORD ('
      '    LAT DOUBLE PRECISION,'
      '    LNG DOUBLE PRECISION,'
      '    RAIO_METROS FLOAT)'
      'RETURNS ('
      '    CODIGO INTEGER,'
      '    NOME TYPE OF COLUMN CLIFOR.NOME,'
      '    LOCAL VARCHAR(150),'
      '    LONGITUDE D_GPS,'
      '    LATITUDE D_GPS)'
      'AS'
      'declare variable MAXLAT D_GPS;'
      'declare variable MAXLNG D_GPS;'
      'declare variable MINLAT D_GPS;'
      'declare variable MINLNG D_GPS;'
      'declare variable DELTA double precision;'
      'begin'
      '  DELTA = (RAIO_METROS / 6371008) * (180 / 3.14159);'
      '  MAXLAT = LAT + DELTA;'
      '  MINLAT = LAT - DELTA;'
      ''
      
        '  DELTA = (RAIO_METROS / 6371008 / cos(LAT * 3.14159 / 180)) * (' +
        '180 / 3.14159);'
      '  MAXLNG = LNG + DELTA;'
      '  MINLNG = LNG - DELTA;'
      ''
      '  LAT = LAT * 3.14159 / 180; -- Converte graus em radianos'
      '  LNG = LNG * 3.14159 / 180; -- Converte graus em radianos'
      ''
      '  for select C.CODIGO, C.NOME, C.LAT, C.LNG,'
      '             (C.ENDERECO || '#39', '#39' || C.NUMERO || '#39' - '#39' ||'
      '              coalesce(C.BAIRRO || '#39' - '#39', '#39#39') ||'
      '              C.CIDADE || '#39'/'#39' || ESTADO) as LOCAL'
      '      from CLIFOR C'
      '      where (C.LAT between :MINLAT and :MAXLAT) and'
      '            (C.LNG between :MINLNG and :MAXLNG) and'
      
        '            (acos(sin(:LAT) * sin(C.LAT * 3.14159 / 180) + cos(:' +
        'LAT) *'
      
        '             cos(C.LAT * 3.14159 / 180) * cos((C.LNG * 3.14159 /' +
        ' 180) - :LNG)) * 6371008) < :RAIO_METROS -- Raio da Terra  = 637' +
        '1008m'
      '      into :CODIGO, :NOME, :LATITUDE, :LONGITUDE, :LOCAL'
      '  do'
      '    suspend;'
      'end^'
      ''
      ''
      'ALTER PROCEDURE CHC_GETCLIENTECOORD_V1 ('
      '    LAT DOUBLE PRECISION,'
      '    LNG DOUBLE PRECISION,'
      '    RAIO_METROS FLOAT)'
      'RETURNS ('
      '    CODIGO INTEGER,'
      '    NOME TYPE OF COLUMN CLIFOR.NOME,'
      '    LOCAL VARCHAR(150),'
      '    LONGITUDE D_GPS,'
      '    LATITUDE D_GPS)'
      'AS'
      'begin'
      '  LAT = LAT * 3.14159 / 180; -- Converte graus em radianos'
      '  LNG = LNG * 3.14159 / 180; -- Converte graus em radianos'
      ''
      '  for select C.CODIGO, C.NOME, C.LAT, C.LNG,'
      '             (C.ENDERECO || '#39', '#39' || C.NUMERO || '#39' - '#39' ||'
      '              coalesce(C.BAIRRO || '#39' - '#39', '#39#39') ||'
      '              C.CIDADE || '#39'/'#39' || ESTADO) as LOCAL'
      '      from CLIFOR C'
      
        '      where (acos(sin(:LAT) * sin(C.LAT * 3.14159 / 180) + cos(:' +
        'LAT) *'
      
        '             cos(C.LAT * 3.14159 / 180) * cos((C.LNG * 3.14159 /' +
        ' 180) - :LNG)) * 6371008) < :RAIO_METROS'
      '      into :CODIGO, :NOME, :LATITUDE, :LONGITUDE, :LOCAL'
      '  do'
      '    suspend;'
      'end^'
      ''
      'SET TERM ; ^'
      ''
      'set auto ddl off;'
      ''
      'commit;')
    IB_Connection = DB
    Left = 876
    Top = 140
  end
end
