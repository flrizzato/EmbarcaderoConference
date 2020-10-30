unit Unit1;

interface

uses
  MVCFramework, MVCFramework.Commons, DMDadosUnit;

type

  [MVCPath('/api')]
  TMyController = class(TMVCController)
  private
    FDMDados: TDMDados;
  protected
    function GetDMDados: TDMDados;
    procedure MVCControllerBeforeDestroy; override;
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string;
      var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext;
      const AActionName: string); override;
  public
    [MVCPath('/')]
    [MVCHTTPMethod([httpGET])]
    procedure Index;
    [MVCPath('/reversedstrings/($Value)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetReversedString(const Value: String);
    // CRUD
    // SELECT
    [MVCPath('/customers')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomers;
    // INSERT
    [MVCPath('/customers')]
    [MVCHTTPMethod([httpPOST])]
    procedure CreateCustomer;
    // UPDATE
    [MVCPath('/customers')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateCustomer;
    // DELETE
    [MVCPath('/customers/($id)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteCustomer(id: string);
  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils, CustomerClass,
  System.JSON;

procedure TMyController.Index;
begin
  // use Context property to access to the HTTP request and response
  Render('Hello DelphiMVCFramework World');
end;

procedure TMyController.MVCControllerBeforeDestroy;
begin
  inherited;
  FDMDados.Free;
end;

procedure TMyController.GetReversedString(const Value: String);
begin
  Render(System.StrUtils.ReverseString(Value.Trim));
end;

procedure TMyController.OnAfterAction(Context: TWebContext;
  const AActionName: string);
begin
  { Executed after each action }
  inherited;
end;

procedure TMyController.OnBeforeAction(Context: TWebContext;
  const AActionName: string; var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;

procedure TMyController.GetCustomers;
begin
  Render(GetDMDados.GetCustomers, True);
end;

function TMyController.GetDMDados: TDMDados;
begin
  if not Assigned(FDMDados) then
  begin
    FDMDados := TDMDados.Create(nil);
  end;
  Result := FDMDados;
end;

procedure TMyController.CreateCustomer;
var
  customer: TCustomer;
begin
  customer := Context.Request.BodyAs<TCustomer>;
  try
    GetDMDados.AddCustomer(customer);
    Render(TJSONTrue.Create);
  finally
    customer.Free;
  end;
end;

procedure TMyController.UpdateCustomer;
var
  customer: TCustomer;
begin
  customer := Context.Request.BodyAs<TCustomer>;
  try
    GetDMDados.UpdateCustomer(customer);
    Render(TJSONTrue.Create);
  finally
    customer.Free;
  end;
end;

procedure TMyController.DeleteCustomer(id: string);
begin
  GetDMDados.DeleteCustomer(id);
  Render(TJSONTrue.Create);
end;

end.
