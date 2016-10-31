unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.SqlExpr,
  Vcl.ExtCtrls, Vcl.DBCtrls, Datasnap.DBClient, Datasnap.DSConnect, Vcl.Grids,
  Vcl.DBGrids, Data.DBXDataSnap, IPPeerClient, Data.DBXCommon, Data.FMTBcd,
  Data.DbxCompressionFilter;

type
  Tdbgr = class(TForm)
    bConnect: TButton;
    sqlCon: TSQLConnection;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Memo1: TMemo;
    Label3: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    lblSalary: TLabel;
    bGetCustomers: TButton;
    bSaveCustomers: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    DSProviderConnection1: TDSProviderConnection;
    cds: TClientDataSet;
    DBNavigator1: TDBNavigator;
    smGetSalary: TSqlServerMethod;
    procedure bConnectClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure bGetCustomersClick(Sender: TObject);
    procedure bSaveCustomersClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dbgr: Tdbgr;

implementation

{$R *.dfm}

procedure Tdbgr.bConnectClick(Sender: TObject);
begin
  if bConnect.Caption = 'Connect' then
  begin
    sqlCon.Close;
    sqlCon.Params.Values['DSAuthenticationUser'] := Edit1.Text;
    sqlCon.Params.Values['DSAuthenticationPassword'] := Edit2.Text;
    sqlCon.Open;
    bConnect.Caption := 'Disconnect';
  end
  else
  begin
    sqlCon.Close;
    bConnect.Caption := 'Connect';
  end;
end;

procedure Tdbgr.bGetCustomersClick(Sender: TObject);
begin
  cds.Close;
  cds.Open;
end;

procedure Tdbgr.bSaveCustomersClick(Sender: TObject);
begin
  cds.ApplyUpdates(0);
end;

procedure Tdbgr.Button1Click(Sender: TObject);
begin
  smGetSalary.Close;
  smGetSalary.Params[0].AsInteger := StrToIntDef(Edit3.Text, 0);
  smGetSalary.ExecuteMethod;
  lblSalary.Caption := smGetSalary.Params[1].AsString;
  smGetSalary.Close;
end;

end.
