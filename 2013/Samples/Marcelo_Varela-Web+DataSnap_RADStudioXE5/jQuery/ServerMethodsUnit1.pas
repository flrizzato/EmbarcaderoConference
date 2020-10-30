unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TServerMethods1 = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    spCustomersInsert: TFDStoredProc;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function CustomersInsert(CustomerID, CompanyName, ContactName, City: string): Boolean;
    function GetDados: TDataSet;
  end;

implementation

{$R *.dfm}

uses System.StrUtils;

function TServerMethods1.CustomersInsert(CustomerID, CompanyName, ContactName,
  City: string): Boolean;
begin
  spCustomersInsert.ParamByName('@CustomerID').AsString := CustomerID;
  spCustomersInsert.ParamByName('@CompanyName').AsString := CompanyName;
  spCustomersInsert.ParamByName('@ContactName').AsString := ContactName;
  spCustomersInsert.ParamByName('@City').AsString := City;
  spCustomersInsert.ExecProc;
  Result := True;
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GetDados: TDataSet;
begin
  FDQuery1.Close;
  FDQuery1.Open;
  Result := FDQuery1;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

