unit ExemploSemOCP;

interface

type
  TCliente = class
  public
    procedure SelecionarPrimeirosClientes(const ABancoDados: string);
  end;

implementation

uses
  FireDAC.Comp.Client;

{ TCliente }

procedure TCliente.SelecionarPrimeirosClientes(const ABancoDados: string);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    if ABancoDados = 'Oracle' then
      Query.Open('SELECT * FROM Clientes WHERE rownum <= 100')
    else if ABancoDados = 'Firebird' then
      Query.Open('SELECT FIRST 100 * FROM CLIENTES')
    else if ABancoDados = 'SQL Server' then
      Query.Open('SELECT TOP 100 * FROM CLIENTES')
    else if ABancoDados = 'PostgreSQL' then
      Query.Open('SELECT * FROM CLIENTES LIMIT 100');

    { ... }
  finally
    Query.Free;
  end;
end;

end.
