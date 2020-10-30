object Dtm: TDtm
  OldCreateOrder = False
  Height = 365
  Width = 542
  object FDBatchMove1: TFDBatchMove
    Reader = FDBatchMoveDataSetReader1
    Writer = FDBatchMoveTextWriter1
    Options = [poClearDest, poIdentityInsert, poCreateDest]
    Mappings = <>
    LogFileName = 'Data.log'
    OnProgress = FDBatchMove1Progress
    Left = 104
    Top = 136
  end
  object FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader
    DataSet = SqlClientes
    Optimise = False
    Left = 80
    Top = 245
  end
  object FDConnMSSQL: TFDConnection
    Params.Strings = (
      'Database=EC-2014'
      'User_Name=sa'
      'Password=732154Al#'
      'Server=localhost'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 32
  end
  object SqlClientes: TFDQuery
    CachedUpdates = True
    Connection = FDConnMSSQL
    FetchOptions.AssignedValues = [evMode, evItems, evRowsetSize, evCache, evUnidirectional]
    FetchOptions.Mode = fmAll
    FetchOptions.RowsetSize = 100
    FetchOptions.Items = [fiBlobs, fiDetails]
    FetchOptions.Cache = [fiDetails]
    SQL.Strings = (
      'select top 1000 * from clientes')
    Left = 40
    Top = 80
    object SqlClientesId: TIntegerField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SqlClientesNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 50
    end
    object SqlClientesDataNascimento: TDateField
      FieldName = 'DataNascimento'
      Origin = 'DataNascimento'
      Required = True
    end
  end
  object FDBatchMoveTextWriter1: TFDBatchMoveTextWriter
    FileName = 'C:\Programacao\EC 2014\BatchMove\DataOut.txt'
    DataDef.Fields = <>
    DataDef.Delimiter = '"'
    DataDef.Separator = ';'
    DataDef.RecordFormat = rfCustom
    DataDef.WithFieldNames = True
    Left = 80
    Top = 296
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrHourGlass
    Left = 416
    Top = 32
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 416
    Top = 80
  end
  object SqlClientes1: TFDQuery
    Connection = FDConnINTERBASE
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'select * from clientes1')
    Left = 168
    Top = 80
  end
  object FDConnINTERBASE: TFDConnection
    Params.Strings = (
      'Database=C:\Programacao\EC 2014\Bancos\EC-2014.GDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    Left = 168
    Top = 32
  end
  object FDBatchMoveTextReader1: TFDBatchMoveTextReader
    FileName = 'C:\Programacao\EC 2014\BatchMove\DataOut.txt'
    DataDef.Fields = <>
    DataDef.Delimiter = '"'
    DataDef.Separator = ';'
    DataDef.RecordFormat = rfCustom
    Left = 248
    Top = 245
  end
  object FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter
    DataSet = SqlClientes1
    Optimise = False
    Left = 248
    Top = 296
  end
  object FDBatchMoveDataSetReader2: TFDBatchMoveDataSetReader
    DataSet = SqlClientes
    Optimise = False
    Left = 424
    Top = 245
  end
  object FDBatchMoveDataSetWriter2: TFDBatchMoveDataSetWriter
    DataSet = SqlClientes1
    Optimise = False
    Left = 424
    Top = 296
  end
end
