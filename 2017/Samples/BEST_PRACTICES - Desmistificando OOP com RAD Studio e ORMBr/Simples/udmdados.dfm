object dmdados: Tdmdados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 403
  Width = 670
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Port=3050'
      'Server=localhost'
      'Database=xx'
      'CharacterSet=UTF8'
      'OpenMode=OpenOrCreate'
      'DriverID=FB')
    LoginPrompt = False
    BeforeConnect = FDConnection1BeforeConnect
    Left = 72
    Top = 40
  end
end
