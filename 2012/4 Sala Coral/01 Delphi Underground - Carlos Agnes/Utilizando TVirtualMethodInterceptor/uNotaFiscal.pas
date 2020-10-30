unit uNotaFiscal;

interface

uses
  uAspectos;

type
  TNotaFiscal = class
  strict private
    procedure SalvarNota;
    procedure SalvarItensNota;
  public
    constructor Create;
    destructor Destroy; override;

    [TControlePermissao]
    [TControleTransacional]
    procedure Salvar; virtual;
  end;

implementation

{ TNotaFiscal }

uses uUsuario, uConexao, FMX.Dialogs, System.SysUtils;

constructor TNotaFiscal.Create;
begin
  TVerificadorAspector.RegistrarObjeto(Self);
end;

destructor TNotaFiscal.Destroy;
begin
  TVerificadorAspector.DesregistrarObjeto(Self);

  inherited;
end;

procedure TNotaFiscal.Salvar;
begin
//  TUsuario.VerificarPermissao('Salvar');
//
//  TConexao.BeginTransaction;
//
//  try

    SalvarNota;
    SalvarItensNota;

//    TConexao.Commit;
//  except
//    TConexao.Rollback;
//    raise;
//  end;
end;

procedure TNotaFiscal.SalvarItensNota;
begin
  ShowMessage('TNotaFiscal.SalvarItensNota');
end;

procedure TNotaFiscal.SalvarNota;
begin
  ShowMessage('TNotaFiscal.SalvarNota');
end;

end.
