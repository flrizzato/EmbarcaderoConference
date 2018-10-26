unit ClientModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, ClientClassesUnit1, Datasnap.DSClientRest;

type
  TClientModule1 = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FSrvMetodosClient: TSrvMetodosClient;
    function GetSrvMetodosClient: TSrvMetodosClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property SrvMetodosClient: TSrvMetodosClient read GetSrvMetodosClient write FSrvMetodosClient;

end;

var
  ClientModule1: TClientModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

constructor TClientModule1.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TClientModule1.Destroy;
begin
  FSrvMetodosClient.Free;
  inherited;
end;

function TClientModule1.GetSrvMetodosClient: TSrvMetodosClient;
begin
  if FSrvMetodosClient = nil then
    FSrvMetodosClient:= TSrvMetodosClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FSrvMetodosClient;
end;

end.
