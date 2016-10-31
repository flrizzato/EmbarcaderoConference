object FrmMain: TFrmMain
  Left = 373
  Top = 178
  Caption = 'Vcl Styles Demo'
  ClientHeight = 534
  ClientWidth = 662
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 662
    Height = 534
    Align = alClient
    BorderWidth = 5
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 6
      Top = 6
      Width = 650
      Height = 522
      ActivePage = TabSheet2
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Loaded Styles'
        DesignSize = (
          642
          494)
        object ListBoxLoadedStyles: TListBox
          Left = 8
          Top = 0
          Width = 631
          Height = 457
          Anchors = [akLeft, akTop, akRight, akBottom]
          ItemHeight = 13
          TabOrder = 0
        end
        object BtnApply: TButton
          Left = 3
          Top = 463
          Width = 82
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = 'Apply'
          TabOrder = 1
          OnClick = BtnApplyClick
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Read Styles from folder'
        ImageIndex = 1
        DesignSize = (
          642
          494)
        object BtnRegister: TButton
          Left = 3
          Top = 468
          Width = 110
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = 'Register and Set'
          TabOrder = 0
          OnClick = BtnRegisterClick
        end
        object ListBoxDiskStyles: TListBox
          Left = 3
          Top = 3
          Width = 636
          Height = 462
          Anchors = [akLeft, akTop, akRight, akBottom]
          ItemHeight = 13
          TabOrder = 1
        end
      end
    end
  end
  object ImageList1: TImageList
    Left = 64
    Top = 72
  end
end
