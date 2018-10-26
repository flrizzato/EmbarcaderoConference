unit ExemploSemSRP;

interface

type
  TCalculoEstatisticas = class
  private
    procedure GerarEstatisticas;
    procedure EnviarRelatorioGerencia;
  public
    procedure Executar;
  end;

  TCliente = class
  public
    procedure Exemplo;
  end;

implementation

{ TCalculoEstatisticas }

procedure TCalculoEstatisticas.Executar;
begin
  GerarEstatisticas;
  EnviarRelatorioGerencia;
end;

procedure TCalculoEstatisticas.EnviarRelatorioGerencia;
begin
  //
end;

procedure TCalculoEstatisticas.GerarEstatisticas;
begin
  //
end;

{ TCliente }

procedure TCliente.Exemplo;
var
  CalculoEstatisticas: TCalculoEstatisticas;
begin
  CalculoEstatisticas := TCalculoEstatisticas.Create;
  try
    CalculoEstatisticas.GerarEstatisticas;
  finally
    CalculoEstatisticas.Free;
  end;
end;

end.
