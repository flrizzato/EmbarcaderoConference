unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json {Data.DBXJSON},
    Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Datasnap.Provider, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase, Data.DBXJSON, FireDAC.Phys.IBDef;

type
  TServerMethods1 = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    DataSetProvider1: TDataSetProvider;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQuery1CUST_NO: TIntegerField;
    FDQuery1CUSTOMER: TStringField;
    FDQuery1CONTACT_FIRST: TStringField;
    FDQuery1CONTACT_LAST: TStringField;
    FDQuery1PHONE_NO: TStringField;
    FDQuery1ADDRESS_LINE1: TStringField;
    FDQuery1ADDRESS_LINE2: TStringField;
    FDQuery1CITY: TStringField;
    FDQuery1STATE_PROVINCE: TStringField;
    FDQuery1COUNTRY: TStringField;
    FDQuery1POSTAL_CODE: TStringField;
    FDQuery1ON_HOLD: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GenerateReport(aStart, anEnd: Integer; aCallback: TDBXCallback;
      var FSize: Integer): TStream;
  end;

implementation


{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GenerateReport(aStart, anEnd: Integer;
  aCallback: TDBXCallback; var FSize: Integer): TStream;
var
  i: Integer;
  Status: TJSONObject;
  LFileStream: TFileStream;
begin
  //here would be where you'd open your datasets, prepare you Report and save
  //the file, to disk or to stream, and then send it to the client
  for i := aStart to anEnd do
  begin
    Status := TJSONObject.Create;
    Status.AddPair('step', i.ToString);

    aCallback.Execute(Status).Free;
    Sleep(500);
  end;

  //opens de file and send it to the client
  LFileStream := TFileStream.Create('Report.pdf', fmOpenRead);
  FSize := LFileStream.Size;
  Result := LFileStream;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

