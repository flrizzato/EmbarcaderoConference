unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.IB;

type
  TForm9 = class(TForm)
    FDConnection1: TFDConnection;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Button1: TButton;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    FDQuery1ID: TIntegerField;
    FDQuery1DATA: TDateField;
    FDQuery1IDCLIENTE: TIntegerField;
    FDQuery2: TFDQuery;
    DataSource2: TDataSource;
    FDQuery2IDVENDA: TIntegerField;
    FDQuery2IDPRODUTO: TIntegerField;
    FDQuery2QUANTIDADE: TBCDField;
    FDQuery2VALOR: TBCDField;
    FDSchemaAdapter1: TFDSchemaAdapter;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure LimparCache(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.dfm}

procedure TForm9.Button1Click(Sender: TObject);
begin
//  FDConnection1.ApplyUpdates([FDQueryMestre,FDQueryDetalhe]);
  FDSchemaAdapter1.ApplyUpdates(0);
end;

procedure TForm9.FormCreate(Sender: TObject);
begin
  FDQuery1.Open();
  FDQuery2.Open();
  FDSchemaAdapter1.AfterApplyUpdate := LimparCache;
end;

procedure TForm9.LimparCache(Sender: TObject);
begin
  FDQuery1.CommitUpdates();
  FDQuery2.CommitUpdates();
end;

end.
