unit Unit2;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes;

type

  [ResourceName('EC2014')]
  TECResource1 = class(TDataModule)
  published
    procedure Get(const AContext: TEndpointContext;
      const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure GetItem(const AContext: TEndpointContext;
      const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    procedure Post(const AContext: TEndpointContext;
      const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

procedure Register;

implementation

{ %CLASSGROUP 'System.Classes.TPersistent' }

uses Negocio, REST.JSON;

{$R *.dfm}

procedure TECResource1.Get(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  jClientes: TJSONArray;
begin
  jClientes := TJSONArray.Create;
  jClientes.AddElement(TJson.ObjectToJsonObject(TCliente.Create(1, 'Delphi')));
  jClientes.AddElement(TJson.ObjectToJsonObject(TCliente.Create(2,
    'Rad Studio')));
  AResponse.Body.SetValue(jClientes, True);
end;

procedure TECResource1.GetItem(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
  jClientes: TJSONArray;
begin
  LItem := ARequest.Params.Values['item'];
  jClientes := TJSONArray.Create;
  jClientes.AddElement(TJson.ObjectToJsonObject(TCliente.Create(1, LItem)));
  AResponse.Body.SetValue(jClientes, True);
end;

procedure TECResource1.Post(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LJSON: TJSONObject;
begin
  if ARequest.Body.TryGetObject(LJSON) then
  begin
    AResponse.Body.SetValue(LJSON, True);
  end
  else
  begin
    AResponse.RaiseBadRequest('JSON expected');
  end;
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TECResource1));
end;

end.
