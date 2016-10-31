unit Exemplo1;

interface

uses
  System.Classes, System.SysUtils;

type
  TFichaUsuario = class
  private
    FCodigo: integer;
    FNome: String;
    FData: TDateTime;
    FCargo: string;
  public
    procedure Exportar(pArquivo: string);
  published
    property Codigo: integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Data: TDateTime read FData write FData;
    property Cargo: string read FCargo write FCargo;
  end;

implementation

{ TFichaUsuario }

procedure TFichaUsuario.Exportar(pArquivo: string);
var
  lTexto : TStringList;
begin
  lTexto := TStringList.Create;
  try
    lTexto.Add('Código: '+FCodigo.ToString);
    lTexto.Add('Nome: '+FNome);
    lTexto.Add('Data: '+FormatDateTime('DD/MM/YYYY',FData));
    lTexto.Add('Cargo: '+FCargo);
    lTexto.SaveToFile(pArquivo);
  finally
    lTexto.Free;
  end;
end;

end.
