unit fSQLDialectAbstraction;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids;

type
  TFrmSQLDialectAbstraction = class(TForm)
    PageControl: TPageControl;
    tabFirebird: TTabSheet;
    tabPostgreSQL: TTabSheet;
    tabFireDAC: TTabSheet;
    memSQLFirebird: TMemo;
    memSQLPostgreSQL: TMemo;
    memSQLFireDAC: TMemo;
    btnExecuteFirebird: TButton;
    btnExecutePostgreSQL: TButton;
    btnExecuteFireDAC: TButton;
    griFirebird: TDBGrid;
    DSFirebird: TDataSource;
    griPostgreSQL: TDBGrid;
    DSPostgreSQL: TDataSource;
    griFireDACPostgreSQL: TDBGrid;
    griFireDACFirebird: TDBGrid;
    procedure btnExecuteFirebirdClick(Sender: TObject);
    procedure btnExecutePostgreSQLClick(Sender: TObject);
    procedure btnExecuteFireDACClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSQLDialectAbstraction: TFrmSQLDialectAbstraction;

implementation

{$R *.dfm}

uses dSQLDialectAbstraction;

procedure TFrmSQLDialectAbstraction.btnExecuteFirebirdClick(Sender: TObject);
begin
  with DMSQLDialectAbstraction do
  begin
    QueryFirebird.Close;
    QueryFirebird.SQL.Clear;
    QueryFirebird.SQL := memSQLFirebird.Lines;
    QueryFirebird.Open;
  end;
end;

procedure TFrmSQLDialectAbstraction.btnExecutePostgreSQLClick(Sender: TObject);
begin
  with DMSQLDialectAbstraction do
  begin
    QueryPostgreSQL.Close;
    QueryPostgreSQL.SQL.Clear;
    QueryPostgreSQL.SQL := memSQLPostgreSQL.Lines;
    QueryPostgreSQL.Open;
  end;

end;

procedure TFrmSQLDialectAbstraction.btnExecuteFireDACClick(Sender: TObject);
begin
  with DMSQLDialectAbstraction do
  begin
    QueryFirebird.Close;
    QueryFirebird.SQL.Clear;
    QueryFirebird.SQL := memSQLFireDAC.Lines;
    QueryFirebird.Open;

    QueryPostgreSQL.Close;
    QueryPostgreSQL.SQL.Clear;
    QueryPostgreSQL.SQL := memSQLFireDAC.Lines;
    QueryPostgreSQL.Open;
  end;
end;

procedure TFrmSQLDialectAbstraction.PageControlChange(Sender: TObject);
begin
  if PageControl.ActivePage = tabFireDAC then
  begin
    DMSQLDialectAbstraction.QueryFirebird.Close;
    DMSQLDialectAbstraction.QueryPostgreSQL.Close;
  end;
end;

end.
