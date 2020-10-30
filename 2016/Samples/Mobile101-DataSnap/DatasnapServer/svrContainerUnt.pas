unit svrContainerUnt;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSClientMetadata, Datasnap.DSHTTPServiceProxyDispatcher,
  Datasnap.DSProxyJavaAndroid, Datasnap.DSProxyJavaBlackBerry,
  Datasnap.DSProxyObjectiveCiOS, Datasnap.DSProxyCsharpSilverlight,
  Datasnap.DSProxyFreePascal_iOS,
  Datasnap.DSAuth;

type
  TsvrContainer = class(TDataModule)
    DSServer1: TDSServer;
    DSServerClass2: TDSServerClass;
    DSServerClassCliente: TDSServerClass;
    procedure DSServerClass2GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSServerClassClienteGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

function DSServer: TDSServer;

implementation

uses Winapi.Windows, svrSMEstoqueUnt, DSServerModuleClientesUnt;

{$R *.dfm}

var
  FModule: TComponent;
  FDSServer: TDSServer;

function DSServer: TDSServer;
begin
  Result := FDSServer;
end;

constructor TsvrContainer.Create(AOwner: TComponent);
begin
  inherited;
  FDSServer := DSServer1;
end;

destructor TsvrContainer.Destroy;
begin
  inherited;
  FDSServer := nil;
end;

procedure TsvrContainer.DSServerClass2GetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := svrSMEstoqueUnt.TDSServerModuleEstoque;
end;

procedure TsvrContainer.DSServerClassClienteGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := DSServerModuleClientesUnt.TDSServerClientes;
end;

initialization
  FModule := TsvrContainer.Create(nil);
finalization
  FModule.Free;
end.

