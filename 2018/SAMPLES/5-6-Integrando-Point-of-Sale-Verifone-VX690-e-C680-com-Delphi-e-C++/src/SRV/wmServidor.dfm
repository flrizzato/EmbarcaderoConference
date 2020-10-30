object wbmServidor: TwbmServidor
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      Name = 'waiPOS'
      PathInfo = '/pos'
      OnAction = wbmServidorwaiPOSAction
    end
    item
      Name = 'waiVenda'
      PathInfo = '/venda'
      OnAction = wbmServidorwaiVendaAction
    end
    item
      Name = 'waiimprime'
      PathInfo = '/imprime'
      OnAction = wbmServidorwaiimprimeAction
    end>
  Height = 612
  Width = 216
end
