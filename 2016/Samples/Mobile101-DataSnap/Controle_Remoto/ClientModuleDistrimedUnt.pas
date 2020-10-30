unit ClientModuleDistrimedUnt;

interface

uses
  System.SysUtils, System.Classes, ClientClassesDistrimedUnt, IPPeerClient,
  Datasnap.DSClientRest;

type
  TClientModuleDistrimed = class(TDataModule)
    DSRestConnDistrimed: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FsvrMetodosClient: TsvrMetodosClient;
    FDSServerModuleEstoqueClient: TDSServerModuleEstoqueClient;
    function GetsvrMetodosClient: TsvrMetodosClient;
    function GetDSServerModuleEstoqueClient: TDSServerModuleEstoqueClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property svrMetodosClient: TsvrMetodosClient read GetsvrMetodosClient write FsvrMetodosClient;
    property DSServerModuleEstoqueClient: TDSServerModuleEstoqueClient read GetDSServerModuleEstoqueClient write FDSServerModuleEstoqueClient;

end;

var
  ClientModuleDistrimed: TClientModuleDistrimed;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

constructor TClientModuleDistrimed.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TClientModuleDistrimed.Destroy;
begin
  FsvrMetodosClient.Free;
  FDSServerModuleEstoqueClient.Free;
  inherited;
end;

function TClientModuleDistrimed.GetsvrMetodosClient: TsvrMetodosClient;
begin
  if FsvrMetodosClient = nil then
    FsvrMetodosClient:= TsvrMetodosClient.Create(DSRestConnDistrimed, FInstanceOwner);
  Result := FsvrMetodosClient;
end;
function TClientModuleDistrimed.GetDSServerModuleEstoqueClient: TDSServerModuleEstoqueClient;
begin
  if FDSServerModuleEstoqueClient = nil then
    FDSServerModuleEstoqueClient:= TDSServerModuleEstoqueClient.Create(DSRestConnDistrimed, FInstanceOwner);
  Result := FDSServerModuleEstoqueClient;
end;

end.

