unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
  Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.CDataSalesforce, FireDAC.Phys.CDataSalesforceDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.FireDACJSONReflect, FireDAC.Stan.StorageBin,
  FireDAC.Stan.StorageJSON;

type
{$METHODINFO ON}
  TServerMethods1 = class(TDataModule)
    FDCnn: TFDConnection;
    CaseTable: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysCDataSalesforceDriverLink1: TFDPhysCDataSalesforceDriverLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    CaseTableId: TWideStringField;
    CaseTableIsDeleted: TShortintField;
    CaseTableCaseNumber: TWideStringField;
    CaseTableContactId: TWideStringField;
    CaseTableAccountId: TWideStringField;
    CaseTableAssetId: TWideStringField;
    CaseTableParentId: TWideStringField;
    CaseTableSuppliedName: TWideStringField;
    CaseTableSuppliedEmail: TWideStringField;
    CaseTableSuppliedPhone: TWideStringField;
    CaseTableSuppliedCompany: TWideStringField;
    CaseTableType: TWideStringField;
    CaseTableStatus: TWideStringField;
    CaseTableReason: TWideStringField;
    CaseTableOrigin: TWideStringField;
    CaseTableSubject: TWideStringField;
    CaseTablePriority: TWideStringField;
    CaseTableDescription: TWideStringField;
    CaseTableIsClosed: TShortintField;
    CaseTableClosedDate: TWideStringField;
    CaseTableIsEscalated: TShortintField;
    CaseTableOwnerId: TWideStringField;
    CaseTableCreatedDate: TWideStringField;
    CaseTableCreatedById: TWideStringField;
    CaseTableLastModifiedDate: TWideStringField;
    CaseTableLastModifiedById: TWideStringField;
    CaseTableSystemModstamp: TWideStringField;
    CaseTableContactPhone: TWideStringField;
    CaseTableContactMobile: TWideStringField;
    CaseTableContactEmail: TWideStringField;
    CaseTableContactFax: TWideStringField;
    CaseTableLastViewedDate: TWideStringField;
    CaseTableLastReferencedDate: TWideStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function DoUserLogin(fUserName, fPassword: string): boolean;
    function GetSFCases(fUserName, fPassword: string): TFDJSONDataSets;
  end;
{$METHODINFO OFF}

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

uses System.StrUtils;

function TServerMethods1.DoUserLogin(fUserName, fPassword: string): boolean;
begin
  FDCnn.Params.UserName := fUserName;
  FDCnn.Params.Password := fPassword;
  try
    // open the connection to validate the user/pass
    FDCnn.Open;
    Result := True;
    // close the connection after the validation
    FDCnn.Close;
  except
    on E: Exception do
      raise Exception.Create('UserLogin: ' + E.Message);
  end;
end;

function TServerMethods1.GetSFCases(fUserName, fPassword: string)
  : TFDJSONDataSets;
begin
  // active the connection
  FDCnn.Params.UserName := fUserName;
  FDCnn.Params.Password := fPassword;
  FDCnn.Open;

  // serialize the dataset
  CaseTable.Close;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, CaseTable);
end;

end.
