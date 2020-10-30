object DMArrayDML: TDMArrayDML
  OldCreateOrder = False
  Height = 281
  Width = 349
  object ConnectionFirebird: TFDConnection
    Params.Strings = (
      
        'Database=C:\ECON2018\7-3-FireDAC-Recursos-que-voc'#234'-n'#227'o-conhecia\' +
        '00 - DB\ECON2018.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 88
    Top = 32
  end
  object Query: TFDQuery
    Connection = ConnectionFirebird
    SQL.Strings = (
      'INSERT INTO ARRAY_DML VALUES(:item)')
    Left = 88
    Top = 88
    ParamData = <
      item
        Name = 'ITEM'
        DataType = ftString
        ParamType = ptInput
        Size = 100
        Value = Null
      end>
  end
end
