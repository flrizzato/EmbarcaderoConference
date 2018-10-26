unit uCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Phys.IBBase,
  FireDAC.Comp.UI, FireDAC.DApt;

type
  TForm1 = class(TForm)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDConnection1: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    dtsCliente: TDataSource;
    FDCliente: TFDQuery;
    FDClienteID: TIntegerField;
    FDClienteNOME: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FDClienteAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FDClienteAfterPost(DataSet: TDataSet);
begin
  FDCliente.ApplyUpdates(0);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Instância da class de conexão via FireDAC
  FDCliente.Open;
end;

end.
