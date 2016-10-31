unit Exemplo4_1;

interface

uses
  System.Classes, System.SysUtils, Xml.XMLDoc, Xml.XMLIntf, System.Json,
  Data.DBXJSONReflect, Exemplo4;

type

  TFichaUsuarioTXT = class(TFichaUsuario)
    procedure Exportar(pArquivo: string); override;
  end;

implementation

{ TFichaUsuarioTxt }

procedure TFichaUsuarioTXT.Exportar(pArquivo: string);
var
  lTexto : TStringList;
begin
  lTexto := TStringList.Create;
  try
    lTexto.Add('Código: '+Codigo.ToString);
    lTexto.Add('Nome: '+ Nome);
    lTexto.Add('Data: '+FormatDateTime('DD/MM/YYYY',Data));
    lTexto.Add('Cargo: '+Cargo);

    lTexto.SaveToFile(pArquivo);
  finally
    lTexto.Free;
  end;
end;

end.
