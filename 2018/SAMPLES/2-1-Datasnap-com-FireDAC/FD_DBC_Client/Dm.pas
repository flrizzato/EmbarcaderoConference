unit Dm;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, Data.DBXDataSnap, Data.DBXCommon, IPPeerClient,
  Datasnap.DBClient, Datasnap.DSConnect, Data.FMTBcd;

type
  TDtm = class(TDataModule)
    SQLConnection1: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    CdsClientes: TClientDataSet;
    CdsClientesIDCLIENTE: TIntegerField;
    CdsClientesNOME: TStringField;
    CdsClientesSqlTelefones: TDataSetField;
    CdsTelefones: TClientDataSet;
    CdsTelefonesIDTELEFONE: TIntegerField;
    CdsTelefonesIDCLIENTE: TIntegerField;
    CdsTelefonesNUMERO: TStringField;
    procedure CdsClientesNewRecord(DataSet: TDataSet);
    procedure CdsTelefonesNewRecord(DataSet: TDataSet);
    procedure CdsClientesReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FIdCliente: Integer;
    FIdTelefone: Integer;
  public
    { Public declarations }
    procedure Gravar();
    procedure Cancelar();

    function GetClientes(): String;
    procedure GravarJSON(Value: String);
  end;

var
  Dtm: TDtm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Unit2;

{$R *.dfm}

procedure TDtm.Cancelar;
begin
  CdsClientes.CancelUpdates();
end;

procedure TDtm.CdsClientesNewRecord(DataSet: TDataSet);
begin
  Dec(FIdCliente);
  CdsClientesIDCLIENTE.Value := FIdCliente;
end;

procedure TDtm.CdsClientesReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError;
  UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  raise Exception.Create(E.Message);
end;

procedure TDtm.CdsTelefonesNewRecord(DataSet: TDataSet);
begin
  Dec(FIdTelefone);
  CdsTelefonesIDTELEFONE.Value := FIdTelefone;
end;

function TDtm.GetClientes: String;
var
  Server: TServerMethods1Client;
begin
  SQLConnection1.Open();
  Server := TServerMethods1Client.Create(SQLConnection1.DBXConnection);
  Result := Server.GetClientesJSON.ToJSON;
end;

procedure TDtm.Gravar;
begin
  CdsClientes.ApplyUpdates(0);
end;

procedure TDtm.GravarJSON(Value: String);
var
  Server: TServerMethods1Client;
begin
  SQLConnection1.Open();
  Server := TServerMethods1Client.Create(SQLConnection1.DBXConnection);
  Server.Gravar(Value);
end;

end.
