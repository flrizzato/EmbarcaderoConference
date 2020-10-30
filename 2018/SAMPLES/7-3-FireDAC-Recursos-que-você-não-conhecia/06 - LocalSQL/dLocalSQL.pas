unit dLocalSQL;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Phys.SQLiteVDataSet, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs;

type
  TDMLocalSQL = class(TDataModule)
    ConnectionFirebird: TFDConnection;
    ConnectionPostgreSQL: TFDConnection;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    Clientes: TFDQuery;
    Produtos: TFDQuery;
    ClientesID: TIntegerField;
    ClientesNOME: TStringField;
    ProdutosID: TIntegerField;
    ProdutosNOME: TStringField;
    ProdutosVALOR: TBCDField;
    Vendas: TFDQuery;
    LocalSQL: TFDLocalSQL;
    VendasFull: TFDQuery;
    ConnectionLocal: TFDConnection;
    VendasFullvenda: TIntegerField;
    VendasFullid_cliente: TIntegerField;
    VendasFullcliente: TStringField;
    VendasFullid_produto: TIntegerField;
    VendasFullproduto: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMLocalSQL: TDMLocalSQL;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
