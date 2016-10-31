unit uDM_ModuloEnvio;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, IPPeerServer,
  System.Tether.Manager, System.Tether.AppProfile;

type
  TDM_ModuloEnvio = class(TDataModule)
    TetheringAppProfile1: TTetheringAppProfile;
    TetheringManager1: TTetheringManager;
    procedure TetheringManager1RequestManagerPassword(const Sender: TObject;
      const ARemoteIdentifier: string; var Password: string);
    procedure TetheringManager1EndManagersDiscovery(const Sender: TObject;
      const ARemoteManagers: TTetheringManagerInfoList);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    Connected : Boolean;
    FNFCe: TStringList;
    FListaServers: TStringList;
    procedure SetNFCe(const Value: TStringList);
    procedure SetListaServers(const Value: TStringList);
  public
    { Public declarations }
    procedure FindWalls;
    function Send : Boolean;
    function CheckServers : Boolean;
    procedure Refresh;
    property NFCe : TStringList read FNFCe write SetNFCe;
    property ListaServers : TStringList read FListaServers write SetListaServers;
  end;

var
  DM_ModuloEnvio: TDM_ModuloEnvio;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  System.Tether.NetworkAdapter;

{ TDM_ModuloEnvio }

function TDM_ModuloEnvio.CheckServers: Boolean;
begin
  if FListaServers.Count > 0 then
    Result := True
  else
    begin
      Result := False;
    end;
end;

procedure TDM_ModuloEnvio.DataModuleCreate(Sender: TObject);
begin
  Connected := False;
  FListaServers := TStringList.Create;
  FNFCe := TStringList.Create;
  //FindWalls;

end;

procedure TDM_ModuloEnvio.FindWalls;
var
  I: Integer;
begin
//TetheringManager1.AutoConnect();
{  FListaServers.Clear;
  for I := (TetheringManager1.PairedManagers.Count)-1 downto 0 do
    TetheringManager1.UnPairManager(TetheringManager1.PairedManagers[I]);
  TetheringManager1.DiscoverManagers; }
end;

procedure TDM_ModuloEnvio.Refresh;
var
I: Integer;
begin
 { FListaServers.Clear;

  for I := 0 to TetheringManager1.RemoteProfiles.Count - 1 do
    if (TetheringManager1.RemoteProfiles[I].ProfileText = 'ServidorTether') then
      FListaServers.Add(TetheringManager1.RemoteProfiles[I].ProfileText);

  if FListaServers.Count > 0 then
    begin
      Connected :=
        TetheringAppProfile1.Connect(TetheringManager1.RemoteProfiles[0]);
    end; }
end;

function TDM_ModuloEnvio.Send: Boolean;
var
  LStream: TMemoryStream;
begin
  if not Connected then
  Connected :=
    TetheringAppProfile1.Connect(TetheringManager1.RemoteProfiles[0]);
  LStream := TMemoryStream.Create;
  try
    NFCe.SaveToStream(LStream);
  Result :=
    TetheringAppProfile1.SendStream(TetheringManager1.RemoteProfiles[0],
      'NFCe', LStream);
  finally
    LStream.Free;
  end;
end;

procedure TDM_ModuloEnvio.SetListaServers(const Value: TStringList);
begin
  FListaServers := Value;
end;

procedure TDM_ModuloEnvio.SetNFCe(const Value: TStringList);
begin
  FNFCe := Value;
end;

procedure TDM_ModuloEnvio.TetheringManager1EndManagersDiscovery(
  const Sender: TObject; const ARemoteManagers: TTetheringManagerInfoList);
var
  i : integer;
begin
  {for I := 0 to ARemoteManagers.Count-1 do
    if (ARemoteManagers[I].ManagerText = 'ServidorTether') then
  TetheringManager1.PairManager(ARemoteManagers[I]); }
end;

procedure TDM_ModuloEnvio.TetheringManager1RequestManagerPassword(
  const Sender: TObject; const ARemoteIdentifier: string; var Password: string);
begin
  Password := '1234';
end;

end.
