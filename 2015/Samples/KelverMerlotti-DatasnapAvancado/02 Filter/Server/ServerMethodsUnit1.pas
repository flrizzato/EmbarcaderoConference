unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  Datasnap.Provider, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TServerMethods1 = class(TDSServerModule)
    Con: TFDConnection;
    qrySalary: TFDQuery;
    qryCustomer: TFDQuery;
    dspCustomer: TDataSetProvider;
    qryCustomerCUST_NO: TIntegerField;
    qryCustomerCUSTOMER: TStringField;
    qryCustomerCONTACT_FIRST: TStringField;
    qryCustomerCONTACT_LAST: TStringField;
    qryCustomerPHONE_NO: TStringField;
    qryCustomerADDRESS_LINE1: TStringField;
    qryCustomerADDRESS_LINE2: TStringField;
    qryCustomerCITY: TStringField;
    qryCustomerSTATE_PROVINCE: TStringField;
    qryCustomerCOUNTRY: TStringField;
    qryCustomerPOSTAL_CODE: TStringField;
    qryCustomerON_HOLD: TStringField;
    qrySalarySALARY: TBCDField;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    [TRoleAuth('Admin')] //won't take effect if you use TDSAuthenticationManager.Roles Collection
    function GetSalary(aUserId: Integer): Double;
  end;

implementation


{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TServerMethods1.GetSalary(aUserId: Integer): Double;
begin
  qrySalary.Params[0].Value := aUserId;
  try
    qrySalary.Open;
    result := qrySalarySALARY.AsFloat;
  finally
    qrySalary.Close;
  end;
end;

end.

