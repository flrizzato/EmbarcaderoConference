object UDMRest: TUDMRest
  OldCreateOrder = False
  Height = 345
  Width = 539
  object rstClient: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'http://localhost:8080/datasnap/rest/TSrvMetodos/GetTickets/'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 48
    Top = 96
  end
  object rstRequest: TRESTRequest
    Params = <>
    SynchronizedEvents = False
    Left = 112
    Top = 24
  end
  object rstResponse: TRESTResponse
    Left = 152
    Top = 96
  end
  object rstAdapt: TRESTResponseDataSetAdapter
    FieldDefs = <>
    RootElement = 'Tickets'
    NestedElements = True
    Left = 104
    Top = 176
  end
  object memDados: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 104
    Top = 264
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 368
    Top = 16
  end
end
