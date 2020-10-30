unit Exemplo2;

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
var
  lTexto : TStringList;
  lXml: IXMLDocument;
  lNode: IXMLNode;
  lJson : TJsonValue;
  lJSONMarshal: TJSONMarshal;
begin
  if pTipoFicha = tfTexto then
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
  end else if pTipoFicha = tfXml then
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
  end else if pTipoFicha = tfJson then
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
end;



end.
