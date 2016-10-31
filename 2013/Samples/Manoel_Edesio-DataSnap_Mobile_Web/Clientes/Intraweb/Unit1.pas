unit Unit1;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Data.DBXDataSnap, IPPeerClient, Data.DBXCommon, Data.DB, Data.SqlExpr,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.Controls, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids,
  IWCompButton;

type
  TIWForm1 = class(TIWAppForm)
    SQLConnection1: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    IWDBGrid1: TIWDBGrid;
    IWButton1: TIWButton;
    procedure IWButton1Click(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}


procedure TIWForm1.IWButton1Click(Sender: TObject);
begin
  ClientDataSet1.Close;
  ClientDataSet1.Open;
end;

initialization
  TIWForm1.SetAsMainForm;

end.
