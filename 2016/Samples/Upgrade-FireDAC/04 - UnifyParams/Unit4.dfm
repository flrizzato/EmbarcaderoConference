object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'UnifyParams'
  ClientHeight = 330
  ClientWidth = 537
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ExtremedelphiConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=ExtremeDelphi')
    Connected = True
    LoginPrompt = False
    Left = 82
    Top = 31
  end
  object FDStoredProc1: TFDStoredProc
    Connection = ExtremedelphiConnection
    StoredProcName = 'DelphiExtreme.dbo.SP_GetCliente'
    Left = 80
    Top = 88
    ParamData = <
      item
        Position = 1
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        ParamType = ptResult
      end
      item
        Position = 2
        Name = '@Id'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
