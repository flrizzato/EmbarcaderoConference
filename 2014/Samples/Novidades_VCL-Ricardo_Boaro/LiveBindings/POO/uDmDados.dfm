object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 279
  Width = 451
  object TesteConnection: TFDConnection
    Params.Strings = (
      'Database=CyberERP'
      'User_Name=sa'
      'Password=CJAM@ster'
      'Server=.'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 39
    Top = 20
  end
end
