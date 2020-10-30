object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Customers - TMS Business Demo'
  ClientHeight = 188
  ClientWidth = 439
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Customers'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 39
    Width = 75
    Height = 25
    Caption = 'Countries'
    TabOrder = 1
    OnClick = Button2Click
  end
  object MainMenu1: TMainMenu
    Left = 208
    Top = 40
    object ools1: TMenuItem
      Caption = 'Tools'
      object UpdateDatabase1: TMenuItem
        Caption = 'Update Database'
        OnClick = UpdateDatabase1Click
      end
    end
    object Phone1: TMenuItem
      Caption = 'Phone'
      object IncludeCountryCode1: TMenuItem
        Caption = 'Include Country Code'
        OnClick = IncludeCountryCode1Click
      end
      object ExcludeCountryCode1: TMenuItem
        Caption = 'Exclude Country Code'
        OnClick = ExcludeCountryCode1Click
      end
    end
    object Connections1: TMenuItem
      Caption = 'Connections'
      object ConnSQLiteAction1: TMenuItem
        Action = ConnSQLiteAction
      end
      object ConnFirebirdAction1: TMenuItem
        Action = ConnFirebirdAction
      end
      object ConnRemoteDBAction1: TMenuItem
        Action = ConnRemoteDBAction
      end
    end
  end
  object ActionList1: TActionList
    Left = 208
    Top = 104
    object ConnSQLiteAction: TAction
      Caption = 'SQLite'
      OnExecute = ConnSQLiteActionExecute
      OnUpdate = ConnSQLiteActionUpdate
    end
    object ConnFirebirdAction: TAction
      Caption = 'Firebird'
      OnExecute = ConnFirebirdActionExecute
      OnUpdate = ConnFirebirdActionUpdate
    end
    object ConnRemoteDBAction: TAction
      Caption = 'RemoteDB'
      OnExecute = ConnRemoteDBActionExecute
      OnUpdate = ConnRemoteDBActionUpdate
    end
  end
end
