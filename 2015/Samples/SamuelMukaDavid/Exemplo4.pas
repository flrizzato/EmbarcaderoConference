unit Exemplo4;

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
    procedure Exportar(pArquivo: string); virtual; abstract;
  public
    property Codigo: integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Data: TDateTime read FData write FData;
    property Cargo: string read FCargo write FCargo;
  end;

implementation

end.
