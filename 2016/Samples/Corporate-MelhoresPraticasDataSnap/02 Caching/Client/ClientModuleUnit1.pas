unit ClientModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, ClientClassesUnit1, IPPeerClient,
  Datasnap.DSClientRest;

type
  TClientModule1 = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FServerMethods1Client: TServerMethods1Client;
    FsmCachedDataClient: TsmCachedDataClient;
    function GetServerMethods1Client: TServerMethods1Client;
    function GetsmCachedDataClient: TsmCachedDataClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property ServerMethods1Client: TServerMethods1Client read GetServerMethods1Client write FServerMethods1Client;
    property smCachedDataClient: TsmCachedDataClient read GetsmCachedDataClient write FsmCachedDataClient;
  end;

var
  ClientModule1: TClientModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TClientModule1.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TClientModule1.Destroy;
begin
  FServerMethods1Client.Free;
  FsmCachedDataClient.Free;
  inherited;
end;

function TClientModule1.GetServerMethods1Client: TServerMethods1Client;
begin
  if FServerMethods1Client = nil then
    FServerMethods1Client:= TServerMethods1Client.Create(DSRestConnection1, FInstanceOwner);
  Result := FServerMethods1Client;
end;

function TClientModule1.GetsmCachedDataClient: TsmCachedDataClient;
begin
  if FsmCachedDataClient = nil then
    FsmCachedDataClient := TsmCachedDataClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FsmCachedDataClient;
end;

end.
