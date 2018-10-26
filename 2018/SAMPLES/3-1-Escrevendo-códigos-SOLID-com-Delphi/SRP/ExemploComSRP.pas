unit ExemploComSRP;

interface

type
  TCalculoEstatisticas = class
  public
    procedure GerarEstatisticas;
  end;

  TEnvioRelatorio = class
  public
    procedure EnviarRelatorioGerencia;
  end;

  TCliente = class
  public
    procedure Exemplo;
  end;

implementation

{ TEnvioRelatorio }

procedure TEnvioRelatorio.EnviarRelatorioGerencia;
begin
  //
end;

{ TCalculoEstatisticas }

procedure TCalculoEstatisticas.GerarEstatisticas;
begin
  //
end;

{ TCliente }

procedure TCliente.Exemplo;
var
  CalculoEstatisticas: TCalculoEstatisticas;
  EnvioRelatorio: TEnvioRelatorio;
begin
  CalculoEstatisticas := TCalculoEstatisticas.Create;
  EnvioRelatorio := TEnvioRelatorio.Create;
  try
    CalculoEstatisticas.GerarEstatisticas;
    EnvioRelatorio.EnviarRelatorioGerencia;
  finally
    EnvioRelatorio.Free;
    CalculoEstatisticas.Free;
  end;
end;

end.
