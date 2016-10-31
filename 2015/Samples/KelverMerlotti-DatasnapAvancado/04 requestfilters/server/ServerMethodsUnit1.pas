unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
{$METHODINFO ON}
  TServerMethods1 = class(TDataModule)
    Con: TFDConnection;
    qryCustomer: TFDQuery;
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
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function Customers: TDataset;
  end;
{$METHODINFO OFF}

implementation


{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.Customers: TDataset;
begin
  qryCustomer.Close;
  qryCustomer.Open;
  result := qryCustomer;
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

