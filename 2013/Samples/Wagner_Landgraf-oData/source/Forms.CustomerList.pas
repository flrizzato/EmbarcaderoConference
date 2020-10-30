unit Forms.CustomerList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Aurelius.Bind.Dataset,
  Aurelius.Engine.ObjectManager, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids,
  Entities, Vcl.StdCtrls;

type
  TCustomersForm = class(TForm)
    CustomersDataset: TAureliusDataset;
    CustomersDatasetSelf: TAureliusEntityField;
    CustomersDatasetId: TIntegerField;
    CustomersDatasetName: TStringField;
    CustomersDatasetCity: TStringField;
    CustomersDatasetState: TStringField;
    CustomersDatasetCountry: TAureliusEntityField;
    CustomersDatasetCustomerType: TIntegerField;
    CustomersDatasetCustomerTypeEnumName: TStringField;
    CustomersDatasetCountryName: TStringField;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    DataSource1: TDataSource;
    Label1: TLabel;
    CountriesDataset: TAureliusDataset;
    CustomersDatasetCountryLookup: TStringField;
    DBGrid2: TDBGrid;
    DBNavigator2: TDBNavigator;
    CustomersDatasetContacts: TDataSetField;
    ContactsDataset: TAureliusDataset;
    DataSource2: TDataSource;
    ContactsDatasetSelf: TAureliusEntityField;
    ContactsDatasetId: TIntegerField;
    ContactsDatasetName: TStringField;
    ContactsDatasetPhone: TStringField;
    ContactsDatasetCustomer: TAureliusEntityField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Manager: TObjectManager;
  public
  end;

implementation

uses
  Modules.Connections;

{$R *.dfm}

procedure TCustomersForm.FormCreate(Sender: TObject);
begin
  Manager := TObjectManager.Create(Connections.DefaultConnection);
  CountriesDataset.Manager := Manager;
  CountriesDataset.SetSourceCriteria(Manager.Find<TCountry>);
  CountriesDataset.Open;

  CustomersDataset.Manager := Manager;
  CustomersDataset.SetSourceCriteria(Manager.Find<TCustomer>);
  CustomersDataset.Open;
end;

procedure TCustomersForm.FormDestroy(Sender: TObject);
begin
  Manager.Free;
end;

end.
