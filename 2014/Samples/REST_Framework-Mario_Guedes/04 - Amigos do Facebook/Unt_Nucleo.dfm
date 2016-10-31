object dmNucleo: TdmNucleo
  OldCreateOrder = False
  Height = 421
  Width = 403
  object RESTClient1: TRESTClient
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    BaseURL = 'https://graph.facebook.com.br/v2.1'
    Params = <>
    HandleRedirects = True
    Left = 160
    Top = 48
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        name = 'access_token'
        Value = 
          'CAACEdEose0cBABuNe3TlmQ1feZCNG0102kargJRfxbTNtSQ9iSjZB2GbuZCFFrf' +
          '8aUcUZCYLIFqfWltRQVW6ZBjCIvKllKx97DCrZCIWqoBUpNmqFajKMywvZAV7zuJ' +
          'dzrvQG8EpGKtR2trjU7gmOgtRDsgzpbsfNNQFotqFH1f2P6IcY0E59HiFaWbsvZA' +
          'vnUAI29ZCgRTeVB4n41PA2cfEe'
      end
      item
        name = 'fields'
        Value = 'name,friends{birthday,picture}'
      end>
    Resource = 'me'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 80
    Top = 128
  end
  object RESTResponse1: TRESTResponse
    Left = 240
    Top = 128
  end
end
