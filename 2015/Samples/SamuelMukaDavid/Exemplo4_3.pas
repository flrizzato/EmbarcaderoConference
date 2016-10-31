unit Exemplo4_3;

interface

uses
  System.Classes, System.SysUtils, Xml.XMLDoc, Xml.XMLIntf, System.Json,
  Data.DBXJSONReflect, Exemplo4;

type
  TFichaUsuarioJson = class(TFichaUsuario)
    procedure Exportar(pArquivo: string); override;
  end;

implementation

{ TFichaUsuarioJson }

procedure TFichaUsuarioJson.Exportar(pArquivo: string);
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
