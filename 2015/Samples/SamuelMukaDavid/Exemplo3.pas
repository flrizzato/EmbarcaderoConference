unit Exemplo3;

interface

uses
  System.Classes, System.SysUtils, Xml.XMLDoc, Xml.XMLIntf, System.Json,
  Data.DBXJSONReflect;

type
  TTipoFicha = (tfTexto, tfXml, tfJson);

  TFichaUsuario = class
  private
    FCodigo: integer;
    FNome: String;
    FData: TDateTime;
    FCargo: string;
    procedure ExportarXml(pArquivo: string);
    procedure ExportarTexto(pArquivo: string);
    procedure ExportarJson(pArquivo: string);
  public
    procedure Exportar(pArquivo: string; pTipoFicha: TTipoFicha);
  published
    property Codigo: integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Data: TDateTime read FData write FData;
    property Cargo: string read FCargo write FCargo;
  end;

implementation

{ TFichaUsuario }

procedure TFichaUsuario.Exportar(pArquivo: string; pTipoFicha: TTipoFicha);
begin
  case pTipoFicha of
    tfTexto: ExportarTexto(pArquivo);
    tfXml:   ExportarXml(pArquivo);
    tfJson:  ExportarJson(pArquivo);
  end;
end;

procedure TFichaUsuario.ExportarJson(pArquivo: string);
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


procedure TFichaUsuario.ExportarTexto(pArquivo: string);
var
  lTexto: TStringList;
begin
  lTexto := TStringList.Create;
  try
    lTexto.Add('Código: ' + FCodigo.ToString);
    lTexto.Add('Nome: ' + FNome);
    lTexto.Add('Data: ' + FormatDateTime('DD/MM/YYYY', FData));
    lTexto.Add('Cargo: ' + FCargo);
    lTexto.SaveToFile(pArquivo);
  finally
    lTexto.Free;
  end;
end;

procedure TFichaUsuario.ExportarXml(pArquivo: string);
var
  lXml: IXMLDocument;
  lNode: IXMLNode;
begin
  lXml := TXmlDocument.Create(nil);
  lXml.Active := True;
  lXml.Version := '1.0';
  lXml.Encoding := 'UTF-8';
  lNode := lXml.AddChild('Ficha');
  lNode.AddChild('Codigo').NodeValue := FCodigo;
  lNode.AddChild('Nome').NodeValue := FNome;
  lNode.AddChild('Data').NodeValue := FData;
  lNode.AddChild('Cargo').NodeValue := FCargo;
  lXml.SaveToFile(pArquivo);
end;

end.
