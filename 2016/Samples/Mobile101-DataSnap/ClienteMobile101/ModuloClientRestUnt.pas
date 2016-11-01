unit ModuloClientRestUnt;

interface

uses
  System.SysUtils, System.Classes, ClassesClientUnt, Datasnap.DSClientRest;

type
  TModuloClientRest = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FDSServerModuleEstoqueClient: TDSServerModuleEstoqueClient;
    FDSServerClientesClient: TDSServerClientesClient;
    function GetDSServerModuleEstoqueClient: TDSServerModuleEstoqueClient;
    function GetDSServerClientesClient: TDSServerClientesClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property DSServerModuleEstoqueClient: TDSServerModuleEstoqueClient read GetDSServerModuleEstoqueClient write FDSServerModuleEstoqueClient;
    property DSServerClientesClient: TDSServerClientesClient read GetDSServerClientesClient write FDSServerClientesClient;

end;

var
  ModuloClientRest: TModuloClientRest;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

constructor TModuloClientRest.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TModuloClientRest.Destroy;
begin
  FDSServerModuleEstoqueClient.Free;
  FDSServerClientesClient.Free;
  inherited;
end;

function TModuloClientRest.GetDSServerModuleEstoqueClient: TDSServerModuleEstoqueClient;
begin
  if FDSServerModuleEstoqueClient = nil then
    FDSServerModuleEstoqueClient:= TDSServerModuleEstoqueClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FDSServerModuleEstoqueClient;
end;
function TModuloClientRest.GetDSServerClientesClient: TDSServerClientesClient;
begin
  if FDSServerClientesClient = nil then
    FDSServerClientesClient:= TDSServerClientesClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FDSServerClientesClient;
end;

end.
