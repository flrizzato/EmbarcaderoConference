object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 674
  ClientWidth = 759
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -29
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    759
    674)
  PixelsPerInch = 96
  TextHeight = 35
  object Button1: TButton
    Left = 16
    Top = 110
    Width = 361
    Height = 59
    Caption = 'Consultar dist'#226'ncia'
    TabOrder = 0
    OnClick = Button1Click
  end
  object LabeledEdit1: TLabeledEdit
    Left = 16
    Top = 48
    Width = 361
    Height = 43
    EditLabel.Width = 93
    EditLabel.Height = 35
    EditLabel.Caption = 'Origem'
    TabOrder = 1
    Text = 'Natal, RN'
  end
  object LabeledEdit2: TLabeledEdit
    Left = 383
    Top = 48
    Width = 361
    Height = 43
    EditLabel.Width = 97
    EditLabel.Height = 35
    EditLabel.Caption = 'Destino'
    TabOrder = 2
    Text = 'S'#227'o Paulo, SP'
  end
  object Memo1: TMemo
    Left = 16
    Top = 272
    Width = 728
    Height = 345
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 632
    Width = 759
    Height = 42
    Panels = <
      item
        Width = 300
      end>
    ParentFont = True
    UseSystemFont = False
  end
  object LabeledEdit3: TLabeledEdit
    Left = 16
    Top = 216
    Width = 361
    Height = 43
    EditLabel.Width = 116
    EditLabel.Height = 35
    EditLabel.Caption = 'Dist'#226'ncia'
    TabOrder = 5
  end
  object LabeledEdit4: TLabeledEdit
    Left = 383
    Top = 216
    Width = 361
    Height = 43
    EditLabel.Width = 105
    EditLabel.Height = 35
    EditLabel.Caption = 'Dura'#231#227'o'
    TabOrder = 6
  end
  object RESTClient1: TRESTClient
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Params = <>
    HandleRedirects = True
    Left = 440
    Top = 104
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    OnAfterExecute = RESTRequest1AfterExecute
    Left = 576
    Top = 136
  end
  object RESTResponse1: TRESTResponse
    Left = 576
    Top = 184
  end
end
