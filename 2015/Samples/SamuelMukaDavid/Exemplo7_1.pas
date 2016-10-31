unit Exemplo7_1;

interface

uses
  System.Classes, System.SysUtils, Xml.XMLDoc, Xml.XMLIntf, System.Json,
  Data.DBXJSONReflect, Exemplo7;

type

  TExportadorFichaUsuarioTxt = class(TInterfacedObject, IExportadorFichaUsuario)
  public
    procedure Exportar(pFichaUsuario: IFichaUsuario; pArquivo: string);
  end;

  TExportadorFichaUsuarioXML = class(TInterfacedObject, IExportadorFichaUsuario)
  public
    procedure Exportar(pFichaUsuario: IFichaUsuario; pArquivo: string);
  end;

  TExportadorFichaUsuarioJson = class(TInterfacedObject, IExportadorFichaUsuario)
  public
    procedure Exportar(pFichaUsuario: IFichaUsuario; pArquivo: string);
  end;


implementation

{ TExportaFichaUsuarioTxt }

procedure TExportadorFichaUsuarioTxt.Exportar(pFichaUsuario: IFichaUsuario; pArquivo: string);
var
  lTexto : TStringList;
begin
  lTexto := TStringList.Create;
  try
    lTexto.Add('Código: '+pFichaUsuario.GetCodigo.ToString);
    lTexto.Add('Nome: '  +pFichaUsuario.GetNome);
    lTexto.Add('Data: '  +FormatDateTime('DD/MM/YYYY',pFichaUsuario.GetData));
    lTexto.Add('Cargo: ' +pFichaUsuario.GetCargo);
    lTexto.SaveToFile(pArquivo);
  finally
    lTexto.Free;
  end;
end;

{ TExportaFichaUsuarioXML }

procedure TExportadorFichaUsuarioXML.Exportar(pFichaUsuario: IFichaUsuario; pArquivo: string);
var
  lXml: IXMLDocument;
  lNode: IXMLNode;
begin
  lXml := TXmlDocument.Create(nil);
  lXml.Active  := True;
  lXml.Version := '1.0';
  lXml.Encoding:= 'UTF-8';

  lNode := lXml.AddChild('Ficha');
  lNode.AddChild('Codigo').NodeValue := pFichaUsuario.GetCodigo;
  lNode.AddChild('Nome').NodeValue   := pFichaUsuario.GetNome;
  lNode.AddChild('Data').NodeValue   := pFichaUsuario.GetData;
  lNode.AddChild('Cargo').NodeValue  := pFichaUsuario.GetCargo;

  lXml.SaveToFile(pArquivo);
end;

{ TExportaFichaUsuarioJson }

procedure TExportadorFichaUsuarioJson.Exportar(pFichaUsuario: IFichaUsuario; pArquivo: string);
var
  lJson : TJsonValue;
  lJSONMarshal: TJSONMarshal;
  lTexto : TStringList;
begin
  lJSONMarshal := TJSONMarshal.Create(TJSONConverter.Create);
  try
    lJson := lJSONMarshal.Marshal(TObject(pFichaUsuario));

    lTexto := TStringList.Create;
    try
      lTexto.Text := lJson.ToString;
      lTexto.SaveToFile(pArquivo);
    finally
      lTexto.Free;
    end;


  finally
    lJSONMarshal.Free;
    lJson.Free;
  end;
end;


end.
