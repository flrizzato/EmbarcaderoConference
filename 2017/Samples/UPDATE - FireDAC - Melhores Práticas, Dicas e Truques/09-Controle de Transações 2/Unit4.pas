unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, Vcl.StdCtrls, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TForm4 = class(TForm)
    Conexao: TFDConnection;
    FDQuery1: TFDQuery;
    FDQuery2: TFDQuery;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    FDSchemaAdapter1: TFDSchemaAdapter;
    FDQuery1IdCliente: TFDAutoIncField;
    FDQuery1Nome: TStringField;
    FDQuery1Logradouro: TStringField;
    FDQuery1Numero: TStringField;
    FDQuery1IdBairro: TIntegerField;
    FDQuery2IdCliente: TIntegerField;
    FDQuery2Numero: TStringField;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FDSchemaAdapter1ReconcileRow(ASender: TObject; ARow: TFDDatSRow;
      var Action: TFDDAptReconcileAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
  Conexao.StartTransaction();
  if FDSchemaAdapter1.ApplyUpdates(0) = 0 then
  begin
    Conexao.Commit();
  end
  else
  begin
    Conexao.Rollback();
  end;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  FDSchemaAdapter1.Close();
  FDSchemaAdapter1.Open();
end;

procedure TForm4.FDSchemaAdapter1ReconcileRow(ASender: TObject; ARow: TFDDatSRow;
  var Action: TFDDAptReconcileAction);
begin
  ShowMessage(EFDDBEngineException(ARow.RowError).Message);
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  FDSchemaAdapter1.Open();
end;

end.
