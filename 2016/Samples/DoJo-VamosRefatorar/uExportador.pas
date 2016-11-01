unit uExportador;

interface
uses uUsuario, System.Classes, Xml.XMLDoc, Xml.XMLIntf, System.SysUtils, System.JSON;

type
  TTipoExportador = (ExpXml, ExpJson, ExpTxt);

  TTipoExportadorHelper = record Helper for TTipoExportador
    function Extensao: string;
  end;

  TExportador = class(TObject)
  public
    procedure Exportar(pUsuario: TUsuario; pArquivo: string); virtual; abstract;
  end;

  TExportadorTXT = class(TExportador)
  public
    procedure Exportar(pUsuario: TUsuario; pArquivo: string); override;
  end;

  TExportadorXML = class(TExportador)
  public
    procedure Exportar(pUsuario: TUsuario; pArquivo: string); override;
  end;

  TExportadorJson = class(TExportador)
  public
    procedure Exportar(pUsuario: TUsuario; pArquivo: string); override;
  end;

  TExportadorFactory = class
  public
    class function CriarExportador(pTipoExportador: TTipoExportador): TExportador;
  end;


implementation

procedure TExportadorTXT.Exportar(pUsuario: TUsuario; pArquivo: string);
var
  lTexto : TStringList;
begin
  lTexto := TStringList.Create;
  try
    lTexto.Add('Código: '+pUsuario.Codigo.ToString);
    lTexto.Add('Nome: '+pUsuario.Nome);
    lTexto.Add('Data: '+FormatDateTime('DD/MM/YYYY',pUsuario.Data));
    lTexto.Add('Cargo: '+pUsuario.Cargo);
    lTexto.SaveToFile(pArquivo);
  finally
    lTexto.Free;
  end;
end;


{ TFichaUsuarioXML }

procedure TExportadorXML.Exportar(pUsuario: TUsuario; pArquivo: string);
var
  lXml: IXMLDocument;
  lNode: IXMLNode;
begin
  lXml := TXmlDocument.Create(nil);
  lXml.Active  := True;
  lXml.Version := '1.0';
  lXml.Encoding:= 'UTF-8';
  lXml.Options := lXml.Options + [doNodeAutoIndent];

  lNode := lXml.AddChild('Registro');
  lNode.AddChild('Codigo').NodeValue := pUsuario.Codigo;
  lNode.AddChild('Nome').NodeValue := pUsuario.Nome;
  lNode.AddChild('Data').NodeValue := pUsuario.Data;
  lNode.AddChild('Cargo').NodeValue := pUsuario.Cargo;

  lXml.SaveToFile(pArquivo);
end;

{ TFichaUsuarioJson }

procedure TExportadorJson.Exportar(pUsuario: TUsuario; pArquivo: string);
var
  lJsonObject: TJSONObject;
  lTexto: TStringList;
begin
  lJsonObject := TJSONObject.Create;
  try
    lJsonObject.AddPair(TJSONPair.Create('Codigo', pUsuario.Codigo.ToString));
    lJsonObject.AddPair(TJSONPair.Create('Nome',   pUsuario.Nome));
    lJsonObject.AddPair(TJSONPair.Create('Data',   DateTimeToStr(pUsuario.Data)));
    lJsonObject.AddPair(TJSONPair.Create('Cargo',  pUsuario.Cargo));

    lTexto := TStringList.Create;
    try
      lTexto.Text := lJsonObject.ToString;
      lTexto.SaveToFile(pArquivo);
    finally
      lTexto.Free;
    end;
  finally
    lJsonObject.Free;
  end;

end;

{ TTipoExportadorHelper }

function TTipoExportadorHelper.Extensao: string;
begin
  case Self of
    ExpXml:  Result := '.xml';
    ExpJson: Result := '.json';
    ExpTxt:  Result := '.txt';
  end;
end;

{ TExportadorFactory }

class function TExportadorFactory.CriarExportador(pTipoExportador: TTipoExportador): TExportador;
begin
  case pTipoExportador of
    ExpXml:  Result := TExportadorXML.Create;
    ExpJson: Result := TExportadorJson.Create;
    ExpTxt:  Result := TExportadorTXT.Create;
  end;
end;

end.
