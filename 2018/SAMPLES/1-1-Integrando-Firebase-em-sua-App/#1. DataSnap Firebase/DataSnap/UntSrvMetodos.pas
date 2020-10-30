unit UntSrvMetodos;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Json,
  System.Json.Writers,
  System.Json.Types,

  Data.DBXPlatform,
  Data.DB,
  Data.FireDACJSONReflect,

  Datasnap.DSProviderDataModuleAdapter,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin,

  TBGFirebaseConnection.View.Connection,

  Constantes;

type
  TSrvMetodos = class(TDSServerModule)
    memData: TFDMemTable;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    procedure DSServerModuleCreate(Sender: TObject);
    procedure DSServerModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FBGFirebase : TTBGFirebaseConnection;

    procedure GetTicketsFromFirebase(const ATicket: String = '');
    procedure SyncFirebase(AJSONObject: String);
    procedure PutFirebase(ATicket: String);
    procedure PatchFirebase(ATicket: string);
    procedure DeleteFirebase(ATicket: string);
  public
    { Public declarations }
    function GetTickets(const ATicket: String = ''): TFDJSONDataSets;
    //function GetUser(const AUsuario: string): TFDJSONDataSets;
    //function RegisterUser(const AData: TJSONObject): string;
    function Sincronizar(const ATickets: String): Boolean;
    function PatchTicket(const ATicket: string): Boolean;
  end;

implementation

uses
  ULGTDataSetHelper;


{$R *.dfm}


{ TSrvMetodos }
function TSrvMetodos.GetTickets(const ATicket: String): TFDJSONDataSets;
begin
  try
    memData.Active := False;
    GetTicketsFromFirebase(ATicket);
    Result := TFDJSONDataSets.Create;
    TFDJSONDataSetsWriter.ListAdd(Result, memData);
  except on E:Exception do
    begin
      //
    end;
  end;
end;

procedure TSrvMetodos.GetTicketsFromFirebase(const ATicket: String = '');
begin
  try
    FBGFirebase
    .Connect
      .BaseURL(C_BaseURLFirebase)
      .Auth('anonymous')
      .uId(C_UUID)
    .&End
    .Get
      .DataSet(MemData)
      .Resource(Format('%s/%s', [C_TICKET, ATicket]))
    .&End
    .Exec;
  except on E:Exception do
    begin
      //
    end;
  end;
end;

procedure TSrvMetodos.PatchFirebase(ATicket: string);
begin
  try
    FBGFirebase
    .Connect
      .BaseURL(C_BaseURLFirebase)
      .Auth('anonymous')
      .uId(C_UUID)
    .&End
    .Patch
      .Resource(C_TICKET)
      .Json(ATicket)
    .&End
    .Exec;
  except on E:Exception do
    begin

    end;
  end;
end;

function TSrvMetodos.PatchTicket(const ATicket: string): Boolean;
begin
  Result := False;
  try
    PatchFirebase(ATicket);
    Result := True;
  except on E:Exception do
    begin

    end;
  end;
end;

function TSrvMetodos.Sincronizar(const ATickets: String): Boolean;
begin
  Result := True;
  try
    SyncFirebase(ATickets);
    Result := True;
  except on E:Exception do
    begin
      //
    end;
  end;
end;

procedure TSrvMetodos.PutFirebase(ATicket: String);
begin
  try
    FBGFirebase
    .Connect
      .BaseURL(C_BaseURLFirebase)
      .Auth('anonymous')
      .uId(C_UUID)
    .&End
    .Put
      .Resource(C_TICKET)
      .Json(ATicket)
    .&End
    .Exec;
  except on E:Exception do
    begin

    end;
  end;
end;

procedure TSrvMetodos.SyncFirebase(AJSONObject: String);
begin
  try
    FBGFirebase
    .Connect
      .BaseURL(C_BaseURLFirebase)
      .Auth('anonymous')
      .uId(C_UUID)
    .&End
    .Patch
      .Resource('')
      .Json(AJSONObject)
    .&End
    .Exec;
  except on E:Exception do
    begin

    end;
  end;
end;

procedure TSrvMetodos.DeleteFirebase(ATicket: string);
begin
//  try
//    FBGFirebase
//    .Connect
//      .BaseURL(C_BaseURLFirebase)
//      .Auth('anonymous')
//      .uId(C_UUID)
//    .&End
//    .Delete
//      .Resource(ATicket)
//    .&End
//    .Exec;
//  except on E:Exception do
//    begin
//      //
//    end;
//  end;
end;

procedure TSrvMetodos.DSServerModuleCreate(Sender: TObject);
begin
  if not Assigned(FBGFirebase) then
    FBGFirebase := TTBGFirebaseConnection.Create;
end;

procedure TSrvMetodos.DSServerModuleDestroy(Sender: TObject);
begin
  if Assigned(FBGFirebase) then
    FBGFirebase.Free;
end;


end.

