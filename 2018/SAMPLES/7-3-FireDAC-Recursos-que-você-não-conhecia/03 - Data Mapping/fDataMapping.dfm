object FrmDataMapping: TFrmDataMapping
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '03 - Data Mapping'
  ClientHeight = 449
  ClientWidth = 609
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object panLeft: TPanel
    Left = 0
    Top = 0
    Width = 300
    Height = 449
    Align = alLeft
    Caption = 'panLeft'
    ShowCaption = False
    TabOrder = 0
    ExplicitHeight = 439
    object vleOffMapping: TValueListEditor
      AlignWithMargins = True
      Left = 4
      Top = 35
      Width = 292
      Height = 410
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 400
      ColWidths = (
        150
        136)
    end
    object btnMappingOff: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 292
      Height = 25
      Align = alTop
      Caption = 'Mapping Off'
      TabOrder = 1
      OnClick = btnMappingOffClick
      ExplicitLeft = 112
      ExplicitTop = 208
      ExplicitWidth = 75
    end
  end
  object panRigth: TPanel
    Left = 300
    Top = 0
    Width = 309
    Height = 449
    Align = alClient
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitWidth = 300
    ExplicitHeight = 439
    object vleOnMapping: TValueListEditor
      Left = 1
      Top = 32
      Width = 307
      Height = 416
      Align = alClient
      TabOrder = 0
      ExplicitTop = 1
      ExplicitWidth = 298
      ExplicitHeight = 437
      ColWidths = (
        150
        151)
    end
    object btnMappingOn: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 301
      Height = 25
      Align = alTop
      Caption = 'Mapping On'
      TabOrder = 1
      OnClick = btnMappingOnClick
      ExplicitLeft = 8
      ExplicitTop = 12
      ExplicitWidth = 291
    end
  end
end
