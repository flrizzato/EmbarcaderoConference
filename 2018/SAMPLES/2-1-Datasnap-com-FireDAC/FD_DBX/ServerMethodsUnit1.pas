unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
  DataSnap.DSProviderDataModuleAdapter,
  DataSnap.DSServer, DataSnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, DataSnap.Provider, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DataSnap.DBClient;

type
  TServerMethods1 = class(TDSServerModule)
    FDConnection1: TFDConnection;
    SqlClientes: TFDQuery;
    SqlTelefones: TFDQuery;
    DataSource1: TDataSource;
    SqlClientesIDCLIENTE: TIntegerField;
    SqlClientesNOME: TStringField;
    SqlTelefonesIDTELEFONE: TIntegerField;
    SqlTelefonesIDCLIENTE: TIntegerField;
    SqlTelefonesNUMERO: TStringField;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1IDCLIENTE: TIntegerField;
    ClientDataSet1NOME: TStringField;
    ClientDataSet1SqlTelefones: TDataSetField;
    procedure DataSetProvider1BeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure ClientDataSet1ReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError;
      UpdateKind: TUpdateKind; var Action: TReconcileAction);
    procedure DataSetProvider1GetTableName(Sender: TObject; DataSet: TDataSet; var TableName: string);
  private
    { Private declarations }
    FIdCliente: Integer;
    function GetId(Value: String): Integer;
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GetClientes(): String;
    function GetClientesJSON(): TJSONArray;
    procedure Gravar(Value: String);
  end;

implementation

{$R *.dfm}

uses System.StrUtils, DataSetConverter4D.Helper, Vcl.Dialogs;

procedure TServerMethods1.ClientDataSet1ReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError;
  UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  raise Exception.Create(e.Message);
end;

procedure TServerMethods1.DataSetProvider1BeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
  DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  if UpdateKind = ukInsert then
  begin
    if SourceDS = SqlClientes then
    begin
      if DeltaDS.FieldByName('IdCliente').Value < 0 then
      begin
        FIdCliente := GetId('GEN_IDCLIENTE');
        DeltaDS.FieldByName('IdCliente').NewValue := FIdCliente;
      end;
    end
    else if SourceDS = SqlTelefones then
    begin
      if DeltaDS.FieldByName('IdTelefone').Value < 0 then
      begin
        DeltaDS.FieldByName('IdTelefone').NewValue := GetId('GEN_IDTELEFONE');
      end;
      if DeltaDS.FieldByName('IdCliente').Value < 0 then
      begin
        DeltaDS.FieldByName('IdCliente').NewValue := FIdCliente;
      end;
    end;
  end;
end;

procedure TServerMethods1.DataSetProvider1GetTableName(Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
  if DataSet = SqlTelefones then
  begin
    TableName := 'TELEFONES';
  end;
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GetClientes: String;
begin
  result := GetClientesJSON.ToJSON;
end;

function TServerMethods1.GetClientesJSON: TJSONArray;
begin
  ClientDataSet1.Close();
  result := ClientDataSet1.ActiveDataSet.AsJSONArray;
end;

function TServerMethods1.GetId(Value: String): Integer;
begin
  Result := FDConnection1.ExecSQLScalar('SELECT GEN_ID(' + Value + ',1) FROM RDB$DATABASE');
end;

procedure TServerMethods1.Gravar(Value: String);
var
  Ja: TJSONArray;
begin
  Ja := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Value), 0) as TJSONArray;
  ClientDataSet1.ActiveDataSet.FromJSONArray(Ja);
  ClientDataSet1.ApplyUpdates(0);
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.
