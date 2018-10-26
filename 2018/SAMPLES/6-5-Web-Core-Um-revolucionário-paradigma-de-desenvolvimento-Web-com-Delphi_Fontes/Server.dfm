object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 242
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object XDataServer1: TXDataServer
    BaseUrl = 'http://+:2001/tms/nota'
    Dispatcher = SparkleHttpSysDispatcher1
    EntitySetPermissions = <>
    Left = 72
    Top = 88
    object XDataServer1CORS: TSparkleCorsMiddleware
    end
  end
  object SparkleHttpSysDispatcher1: TSparkleHttpSysDispatcher
    Active = True
    Left = 72
    Top = 24
  end
end
