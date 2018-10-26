unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json, DataSnap.DSProviderDataModuleAdapter, Datasnap.DSServer,
  Datasnap.DSAuth, Data.FireDACJSONReflect, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin;

type
  TServerMethods1 = class(TDSServerModule)
    SqlClientes: TFDQuery;
    SqlClientesIDCLIENTE: TIntegerField;
    SqlClientesNOME: TStringField;
    SqlTelefones: TFDQuery;
    SqlTelefonesIDTELEFONE: TIntegerField;
    SqlTelefonesIDCLIENTE: TIntegerField;
    SqlTelefonesNUMERO: TStringField;
    FDConnection1: TFDConnection;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
  private
    { Private declarations }
    function GetDataSetClientes(): TFDQuery;
    function GetDataSetTelefones(): TFDQuery;
    function GetId(Value: String): Integer;
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    //
    function GetClientes(): TFDJSONDatasets;
    function GetTelefones(): TFDJSONDatasets;
    function GetClientesTelefones(): TFDJSONDatasets;
    procedure Gravar(const ADeltaList: TFDJSONDeltas);
    //
    function GetClientesJSON(): TJSONArray;
  end;

implementation


{$R *.dfm}


uses System.StrUtils, DataSetConverter4D.Helper;

const
  CLIENTES = 'Clientes';
  TELEFONES = 'Telefones';

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GetClientes: TFDJSONDatasets;
begin
  Result := TFDJSONDatasets.Create();
  TFDJSONDataSetsWriter.ListAdd(Result, CLIENTES, GetDataSetClientes());
end;

function TServerMethods1.GetClientesJSON: TJSONArray;
begin
  result := SqlClientes.ActiveDataSet().AsJSONArray();
end;

function TServerMethods1.GetClientesTelefones: TFDJSONDatasets;
begin
  Result := TFDJSONDatasets.Create();
  TFDJSONDataSetsWriter.ListAdd(Result, CLIENTES, GetDataSetClientes());
  TFDJSONDataSetsWriter.ListAdd(Result, TELEFONES, GetDataSetTelefones());
end;

function TServerMethods1.GetDataSetClientes: TFDQuery;
begin
  SqlClientes.Close();
  Result := SqlClientes;
end;

function TServerMethods1.GetDataSetTelefones: TFDQuery;
begin
  SqlTelefones.Close();
  Result := SqlTelefones;
end;

function TServerMethods1.GetTelefones: TFDJSONDatasets;
begin
  Result := TFDJSONDatasets.Create();
  TFDJSONDataSetsWriter.ListAdd(Result, TELEFONES, GetDataSetTelefones());
end;

procedure TServerMethods1.Gravar(const ADeltaList: TFDJSONDeltas);
var
  LApply: IFDJSONDeltasApplyUpdates;
  MtCli: TFDMemTable;
  MtFone: TFDMemTable;
begin
  inherited;
  LApply := TFDJSONDeltasApplyUpdates.Create(ADeltaList);
//  //LApply.onUpdateRecord := UpdateRecord;
//
//  MtCli := LApply.Values[0];
//  MtFone := LApply.Values[1];
//  MtCli.CachedUpdates := True;
//  MtFone.CachedUpdates := True;
//  MtCli.FilterChanges := [rtInserted];
//  MtFone.FilterChanges := [rtInserted];
//  MtCli.First();
//  while not MtCli.Eof do
//  begin
//    if MtCli.FieldByName('IdCliente').Value < 0 then
//    begin
//      MtFone.Filtered := False;
//      MtFone.Filter := 'IdCliente = ' + MtCli.FieldByName('IdCliente').AsString;
//      MtFone.Filtered := True;
//      MtCli.Edit();
//      MtCli.FieldByName('IdCliente').NewValue := GetId('GEN_IDCLIENTE');
//      MtCli.Post();
//      while not MtFone.Eof do
//      begin
//        if MtFone.FieldByName('IdTelefone').Value < 0 then
//        begin
//          MtFone.Edit();
//          MtFone.FieldByName('IdTelefone').NewValue := GetId('GEN_IDTELEFONE');
//          MtFone.Post();
//        end;
//        if MtFone.FieldByName('IdCliente').Value < 0 then
//        begin
//          MtFone.Edit();
//          MtFone.FieldByName('IdCliente').NewValue := MtCli.FieldByName('IdCliente').Value;
//          MtFone.Post();
//        end;
//        MtFone.Next();
//      end;
//      MtCli.Next();
//    end;
//  end;
//  MtFone.Filtered := False;
//  MtCli.FilterChanges := [rtModified, rtInserted, rtDeleted];
//  MtFone.FilterChanges := [rtModified, rtInserted, rtDeleted];

  FDConnection1.StartTransaction();
  LApply.ApplyUpdates(CLIENTES, SqlClientes.Command);
  if LApply.Errors.Count = 0 then
  begin
    LApply.ApplyUpdates(TELEFONES, SqlTelefones.Command);
  end;
  if LApply.Errors.Count = 0 then
  begin
    FDConnection1.Commit();
  end
  else
  begin
    FDConnection1.Rollback();
    raise Exception.Create(LApply.Errors.Strings.Text);
  end;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TServerMethods1.GetId(Value: String): Integer;
begin
  Result := FDConnection1.ExecSQLScalar('SELECT GEN_ID(' + Value + ',1) FROM RDB$DATABASE');
end;

end.

