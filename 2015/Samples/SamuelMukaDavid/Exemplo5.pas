unit Exemplo5;

interface

uses
  System.Classes, System.SysUtils;

type
  TFichaUsuario = class;

  TExportaFichaUsuario = class
  private
    FFichaUsuario: TFichaUsuario;
  public
    constructor Create(pFichaUsuario: TFichaUsuario);
    procedure Exportar(pArquivo: string); virtual; abstract;
    property FichaUsuario: TFichaUsuario read FFichaUsuario write FFichaUsuario;
  end;

  TFichaUsuario = class
  private
    FCodigo: integer;
    FNome: String;
    FData: TDateTime;
    FCargo: string;
  public
    property Codigo: integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Data: TDateTime read FData write FData;
    property Cargo: string read FCargo write FCargo;
  end;


implementation

{ TExportaFichaUsuario }

constructor TExportaFichaUsuario.Create(pFichaUsuario: TFichaUsuario);
begin
  FFichaUsuario := pFichaUsuario;
end;

end.
