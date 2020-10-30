unit dSQLDialectAbstraction;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Phys.PG, FireDAC.Phys.PGDef;

type
  TDMSQLDialectAbstraction = class(TDataModule)
    ConnectionFirebird: TFDConnection;
    ConnectionPostgreSQL: TFDConnection;
    QueryFirebird: TFDQuery;
    QueryPostgreSQL: TFDQuery;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    QueryPostgreSQLname: TWideMemoField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMSQLDialectAbstraction: TDMSQLDialectAbstraction;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
