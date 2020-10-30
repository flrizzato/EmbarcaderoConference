object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Tethering Manager'
  ClientHeight = 331
  ClientWidth = 364
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 16
    Top = 16
    Width = 225
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 247
    Top = 14
    Width = 99
    Height = 31
    Action = Action1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object ListBox1: TListBox
    Left = 16
    Top = 51
    Width = 330
    Height = 254
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 19
    ParentFont = False
    TabOrder = 2
  end
  object ActionList1: TActionList
    Left = 272
    Top = 121
    object Action1: TAction
      Caption = 'Add'
      OnExecute = Action1Execute
    end
  end
  object TetheringManager1: TTetheringManager
    Text = 'TetheringManager1'
    Left = 272
    Top = 176
  end
  object TetheringAppProfile1: TTetheringAppProfile
    Manager = TetheringManager1
    Text = 'TetheringAppProfile1'
    Group = 'Group1'
    Actions = <
      item
        Name = 'Action1'
        IsPublic = True
        Action = Action1
        NotifyUpdates = False
      end>
    Resources = <>
    OnResourceReceived = TetheringAppProfile1ResourceReceived
    Left = 272
    Top = 232
  end
end
