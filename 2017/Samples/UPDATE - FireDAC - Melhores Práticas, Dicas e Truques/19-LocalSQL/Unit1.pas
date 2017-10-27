unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.SQLiteVDataSet, FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait,
  FireDAC.Phys.IBBase, FireDAC.Phys.ODBCBase, FireDAC.Comp.UI,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  Vcl.ExtCtrls, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Vcl.Bind.Grid, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope;

type
  TForm1 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    BindingsList1: TBindingsList;
    BindSourceDBVendas: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindSourceDBClientes: TBindSourceDB;
    StringGridBindSourceDB2: TStringGrid;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    BindSourceDBJoin: TBindSourceDB;
    StringGridBindSourceDB3: TStringGrid;
    LinkGridToDataSourceBindSourceDB3: TLinkGridToDataSource;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Dm;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Dtm.GetClientes();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Dtm.GetVendas();
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Dtm.GetVendasInnerClientes();
end;

end.
