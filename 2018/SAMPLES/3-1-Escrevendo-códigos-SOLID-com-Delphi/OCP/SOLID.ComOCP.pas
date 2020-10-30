unit SOLID.ComOCP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

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

  TFormComOCP = class(TForm)
  private
    function CamadaDBFactory(SGBD: TSGBD): TCamadaBD;
    procedure SelecionarPrimeirosClientes;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormComOCP: TFormComOCP;

implementation

{$R *.dfm}

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

{ TForm1 }

function TFormComOCP.CamadaDBFactory(SGBD: TSGBD): TCamadaBD;
begin
  case SGBD of
    dbFirebird:   result := TFirebird.Create;
    dbOracle:     result := TOracle.Create;
    dbSQLServer:  result := TSQLServer.Create;
    dbPostgreSQL: result := TPostgreSQL.Create;
  end;
end;

procedure TFormComOCP.SelecionarPrimeirosClientes;
var
  CamadaBD: TCamadaBD;
begin
  CamadaBD := CamadaDBFactory(dbOracle);
  CamadaBD.SelecionarPrimeirosClientes;
end;

end.
