unit uServerMethodsCachedData;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, Data.DB;

type
{$METHODINFO ON}
  TsmCachedData = class(TDataModule)
    qryCountry: TFDQuery;
    Con: TFDConnection;
    memCountry: TFDMemTable;
    qryCountryCOUNTRY: TStringField;
    qryCountryCURRENCY: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function Countries: TDataSet;
  end;
{$METHODINFO OFF}

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TsmCachedData }

function TsmCachedData.Countries: TDataSet;
begin
  if not memCountry.Active then
  begin
    qryCountry.Open;
    memCountry.CopyDataSet(qryCountry, [coStructure, coRestart, coAppend]);
  end;
  result := memCountry;
end;

end.

