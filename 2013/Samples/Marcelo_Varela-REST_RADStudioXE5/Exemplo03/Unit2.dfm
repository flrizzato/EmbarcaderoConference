object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 289
  ClientWidth = 907
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 23
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 50
    Width = 901
    Height = 236
    Margins.Top = 50
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -19
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Name'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Description'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ReleaseDate'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DiscontinuedDate'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Rating'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Price'
        Width = 200
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 3
    Top = 8
    Width = 174
    Height = 32
    Caption = 'Carregar dados'
    TabOrder = 1
    OnClick = Button1Click
  end
  object RESTClient1: TRESTClient
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Params = <>
    HandleRedirects = True
    Left = 232
    Top = 104
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    Left = 352
    Top = 160
  end
  object RESTResponse1: TRESTResponse
    Left = 344
    Top = 104
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Active = True
    Dataset = ClientDataSet1
    FieldDefs = <>
    Response = RESTResponse1
    RootElement = 'value'
    Left = 192
    Top = 208
  end
  object ClientDataSet1: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Name'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ReleaseDate'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DiscontinuedDate'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Rating'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Price'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 128
    Top = 104
    Data = {
      E40000009619E0BD010000001800000007000000000003000000E40002494401
      00490000000100055749445448020002003200044E616D650100490000000100
      0557494454480200020064000B4465736372697074696F6E0100490000000100
      0557494454480200020064000B52656C65617365446174650100490000000100
      05574944544802000200320010446973636F6E74696E75656444617465010049
      000000010005574944544802000200320006526174696E670100490000000100
      0557494454480200020032000550726963650100490000000100055749445448
      0200020032000000}
    object ClientDataSet1ID: TStringField
      FieldName = 'ID'
      Size = 50
    end
    object ClientDataSet1Name: TStringField
      FieldName = 'Name'
      Size = 100
    end
    object ClientDataSet1Description: TStringField
      FieldName = 'Description'
      Size = 100
    end
    object ClientDataSet1ReleaseDate: TStringField
      FieldName = 'ReleaseDate'
      Size = 50
    end
    object ClientDataSet1DiscontinuedDate: TStringField
      FieldName = 'DiscontinuedDate'
      Size = 50
    end
    object ClientDataSet1Rating: TStringField
      FieldName = 'Rating'
      Size = 50
    end
    object ClientDataSet1Price: TStringField
      FieldName = 'Price'
      Size = 50
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 128
    Top = 152
  end
end
