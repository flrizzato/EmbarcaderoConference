unit frmModeloUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, fraTopoUnt,
  Data.DBXDataSnap, Data.DBXCommon, Data.DbxHTTPLayer, Data.DB, Data.SqlExpr,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Controls.Presentation, FMX.Edit, FMX.ListBox,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient;

type
  TfrmModelo = class(TForm)
    fraTopo1: TfraTopo;
    ListViewDados: TListView;
    procedure fraTopo1btnVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModelo: TfrmModelo;

implementation

{$R *.fmx}

uses ModuloClientRestUnt;

procedure TfrmModelo.fraTopo1btnVoltarClick(Sender: TObject);
begin
  Close;
end;

end.
