object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  OnCreate = Z
  Height = 335
  Width = 514
  object FDQueryDepartmentEmployees: TFDQuery
    Connection = FDConnectionEMPLOYEE
    SQL.Strings = (
      'select * from employee where dept_no = :DEPT'
      '')
    Left = 232
    Top = 152
    ParamData = <
      item
        Name = 'DEPT'
        DataType = ftString
        ParamType = ptInput
        Size = 3
        Value = '000'
      end>
  end
  object FDQueryDepartment: TFDQuery
    Connection = FDConnectionEMPLOYEE
    SQL.Strings = (
      'select * from department where DEPT_NO = :DEPT')
    Left = 232
    Top = 96
    ParamData = <
      item
        Name = 'DEPT'
        DataType = ftString
        ParamType = ptInput
        Size = 3
        Value = '000'
      end>
  end
  object FDQueryDepartmentNames: TFDQuery
    Connection = FDConnectionEMPLOYEE
    SQL.Strings = (
      'select dept_no, department  from department')
    Left = 232
    Top = 40
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 88
    Top = 152
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 87
    Top = 96
  end
  object FDConnectionEMPLOYEE: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Public\Documents\Embarcadero\Studio\15.0\Sampl' +
        'es\Data\EMPLOYEE.GDB'
      'Protocol=TCPIP'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=localhost'
      'DriverID=IB')
    LoginPrompt = False
    Left = 87
    Top = 40
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 88
    Top = 208
  end
end
