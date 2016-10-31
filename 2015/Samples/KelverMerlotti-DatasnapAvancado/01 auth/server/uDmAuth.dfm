object dmAuth: TdmAuth
  OldCreateOrder = False
  Height = 150
  Width = 215
  object ConAuth: TFDConnection
    Params.Strings = (
      'Database=D:\CodeRage X USA\Samples\EMPLOYEE.GDB'
      'Password=masterkey'
      'User_Name=SYSDBA'
      'DriverID=IB')
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 136
    Top = 16
  end
  object qry: TFDQuery
    Connection = ConAuth
    SQL.Strings = (
      'select '
      '  emp_no, '
      '  job_code '
      'from '
      '  employee '
      'where '
      '  last_name = :username and '
      '  phone_ext = :password')
    Left = 32
    Top = 72
    ParamData = <
      item
        Name = 'USERNAME'
        DataType = ftString
        ParamType = ptInput
        Size = 20
        Value = Null
      end
      item
        Name = 'PASSWORD'
        DataType = ftString
        ParamType = ptInput
        Size = 4
      end>
    object qryEMP_NO: TSmallintField
      FieldName = 'EMP_NO'
      Origin = 'EMP_NO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryJOB_CODE: TStringField
      FieldName = 'JOB_CODE'
      Origin = 'JOB_CODE'
      Required = True
      Size = 5
    end
  end
end
