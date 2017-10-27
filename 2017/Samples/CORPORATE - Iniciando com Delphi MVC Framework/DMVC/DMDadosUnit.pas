unit DMDadosUnit;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.MSSQLDef, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Stan.Intf, FireDAC.Phys,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  CustomerClass;

type
  TDMDados = class(TDataModule)
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDConnection1: TFDConnection;
    spCustomerINSERT: TFDStoredProc;
    spCustomerUPDATE: TFDStoredProc;
    spCustomerDELETE: TFDStoredProc;
    spCustomersSELECT: TFDStoredProc;
    spCustomersSELECTCustomerID: TWideStringField;
    spCustomersSELECTCompanyName: TWideStringField;
    spCustomersSELECTContactName: TWideStringField;
    spCustomersSELECTCity: TWideStringField;
  private
    { Private declarations }
  public
    function GetCustomers: TDataSet;
    function AddCustomer(ACustomer: TCustomer): Boolean;
    function UpdateCustomer(ACustomer: TCustomer): Boolean;
    function DeleteCustomer(ACustomerID: string): Boolean;
  end;

var
  DMDados: TDMDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMDados }

function TDMDados.AddCustomer(ACustomer: TCustomer): Boolean;
begin
  spCustomerINSERT.ParamByName('@CustomerID').AsString := ACustomer.customerid;
  spCustomerINSERT.ParamByName('@CompanyName').AsString := ACustomer.companyname;
  spCustomerINSERT.ParamByName('@ContactName').AsString := ACustomer.contactname;
  spCustomerINSERT.ParamByName('@City').AsString := ACustomer.city;
  spCustomerINSERT.ExecProc;
  Result := True;
end;

function TDMDados.DeleteCustomer(ACustomerID: string): Boolean;
begin
  spCustomerDELETE.ParamByName('@CustomerID').AsString := ACustomerID;
  spCustomerDELETE.ExecProc;
  Result := True;
end;

function TDMDados.GetCustomers: TDataSet;
begin
  spCustomersSELECT.Close;
  spCustomersSELECT.Open;
  Result := spCustomersSELECT;
end;

function TDMDados.UpdateCustomer(ACustomer: TCustomer): Boolean;
begin
  spCustomerUPDATE.ParamByName('@CustomerID').AsString := ACustomer.customerid;
  spCustomerUPDATE.ParamByName('@CompanyName').AsString := ACustomer.companyname;
  spCustomerUPDATE.ParamByName('@ContactName').AsString := ACustomer.contactname;
  spCustomerUPDATE.ParamByName('@City').AsString := ACustomer.city;
  spCustomerUPDATE.ExecProc;
  Result := True;
end;

end.
