unit Exemplo4_2;

interface

uses
  System.Classes, System.SysUtils, Xml.XMLDoc, Xml.XMLIntf, System.Json,
  Data.DBXJSONReflect, Exemplo4;

type

  TFichaUsuarioXML = class(TFichaUsuario)
    procedure Exportar(pArquivo: string); override;
  end;

implementation

{ TFichaUsuarioXML }

procedure TFichaUsuarioXML.Exportar(pArquivo: string);
var
  lXml: IXMLDocument;
  lNode: IXMLNode;
begin
  lXml := TXmlDocument.Create(nil);
  lXml.Active  := True;
  lXml.Version := '1.0';
  lXml.Encoding:= 'UTF-8';

  lNode := lXml.AddChild('Ficha');
  lNode.AddChild('Codigo').NodeValue := Codigo;
  lNode.AddChild('Nome').NodeValue := Nome;
  lNode.AddChild('Data').NodeValue := Data;
  lNode.AddChild('Cargo').NodeValue := Cargo;

  lXml.SaveToFile(pArquivo);
end;


end.
