unit UFiredacResource;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Stan.StorageJSON, FireDAC.Comp.UI;

type
  [ResourceName('FiredacResource')]
  TFiredacResourceResource1 = class(TDataModule)
    EmployeeConnection: TFDConnection;
    CustomerTable: TFDQuery;
    FDSchemaAdapter1: TFDSchemaAdapter;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
  published
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    procedure Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TFiredacResourceResource1.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LMem: TMemoryStream;
begin
  LMem:= TMemoryStream.Create;
  FDSchemaAdapter1.Open;
  FDSchemaAdapter1.SaveToStream(LMem, TFDStorageFormat.sfJSON);
  AResponse.Body.SetStream(LMem, 'application/json', True);
end;

procedure TFiredacResourceResource1.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TFiredacResourceResource1));
end;

initialization
  Register;
end.


