object dmDBDemos: TdmDBDemos
  OldCreateOrder = False
  Height = 169
  Width = 294
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=E:\Delphi\XE7\Samples\Data\dbdemos.gdb'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=IB')
    LoginPrompt = False
    Left = 72
    Top = 48
  end
end
