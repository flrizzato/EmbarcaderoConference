unit uLookup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Phys.IBBase,
  FireDAC.Comp.UI,

  /// dataset
  ormbr.container.dataset.interfaces,
  ormbr.container.fdmemtable,
  /// connection
  ormbr.factory.interfaces,
  ormbr.factory.firedac,
  ormbr.types.database,
  /// driver do banco
  ormbr.dml.generator.firebird,
  /// orm model
  ormbr.model.lookup;


type
  TForm1 = class(TForm)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDConnection1: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    FDLookup: TFDMemTable;
    dtsCliente: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FDLookupAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    oConn: IDBConnection;
    oLookup: IContainerDataSet<TTab_Lookup>;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FDLookupAfterPost(DataSet: TDataSet);
begin
  oLookup.ApplyUpdates(0);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Instância da class de conexão via FireDAC
  oConn := TFactoryFireDAC.Create(FDConnection1, dnFirebird);
  oLookup := TContainerFDMemTable<TTab_Lookup>.Create(oConn, FDLookup);
  oLookup.Open;
end;

end.
