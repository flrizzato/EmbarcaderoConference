unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Vcl.StdCtrls, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  Vcl.Grids, Vcl.DBGrids;

type
  TForm3 = class(TForm)
    CursofiredacConnection: TFDConnection;
    FDQuery1: TFDQuery;
    FDQuery2: TFDQuery;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    FDQuery1IdCliente: TFDAutoIncField;
    FDQuery1Nome: TStringField;
    FDQuery1Logradouro: TStringField;
    FDQuery1Numero: TStringField;
    FDQuery1IdBairro: TIntegerField;
    FDQuery2IdCliente: TIntegerField;
    FDQuery2Numero: TStringField;
    FDSchemaAdapter1: TFDSchemaAdapter;
    Button1: TButton;
    Cancel: TButton;
    procedure Button1Click(Sender: TObject);
    procedure CancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
  FDSchemaAdapter1.ApplyUpdates(0);
end;

procedure TForm3.CancelClick(Sender: TObject);
begin
  FDSchemaAdapter1.CancelUpdates();
end;

end.
