object MainDM: TMainDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 415
  Width = 556
  object SQLConnection: TSQLConnection
    ConnectionName = 'MASTSQL'
    DriverName = 'INTERBASE'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxint30.dll'
    LoginPrompt = False
    Params.Strings = (
      'drivername=INTERBASE'
      'blobsize=-1'
      'commitretain=False'
      
        'database=D:\BORL_TALKS\DELPHI_CONFERENCE_2009\Ex5\Database\MASTS' +
        'QL.GDB'
      'localecode=0000'
      'password=masterkey'
      'rolename=RoleName'
      'sqldialect=3'
      'isolationlevel=ReadCommitted'
      'user_name=sysdba'
      'waitonlocks=True'
      'trim char=False')
    VendorLib = 'gds32.dll'
    BeforeConnect = SQLConnectionBeforeConnect
    Left = 40
    Top = 24
  end
end
