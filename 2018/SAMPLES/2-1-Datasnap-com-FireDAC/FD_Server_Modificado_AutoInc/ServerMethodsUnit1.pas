unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json, DataSnap.DSProviderDataModuleAdapter, DataSnap.DSServer,
  DataSnap.DSAuth, Data.FireDACJSONReflect, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef;

type
  TServerMethods1 = class(TDSServerModule)
    SqlClientes: TFDQuery;
    SqlTelefones: TFDQuery;
    FDConnection1: TFDConnection;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    ComandosClientes: TFDUpdateSQL;
    ComandosTelefones: TFDUpdateSQL;
    SqlClientesIdCliente: TFDAutoIncField;
    SqlClientesNome: TStringField;
    SqlTelefonesIdTelefone: TFDAutoIncField;
    SqlTelefonesIdCliente: TIntegerField;
    SqlTelefonesNumero: TStringField;
  private
    { Private declarations }
    function GetDataSetClientes(): TFDQuery;
    function GetDataSetTelefones(): TFDQuery;
    procedure SetId(DataSet: TDataSet; NomeDoCampo: String; ValorAtual: Integer);
    procedure UpdateRecord(ASender: TDataSet; ARequest: TFDUpdateRequest; var AAction: TFDErrorAction;
      AOptions: TFDUpdateRowOptions);
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GetClientes(): TFDJSONDatasets;
    function GetTelefones(): TFDJSONDatasets;
    function GetClientesTelefones(): TFDJSONDatasets;
    procedure Gravar(const ADeltaList: TFDJSONDeltas);
  end;

implementation

{$R *.dfm}

uses System.StrUtils;

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
begin
  inherited;
  LApply := TFDJSONDeltasApplyUpdates.Create(ADeltaList);
  LApply.onUpdateRecord := UpdateRecord;
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

procedure TServerMethods1.SetId(DataSet: TDataSet; NomeDoCampo: String; ValorAtual: Integer);
begin
  DataSet.Edit();
  DataSet[NomeDoCampo] := TFDJSONDeltasApplyUpdates.ListaID.GetIdNew(NomeDoCampo, ValorAtual);
  DataSet.Post();
end;

procedure TServerMethods1.UpdateRecord(ASender: TDataSet; ARequest: TFDUpdateRequest; var AAction: TFDErrorAction;
  AOptions: TFDUpdateRowOptions);
var
  IdOld: Integer;
  IdNew: Integer;
begin
  if ARequest = arInsert then
  begin
    AAction := eaApplied;
    if ASender.Name = CLIENTES then
    begin
      IdOld := ASender['IdCliente'];
      if IdOld < 0 then
      begin
        ComandosClientes.DataSet := (ASender as TFDAdaptedDataSet);
        try
          ComandosClientes.Apply(ARequest, AAction, AOptions);
        except
          AAction := eaFail;
        end;
        IdNew := ComandosClientes.DataSet.FieldByName('IdCliente').Value;
        TFDJSONDeltasApplyUpdates.ListaID.Add('IdCliente', IdOld, IdNew);
      end;
    end
    else if ASender.Name = TELEFONES then
    begin
      if ASender['IdCliente'] < 0 then
      begin
        SetId(ASender, 'IdCliente', ASender['IdCliente']);
      end;
      ComandosTelefones.DataSet := (ASender as TFDAdaptedDataSet);
      try
        ComandosTelefones.Apply(ARequest, AAction, AOptions);
      except
        AAction := eaFail;
      end;
    end;
  end;
end;

end.
