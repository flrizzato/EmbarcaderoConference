unit XDataMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Data.DB,
  Aurelius.Bind.Dataset, Vcl.StdCtrls, Generics.Collections,
  MyServerOperations,
  DBDemosEntities,
  XData.Client;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    edCountry: TEdit;
    btSearch: TButton;
    AureliusDataset1: TAureliusDataset;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    edYears: TEdit;
    procedure btSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    XDataClient: TXDataClient;
    FCustomers: TList<TCustomer>;
    procedure SetCustomers(const Value: TList<TCustomer>);
    property Customers: TList<TCustomer> read FCustomers write SetCustomers;
  public
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.btSearchClick(Sender: TObject);
var
  CustomerMethods: ICustomerMethods;
begin
  CustomerMethods := XDataClient.Service<ICustomerMethods>;
  Customers := CustomerMethods.FindOldByCountry(edCountry.Text, StrToInt(edYears.Text));
  AureliusDataset1.Close;
  AureliusDataset1.SetSourceList(Customers);
  AureliusDataset1.Open;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  XDataClient := TXDataClient.Create;
  XDataClient.Uri := 'http://localhost/tms/dbdemos/rest';
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  AureliusDataset1.Close;
  FCustomers.Free;
  XDataClient.Free;
end;

procedure TForm2.SetCustomers(const Value: TList<TCustomer>);
begin
  FCustomers.Free;
  FCustomers := Value;
end;

end.
