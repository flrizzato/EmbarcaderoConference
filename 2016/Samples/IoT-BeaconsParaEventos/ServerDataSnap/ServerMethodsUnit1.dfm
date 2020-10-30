object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 166
  Width = 509
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=iBeaconEventos'
      'User_Name=postgres'
      'Password=nerizon'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object FDQuery1: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'select * from public.usuarios')
    Left = 144
    Top = 32
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = FDQuery1
    Left = 232
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 384
    Top = 32
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    Left = 376
    Top = 96
  end
end
