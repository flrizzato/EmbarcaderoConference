unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.DB, Datasnap.DBClient, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TForm2 = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button1: TButton;
    ClientDataSet1ID: TStringField;
    ClientDataSet1Name: TStringField;
    ClientDataSet1Description: TStringField;
    ClientDataSet1ReleaseDate: TStringField;
    ClientDataSet1DiscontinuedDate: TStringField;
    ClientDataSet1Rating: TStringField;
    ClientDataSet1Price: TStringField;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses REST.Json;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
const
  url = 'http://services.odata.org/V3/OData/OData.svc/Products';
begin
  RESTClient1.BaseURL := url;
  RESTResponseDataSetAdapter1.FieldDefs.Clear;
  RESTRequest1.Execute;
end;

end.
