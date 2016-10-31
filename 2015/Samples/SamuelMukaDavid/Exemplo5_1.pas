unit Exemplo5_1;

interface

uses
  System.Classes, System.SysUtils, Xml.XMLDoc, Xml.XMLIntf, System.Json,
  Data.DBXJSONReflect, Exemplo5;

type

  TExportaFichaUsuarioTxt = class(TExportaFichaUsuario)
  public
    procedure Exportar(pArquivo: string); override;
  end;

  TExportaFichaUsuarioXML = class(TExportaFichaUsuario)
  public
    procedure Exportar(pArquivo: string); override;
  end;

  TExportaFichaUsuarioJson = class(TExportaFichaUsuario)
  public
    procedure Exportar(pArquivo: string); override;
  end;

implementation

{ TExportaFichaUsuarioTxt }

procedure TExportaFichaUsuarioTxt.Exportar(pArquivo: string);
var
  lTexto : TStringList;
begin
  lTexto := TStringList.Create;
  try
    lTexto.Add('Código: '+FichaUsuario.Codigo.ToString);
    lTexto.Add('Nome: '  +FichaUsuario.Nome);
    lTexto.Add('Data: '  +FormatDateTime('DD/MM/YYYY',FichaUsuario.Data));
    lTexto.Add('Cargo: ' +FichaUsuario.Cargo);
    lTexto.SaveToFile(pArquivo);
  finally
    lTexto.Free;
  end;
end;


{ TExportaFichaUsuarioXML }

procedure TExportaFichaUsuarioXML.Exportar(pArquivo: string);
var
  lXml: IXMLDocument;
  lNode: IXMLNode;
begin
  lXml := TXmlDocument.Create(nil);
  lXml.Active  := True;
  lXml.Version := '1.0';
  lXml.Encoding:= 'UTF-8';

  lNode := lXml.AddChild('Ficha');
  lNode.AddChild('Codigo').NodeValue := FichaUsuario.Codigo;
  lNode.AddChild('Nome').NodeValue   := FichaUsuario.Nome;
  lNode.AddChild('Data').NodeValue   := FichaUsuario.Data;
  lNode.AddChild('Cargo').NodeValue  := FichaUsuario.Cargo;

  lXml.SaveToFile(pArquivo);
end;


{ TExportaFichaUsuarioJson }

procedure TExportaFichaUsuarioJson.Exportar(pArquivo: string);
var
  lJson : TJsonValue;
  lJSONMarshal: TJSONMarshal;
  lTexto : TStringList;
begin
  lJSONMarshal := TJSONMarshal.Create(TJSONConverter.Create);
  try
    lJson := lJSONMarshal.Marshal(Self);

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
