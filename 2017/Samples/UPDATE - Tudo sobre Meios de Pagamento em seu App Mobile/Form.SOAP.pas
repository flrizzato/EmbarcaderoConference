unit Form.SOAP;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts,
  FMX.StdCtrls, globalweather, FMX.ScrollBox, FMX.Memo, System.Rtti, FMX.Grid.Style, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors, Xml.xmldom, Datasnap.Provider,
  Datasnap.Xmlxform, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, FMX.Grid, Data.DB, Datasnap.DBClient;

type
  TfrmSOAP = class(TForm)
    Layout1: TLayout;
    editCountry: TEdit;
    editCity: TEdit;
    buttonConsulta: TButton;
    memoResult: TMemo;
    cdsCountry: TClientDataSet;
    Grid1: TGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    XMLTransformProvider1: TXMLTransformProvider;
    buttonConsultaCidades: TButton;
    LinkControlToField1: TLinkControlToField;
    procedure buttonConsultaClick(Sender: TObject);
    procedure buttonConsultaCidadesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSOAP: TfrmSOAP;

implementation

{$R *.fmx}

procedure TfrmSOAP.buttonConsultaCidadesClick(Sender: TObject);
var
  lSOAP: GlobalWeatherSoap;
  lRetorno: string;
  lStl: TStringList;
begin
  lSOAP := GetGlobalWeatherSoap;
  lRetorno:= lSOAP.GetCitiesByCountry(editCountry.Text);
  lStl := TStringList.Create;
  try
    lStl.Text := lRetorno;
    lStl.SaveToFile('Country.xml');
  finally
    lStl.Free;
  end;

  cdsCountry.Close;
  XMLTransformProvider1.XMLDataFile := 'Country.xml';
  cdsCountry.Open;

  memoResult.Text := lRetorno;
end;

procedure TfrmSOAP.buttonConsultaClick(Sender: TObject);
var
  lSOAP: GlobalWeatherSoap;
  lRetorno: string;
begin
  lSOAP := GetGlobalWeatherSoap;
  lRetorno:= lSOAP.GetWeather(editCity.Text, editCountry.Text);
  memoResult.Text := lRetorno;
end;

end.
