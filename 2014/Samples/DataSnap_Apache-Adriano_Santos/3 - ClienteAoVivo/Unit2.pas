unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, Data.FireDACJSONReflect,
  FMX.Controls, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, System.Rtti, FMX.StdCtrls, FMX.Layouts, FMX.Grid, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, FMX.Controls.Presentation, FMX.Edit;

type
  TForm2 = class(TForm)
    StringGrid1: TStringGrid;
    SpeedButton1: TSpeedButton;
    FDMemTable1: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    edtUrlPath: TEdit;
    edtHost: TEdit;
    edtPorta: TEdit;
    Label1: TLabel;
    UrlPath: TLabel;
    Host: TLabel;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses ClientModuleUnit3;

procedure TForm2.SpeedButton1Click(Sender: TObject);
var
  {uses: Data.FireDACJSONReflect}
  LDataSetList: TFDJSONDataSets;
begin
  LDataSetList := ClientModule3.ServerMethods1Client.GetDepartmentNames();

  // Update UI
  FDMemTable1.Active := False;
  Assert(TFDJSONDataSetsReader.GetListCount(LDataSetList) = 1);
  FDMemTable1.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList, 0));

end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
begin
  ClientModule3.DSRestConnection1.Host    := edtHost.Text;
  ClientModule3.DSRestConnection1.UrlPath := edtUrlPath.Text;
  ClientModule3.DSRestConnection1.Port    := edtPorta.Text.ToInteger;
end;

end.
