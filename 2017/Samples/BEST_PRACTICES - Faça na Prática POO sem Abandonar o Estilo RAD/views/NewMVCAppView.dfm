object NewMVCAppView: TNewMVCAppView
  Left = 0
  Top = 0
  Caption = 'NewMVCAppView'
  ClientHeight = 354
  ClientWidth = 619
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormFactoryCreate
  OnDestroy = FormFactoryDestroy
  OnViewEvent = FormFactoryViewEvent
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 509
    Height = 314
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 9
    ExplicitWidth = 596
    ExplicitHeight = 240
    object TabSheet1: TTabSheet
      Caption = 'Mensagens'
      ExplicitWidth = 361
      ExplicitHeight = 212
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 501
        Height = 286
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          'Memo1')
        TabOrder = 0
        ExplicitWidth = 361
        ExplicitHeight = 212
      end
    end
  end
  object Panel1: TPanel
    Left = 509
    Top = 0
    Width = 110
    Height = 314
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 600
    ExplicitHeight = 292
    object Button1: TButton
      Left = 14
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Dialog'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 14
      Top = 47
      Width = 75
      Height = 25
      Caption = 'PageView'
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 14
      Top = 78
      Width = 75
      Height = 25
      Caption = 'RESTful'
      TabOrder = 2
      OnClick = Button4Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 314
    Width = 619
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 464
    ExplicitWidth = 720
    DesignSize = (
      619
      40)
    object Edit1: TEdit
      Left = 15
      Top = 9
      Width = 346
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      TextHint = 'CPF para valida'#231#227'o'
      ExplicitWidth = 333
    end
    object Button2: TButton
      Left = 360
      Top = 8
      Width = 145
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'ACBr.ValidarCPF'
      TabOrder = 1
      OnClick = Button2Click
      ExplicitLeft = 347
    end
  end
  object PageViewAdapter: TVCLPageViewManager
    PageControl = PageControl1
    Left = 48
    Top = 104
  end
end
