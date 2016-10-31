unit uConexao;

interface

type
  TConexao = class
  public
    class procedure Conectar;
    class function ExecutarSQL(const pInstrucao: string): Integer;
  end;

implementation

uses
  System.SysUtils;

{ TConexao }

class procedure TConexao.Conectar;
begin
  // Comandos para conectar com o SGBD desejado;
  raise Exception.Create('Não foi possível estabelecer conexão com o banco de dados.');
end;

class function TConexao.ExecutarSQL(const pInstrucao: string): Integer;
begin
  try
    Conectar;

    // Comandos para a execução da instrução
    // Result := ComponenteDeQuery.Execute;

    Result := 1;
  except
    raise Exception.Create('Não foi possível executar a instrução SQL.');
  end;
end;

end.
