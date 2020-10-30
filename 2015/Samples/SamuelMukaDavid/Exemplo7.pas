unit Exemplo7;

interface

type
  IFichaUsuario = interface
  ['{5117EFB7-15F6-408C-9554-4D530C3AA4A3}']
    function GetCodigo: integer;
    function GetNome: String;
    function GetData: TDateTime;
    function GetCargo: string;
  end;

  IExportadorFichaUsuario = interface
  ['{74C26CFE-1CD9-45B4-96D2-42B70511F529}']
    procedure Exportar(pFichaUsuario: IFichaUsuario; pArquivo: string);
  end;

  TGerenciadorFicha = class
  protected
    FFichaUsuario: IFichaUsuario;
  public
    constructor Create(pFichaUsuario: IFichaUsuario);
    procedure Exportar(pExportaFichaUsuario: IExportadorFichaUsuario; pArquivo: string);
  end;


implementation

{ TGerenciadorFicha }

constructor TGerenciadorFicha.Create(pFichaUsuario: IFichaUsuario);
begin
  FFichaUsuario := pFichaUsuario;
end;

procedure TGerenciadorFicha.Exportar(pExportaFichaUsuario: IExportadorFichaUsuario;
  pArquivo: string);
begin
  pExportaFichaUsuario.Exportar(FFichaUsuario,pArquivo);
end;

end.
