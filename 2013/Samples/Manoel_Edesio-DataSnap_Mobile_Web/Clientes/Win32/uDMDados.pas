unit uDMDados;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, IPPeerClient,
  Data.DBXCommon, Data.DB, Data.SqlExpr, Datasnap.DBClient, Datasnap.DSConnect;

type
  TDMDados = class(TDataModule)
    ConexaoServerDC: TSQLConnection;
    DSProviderConn: TDSProviderConnection;
    cdsclientes: TClientDataSet;
    cdsProdutos: TClientDataSet;
    cdsPedidos: TClientDataSet;
    cdsItensPedido: TClientDataSet;
    cdsPedidosID: TIntegerField;
    cdsPedidosNUMERO: TStringField;
    cdsPedidosINCLUSAO: TDateField;
    cdsPedidosPREV_ENTREGA: TDateField;
    cdsPedidosENTREGA: TSQLTimeStampField;
    cdsPedidosSTATUS: TStringField;
    cdsPedidosVALOR_TOTAL: TFloatField;
    cdsPedidosCLIENTE: TIntegerField;
    cdsPedidossqlItensPedido: TDataSetField;
    dsClientes: TDataSource;
    dsProdutos: TDataSource;
    dsPedidos: TDataSource;
    dsItensPedido: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMDados: TDMDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
