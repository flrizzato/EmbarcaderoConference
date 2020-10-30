unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtCtrls;

type
  TForm4 = class(TForm)
    ExtremedelphiConnection: TFDConnection;
    VendaprodutosTable: TFDQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    VendaprodutosTableIdVenda: TIntegerField;
    VendaprodutosTableIdProduto: TIntegerField;
    VendaprodutosTableQtd: TBCDField;
    VendaprodutosTableValor: TBCDField;
    Panel1: TPanel;
    BtnApply: TButton;
    Panel2: TPanel;
    BtnRefresh: TButton;
    Panel3: TPanel;
    Button1: TButton;
    procedure BtnRefreshClick(Sender: TObject);
    procedure BtnApplyClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation
uses DBCommon;

{$R *.dfm}

procedure TForm4.BtnApplyClick(Sender: TObject);
begin
  if VendaprodutosTable.ApplyUpdates(-1) > 0 then
  begin
    FDMemTable1.Close();
    FDMemTable1.Data := VendaprodutosTable.Data;
    FDMemTable1.FilterChanges := [rtModified, rtInserted, rtDeleted, rtHasErrors];
  end;
end;

procedure TForm4.BtnRefreshClick(Sender: TObject);
begin
  VendaprodutosTable.Close();
  VendaprodutosTable.Open();
end;

procedure TForm4.Button1Click(Sender: TObject);
var
  Erro: EFDException;
begin
  if (FDMemTable1.Active) and (not FDMemTable1.IsEmpty) then
  begin
    Erro := FDMemTable1.RowError;
    if Erro <> nil then
    begin
      ShowMessage(Erro.Message);
    end;
  end;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  BtnRefresh.Click;
end;

end.
