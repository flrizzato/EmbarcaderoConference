unit ExemploComOCP;

interface

type
  TCamadaBD = class
  protected
    function GerarSQLPrimeirosClientes: string; virtual; abstract;
  public
    procedure SelecionarPrimeirosClientes;
  end;

  TFirebird = class(TCamadaBD)
  protected
    function GerarSQLPrimeirosClientes: string; override;
  end;

  TOracle = class(TCamadaBD)
  protected
    function GerarSQLPrimeirosClientes: string; override;
  end;

  TSQLServer = class(TCamadaBD)
  protected
    function GerarSQLPrimeirosClientes: string; override;
  end;

  TPostgreSQL = class(TCamadaBD)
  protected
    function GerarSQLPrimeirosClientes: string; override;
  end;

  TSGBD = (dbFirebird, dbOracle, dbSQLServer, dbPostgreSQL);

  TCliente = class
  private
    function CamadaDBFactory(SGBD: TSGBD): TCamadaBD;
  public
    procedure SelecionarPrimeirosClientes;
  end;

implementation

uses
  FireDAC.Comp.Client;

{ TCamadaBD }

procedure TCamadaBD.SelecionarPrimeirosClientes;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Open(GerarSQLPrimeirosClientes);
    { ... }
  finally
    Query.Free;
  end;
end;

{ TFirebird }

function TFirebird.GerarSQLPrimeirosClientes: string;
begin
  result := 'SELECT FIRST 100 * FROM CLIENTES';
end;

{ TOracle }

function TOracle.GerarSQLPrimeirosClientes: string;
begin
  result := 'SELECT * FROM Clientes WHERE rownum <= 100';
end;

{ TSQLServer }

function TSQLServer.GerarSQLPrimeirosClientes: string;
begin
  result := 'SELECT TOP 100 * FROM CLIENTES';
end;

{ TPostgreSQL }

function TPostgreSQL.GerarSQLPrimeirosClientes: string;
begin
  result := 'SELECT * FROM CLIENTES LIMIT 100';
end;

{ TCliente }

function TCliente.CamadaDBFactory(SGBD: TSGBD): TCamadaBD;
begin
  case SGBD of
    dbFirebird:   result := TFirebird.Create;
    dbOracle:     result := TOracle.Create;
    dbSQLServer:  result := TSQLServer.Create;
    dbPostgreSQL: result := TPostgreSQL.Create;
  else
    result := nil;
  end
end;

procedure TCliente.SelecionarPrimeirosClientes;
var
  CamadaBD: TCamadaBD;
begin
  CamadaBD := CamadaDBFactory(dbOracle);
  CamadaBD.SelecionarPrimeirosClientes;
end;

end.
