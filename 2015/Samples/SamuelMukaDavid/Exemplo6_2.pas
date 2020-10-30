unit Exemplo6_2;

interface

uses
  System.Classes, System.SysUtils, Xml.XMLDoc, Xml.XMLIntf, System.Json,
  Data.DBXJSONReflect, Exemplo6;

type

  TExportaFichaUsuarioTxt = class(TExportaFichaUsuario)
  public
    procedure Exportar(pFichaUsuario: TFichaUsuario; pArquivo: string); override;
  end;

  TExportaFichaUsuarioXML = class(TExportaFichaUsuario)
  public
    procedure Exportar(pFichaUsuario: TFichaUsuario; pArquivo: string); override;
  end;

  TExportaFichaUsuarioJson = class(TExportaFichaUsuario)
  public
    procedure Exportar(pFichaUsuario: TFichaUsuario; pArquivo: string); override;
  end;

implementation

{ TExportaFichaUsuarioTxt }

procedure TExportaFichaUsuarioTxt.Exportar(pFichaUsuario: TFichaUsuario; pArquivo: string);
var
  lTexto : TStringList;
begin
  lTexto := TStringList.Create;
  try
    lTexto.Add('Código: '+pFichaUsuario.Codigo.ToString);
    lTexto.Add('Nome: '  +pFichaUsuario.Nome);
    lTexto.Add('Data: '  +FormatDateTime('DD/MM/YYYY',pFichaUsuario.Data));
    lTexto.Add('Cargo: ' +pFichaUsuario.Cargo);
    lTexto.SaveToFile(pArquivo);
  finally
    lTexto.Free;
  end;
end;

{ TExportaFichaUsuarioXML }

procedure TExportaFichaUsuarioXML.Exportar(pFichaUsuario: TFichaUsuario; pArquivo: string);
var
  lXml: IXMLDocument;
  lNode: IXMLNode;
begin
  lXml := TXmlDocument.Create(nil);
  lXml.Active  := True;
  lXml.Version := '1.0';
  lXml.Encoding:= 'UTF-8';

  lNode := lXml.AddChild('Ficha');
  lNode.AddChild('Codigo').NodeValue := pFichaUsuario.Codigo;
  lNode.AddChild('Nome').NodeValue   := pFichaUsuario.Nome;
  lNode.AddChild('Data').NodeValue   := pFichaUsuario.Data;
  lNode.AddChild('Cargo').NodeValue  := pFichaUsuario.Cargo;

  lXml.SaveToFile(pArquivo);
end;

{ TExportaFichaUsuarioJson }

procedure TExportaFichaUsuarioJson.Exportar(pFichaUsuario: TFichaUsuario; pArquivo: string);
var
  lJson : TJsonValue;
  lJSONMarshal: TJSONMarshal;
  lTexto : TStringList;
begin
  lJSONMarshal := TJSONMarshal.Create(TJSONConverter.Create);
  try
    lJson := lJSONMarshal.Marshal(pFichaUsuario);

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

