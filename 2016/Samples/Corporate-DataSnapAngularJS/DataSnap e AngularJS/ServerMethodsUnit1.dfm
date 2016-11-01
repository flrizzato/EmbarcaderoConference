object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 335
  Width = 436
  object ExtremeDelphi: TFDConnection
    Params.Strings = (
      'Database=ExtremeDelphi'
      'User_Name=sa'
      'Password=sysdba'
      'Server=localhost'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 88
    Top = 56
  end
  object spClientesDELETE: TFDStoredProc
    Connection = ExtremeDelphi
    StoredProcName = 'ExtremeDelphi.dbo.spClientesDELETE'
    Left = 88
    Top = 104
    ParamData = <
      item
        Position = 1
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        ParamType = ptResult
      end
      item
        Position = 2
        Name = '@Codigo'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object spClientesINSERT: TFDStoredProc
    Connection = ExtremeDelphi
    StoredProcName = 'ExtremeDelphi.dbo.spClientesINSERT'
    Left = 88
    Top = 152
    ParamData = <
      item
        Position = 1
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        ParamType = ptResult
      end
      item
        Position = 2
        Name = '@Nome'
        DataType = ftString
        ParamType = ptInput
        Size = 50
      end
      item
        Position = 3
        Name = '@Salario'
        DataType = ftCurrency
        Precision = 10
        NumericScale = 4
        ParamType = ptInput
      end>
  end
  object spClientesSELECT: TFDStoredProc
    Connection = ExtremeDelphi
    StoredProcName = 'ExtremeDelphi.dbo.spClientesSELECT'
    Left = 88
    Top = 200
    ParamData = <
      item
        Position = 1
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        ParamType = ptResult
      end>
  end
  object spClientesUPDATE: TFDStoredProc
    Connection = ExtremeDelphi
    StoredProcName = 'ExtremeDelphi.dbo.spClientesUPDATE'
    Left = 88
    Top = 248
    ParamData = <
      item
        Position = 1
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        ParamType = ptResult
      end
      item
        Position = 2
        Name = '@Codigo'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 3
        Name = '@Nome'
        DataType = ftString
        ParamType = ptInput
        Size = 50
      end
      item
        Position = 4
        Name = '@Salario'
        DataType = ftCurrency
        Precision = 10
        NumericScale = 4
        ParamType = ptInput
      end>
  end
end
