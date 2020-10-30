object DM: TDM
  OldCreateOrder = False
  Height = 305
  Width = 377
  object CDSConsCliente: TClientDataSet
    Aggregates = <>
    FileName = 
      'C:\Users\Laercio\Dropbox\CONF2016\Web\IntraWebBootStrap\Win32\De' +
      'bug\ConsCliente.XML'
    Params = <>
    Left = 64
    Top = 48
    object CDSConsClienteNome: TStringField
      DisplayLabel = 'Cliente'
      FieldName = 'Nome'
      Required = True
      Size = 50
    end
    object CDSConsClienteData: TSQLTimeStampField
      FieldName = 'Data'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object CDSConsClienteLimite_Credito: TBCDField
      DisplayLabel = 'Cr'#233'dito'
      FieldName = 'Limite_Credito'
      Required = True
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object CDSConsClienteCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Size = 50
    end
    object CDSConsClienteESTADO: TStringField
      DisplayLabel = 'Uf'
      FieldName = 'ESTADO'
      Size = 2
    end
    object CDSConsClienteID_Cliente: TIntegerField
      FieldName = 'ID_Cliente'
      Required = True
      Visible = False
    end
    object CDSConsClienteStatus: TStringField
      FieldName = 'Status'
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object CDSConsClienteTipo: TStringField
      FieldName = 'Tipo'
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object CDSConsClienteLATITUDE: TStringField
      FieldName = 'LATITUDE'
      Visible = False
      Size = 50
    end
    object CDSConsClienteLONGITUDE: TStringField
      FieldName = 'LONGITUDE'
      Visible = False
      Size = 50
    end
    object CDSConsClienteBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Visible = False
      Size = 50
    end
    object CDSConsClientelogradouro: TStringField
      FieldName = 'logradouro'
      Visible = False
      Size = 100
    end
  end
end
