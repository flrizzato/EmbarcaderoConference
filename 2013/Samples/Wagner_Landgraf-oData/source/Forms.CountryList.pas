unit Forms.CountryList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Aurelius.Bind.Dataset,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls,
  Aurelius.Engine.ObjectManager;

type
  TCountriesForm = class(TForm)
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    CountriesDataset: TAureliusDataset;
    DataSource1: TDataSource;
    CountriesDatasetSelf: TAureliusEntityField;
    CountriesDatasetId: TIntegerField;
    CountriesDatasetName: TStringField;
    CountriesDatasetCountryCode: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Manager: TObjectManager;
  public
  end;

implementation

{$R *.dfm}

uses
  Entities, Modules.Connections;

procedure TCountriesForm.FormCreate(Sender: TObject);
begin
  Manager := TObjectManager.Create(Connections.DefaultConnection);
  CountriesDataset.Manager := Manager;
  CountriesDataset.SetSourceCriteria(Manager.Find<TCountry>);
  CountriesDataset.Open;
end;

procedure TCountriesForm.FormDestroy(Sender: TObject);
begin
  Manager.Free;
end;

end.
