unit uCM;

interface

uses
  System.SysUtils, System.Classes, uCC, IPPeerClient,
  Datasnap.DSClientRest, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, Datasnap.DBClient,
  Datasnap.DSConnect;

type
  TCM = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    tblCliente: TFDMemTable;
    tblProdutos: TFDMemTable;
  private
    FInstanceOwner: Boolean;
    FSMClient: TSMClient;
    function GetSMClient: TSMClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property SMClient: TSMClient read GetSMClient write FSMClient;

end;

var
  CM: TCM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

constructor TCM.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TCM.Destroy;
begin
  FSMClient.Free;
  inherited;
end;

function TCM.GetSMClient: TSMClient;
begin
  if FSMClient = nil then
    FSMClient:= TSMClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FSMClient;
end;

end.
