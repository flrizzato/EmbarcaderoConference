unit DBDemosMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, RemoteDB.Client.Dataset,
  Vcl.StdCtrls, RemoteDB.Client.Database, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfmMain = class(TForm)
    RemoteDBDatabase1: TRemoteDBDatabase;
    edServer: TEdit;
    Label1: TLabel;
    btConnect: TButton;
    DataSource1: TDataSource;
    XDataset1: TXDataset;
    DBGrid1: TDBGrid;
    DBImage1: TDBImage;
    DBMemo1: TDBMemo;
    procedure btConnectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.btConnectClick(Sender: TObject);
begin
  RemoteDBDatabase1.ServerUri := edServer.Text;
  RemoteDBDatabase1.Connected := true;
  XDataset1.Open;
end;

end.
