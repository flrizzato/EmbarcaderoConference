unit Unit5;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Phys.ODBCBase, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageJSON, FireDAC.Comp.UI;

type
  [ResourceName('Dados')]
  TDadosResource1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    qrPessoa: TFDQuery;
    qrPessoaCodigo: TIntegerField;
    qrPessoaNome: TStringField;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDSchemaAdapter1: TFDSchemaAdapter;
  published
    [EndpointName('GetRecords')]
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [EndpointName('PostUpdates')]
    procedure Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

procedure Register;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDadosResource1.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  oStr: TMemoryStream;
begin
  oStr := TMemoryStream.Create;
  try
  try
    qrPessoa.Open;
    FDSchemaAdapter1.SaveToStream(oStr, TFDStorageFormat.sfJSON);
    // Response owns stream
    AResponse.Body.SetStream(oStr, 'application/json', True);
  except
    oStr.Free;
  end;
  finally
    qrPessoa.Close;
    FDConnection1.Close;
  end;
end;

procedure TDadosResource1.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LStream: TStream;
begin
  if not SameText(ARequest.Body.ContentType, 'application/json') then
    AResponse.RaiseBadRequest('content type');
  if not ARequest.Body.TryGetStream(LStream) then
    AResponse.RaiseBadRequest('no stream');
  LStream.Position := 0;
  FDSchemaAdapter1.LoadFromStream(LStream, TFDStorageFormat.sfJSON);
  FDSchemaAdapter1.ApplyUpdates;
  FDConnection1.Close;
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TDadosResource1));
end;

end.


