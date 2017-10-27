unit uMainDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Stan.StorageBin, FireDAC.Stan.StorageJSON,
  Datasnap.DSClientRest, ClientClassesUnit1, FireDAC.FMXUI.Wait, FireDAC.Comp.UI;

type
  TMainDM = class(TDataModule)
    DSRestCnn: TDSRestConnection;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    CaseMemTable: TFDMemTable;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    CaseMemTableId: TWideStringField;
    CaseMemTableIsDeleted: TShortintField;
    CaseMemTableCaseNumber: TWideStringField;
    CaseMemTableContactId: TWideStringField;
    CaseMemTableAccountId: TWideStringField;
    CaseMemTableAssetId: TWideStringField;
    CaseMemTableParentId: TWideStringField;
    CaseMemTableSuppliedName: TWideStringField;
    CaseMemTableSuppliedEmail: TWideStringField;
    CaseMemTableSuppliedPhone: TWideStringField;
    CaseMemTableSuppliedCompany: TWideStringField;
    CaseMemTableType: TWideStringField;
    CaseMemTableStatus: TWideStringField;
    CaseMemTableReason: TWideStringField;
    CaseMemTableOrigin: TWideStringField;
    CaseMemTableSubject: TWideStringField;
    CaseMemTablePriority: TWideStringField;
    CaseMemTableDescription: TWideStringField;
    CaseMemTableIsClosed: TShortintField;
    CaseMemTableClosedDate: TWideStringField;
    CaseMemTableIsEscalated: TShortintField;
    CaseMemTableOwnerId: TWideStringField;
    CaseMemTableCreatedDate: TWideStringField;
    CaseMemTableCreatedById: TWideStringField;
    CaseMemTableLastModifiedDate: TWideStringField;
    CaseMemTableLastModifiedById: TWideStringField;
    CaseMemTableSystemModstamp: TWideStringField;
    CaseMemTableContactPhone: TWideStringField;
    CaseMemTableContactMobile: TWideStringField;
    CaseMemTableContactEmail: TWideStringField;
    CaseMemTableContactFax: TWideStringField;
    CaseMemTableLastViewedDate: TWideStringField;
    CaseMemTableLastReferencedDate: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FServerIP: string;
    FUserName: string;
    FPassword: string;

    FInstanceOwner: Boolean;
    FServerMethods1Client: TServerMethods1Client;
    function GetServerMethods1Client: TServerMethods1Client;

    procedure SaveLoginData;
    procedure LoadLoginData;
  public
    { Public declarations }
    function UserLogin: boolean;
    procedure LoadSFCases;

    property ServerIP: string read FServerIP write FServerIP;
    property UserName: string read FUserName write FUserName;
    property Password: string read FPassword write FPassword;

    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property ServerMethods1Client: TServerMethods1Client
      read GetServerMethods1Client write FServerMethods1Client;
  end;

var
  MainDM: TMainDM;

implementation

uses Inifiles, System.IOUtils, Data.FireDACJSONReflect;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure TMainDM.DataModuleCreate(Sender: TObject);
begin
  FInstanceOwner := True;
  LoadLoginData;
end;

procedure TMainDM.DataModuleDestroy(Sender: TObject);
begin
  FServerMethods1Client.Free;
end;

function TMainDM.GetServerMethods1Client: TServerMethods1Client;
begin
  if FServerMethods1Client = nil then
    FServerMethods1Client := TServerMethods1Client.Create(DSRestCnn,
      FInstanceOwner);
  Result := FServerMethods1Client;
end;

function TMainDM.UserLogin: boolean;
begin
  Result := False;
  DSRestCnn.Host := fServerIP;
  if ServerMethods1Client.DoUserLogin(fUserName, fPassword) then
   begin
     SaveLoginData;
     Result := True;
   end;
end;

procedure TMainDM.LoadSFCases;
var
  LDataSetList: TFDJSONDataSets;
begin
  DSRestCnn.Host := FServerIP;
  LDataSetList := ServerMethods1Client.GetSFCases(fUserName, fPassword);

  CaseMemTable.Close;
  CaseMemTable.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList, 0));
  CaseMemTable.Open;
end;

procedure TMainDM.SaveLoginData;
var
  Ini: TIniFile;
  fFile: String;
begin
{$IF DEFINED(MSWINDOWS)}
  fFile := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
    'SF.ini';
{$ELSE}
  fFile := TPath.GetDocumentsPath + PathDelim + 'SF.ini';
{$ENDIF}
  Ini := TIniFile.Create(fFile);
  try
    Ini.WriteString('SF', 'UserName', fUserName);
    Ini.WriteString('SF', 'ServerIP', fServerIP);
    Ini.UpdateFile;
  finally
    Ini.Free;
  end;
end;

procedure TMainDM.LoadLoginData;
var
  Ini: TIniFile;
  fFile: String;
  fParams: TStringList;
begin
{$IF DEFINED(MSWINDOWS)}
  fFile := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
    'SF.ini';
{$ELSE}
  fFile := TPath.GetDocumentsPath + PathDelim + 'SF.ini';
{$ENDIF}
  if TFile.Exists(fFile) then
  begin
    fParams := TStringList.Create;
    Ini := TIniFile.Create(fFile);
    try
      Ini.ReadSectionValues('SF', fParams);
      fServerIP := fParams.Values['ServerIP'];
      fUserName := fParams.Values['UserName'];
    finally
      Ini.Free;
    end;
  end;
end;

end.
