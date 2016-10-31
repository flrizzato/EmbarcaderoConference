unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  Data.DBXMSSQL, Data.FMTBcd, Datasnap.Provider, Data.DB, Data.SqlExpr;

type
  TServerDelphiConference = class(TDSServerModule)
    sqlConexao: TSQLConnection;
    sqlClientes: TSQLDataSet;
    dspClientes: TDataSetProvider;
    sqlProdutos: TSQLDataSet;
    dspProdutos: TDataSetProvider;
    sqlPedidos: TSQLDataSet;
    dspPedidos: TDataSetProvider;
    sqlItensPedido: TSQLDataSet;
    dsRelPedItens: TDataSource;
    sqlDinamico: TSQLDataSet;
    dspDinamico: TDataSetProvider;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
  end;

implementation

{$R *.dfm}

uses System.StrUtils;

function TServerDelphiConference.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerDelphiConference.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

