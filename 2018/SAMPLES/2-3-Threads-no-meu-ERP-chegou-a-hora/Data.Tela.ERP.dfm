object dmdTelaERP: TdmdTelaERP
  OldCreateOrder = False
  Height = 413
  Width = 730
  object memCotacao: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 488
    Top = 24
    object memCotacaodescription: TStringField
      FieldName = 'description'
      Size = 200
    end
    object memCotacaoperiod: TStringField
      FieldName = 'period'
      Size = 50
    end
    object memCotacaounit: TStringField
      FieldName = 'unit'
      Size = 50
    end
    object memCotacaoname: TStringField
      FieldName = 'name'
      Size = 150
    end
    object memCotacaodata: TDateTimeField
      FieldName = 'data'
    end
    object memCotacaovalor: TCurrencyField
      FieldName = 'valor'
    end
  end
  object RESTClient: TRESTClient
    BaseURL = 'https://blockchain.info/charts/market-price?format=json'
    Params = <>
    HandleRedirects = True
    Left = 552
    Top = 72
  end
  object RESTResponse1: TRESTResponse
    Left = 600
    Top = 136
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 504
    Top = 136
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Aquasoft\Desktop\exemplos-delphi\SQLite\fast_n' +
        'ovo.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 136
    Top = 24
  end
  object qryCliente: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from CUSTOMER')
    Left = 56
    Top = 152
  end
  object qryCompras: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from SALES')
    Left = 136
    Top = 152
  end
  object qryProjeto: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from PROJECT')
    Left = 224
    Top = 152
  end
end
