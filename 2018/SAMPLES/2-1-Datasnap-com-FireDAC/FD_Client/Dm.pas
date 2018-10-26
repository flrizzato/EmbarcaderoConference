unit Dm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.FireDACJSONReflect, FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin;

type
  TDtm = class(TDataModule)
    MtClientes: TFDMemTable;
    MtTelefones: TFDMemTable;
    MtClientesIDCLIENTE: TIntegerField;
    MtClientesNOME: TStringField;
    MtTelefonesIDTELEFONE: TIntegerField;
    MtTelefonesIDCLIENTE: TIntegerField;
    MtTelefonesNUMERO: TStringField;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    DataSource1: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetClientes();
    procedure GetTelefones();
    procedure GetClientesTelefones();
    procedure Gravar();
    procedure Cancelar();
  end;

var
  Dtm: TDtm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses ClientModuleUnit1;

{$R *.dfm}

{ TDtm }

procedure TDtm.Cancelar;
begin
  MtClientes.CancelUpdates();
  MtTelefones.CancelUpdates();
end;

procedure TDtm.GetClientes;
var
  ADataSets: TFDJSONDatasets;
begin
  ADataSets := ClientModule1.ServerMethods1Client.GetClientes();
  MtClientes.Close();
  MtClientes.AppendData(TFDJSONDataSetsReader.GetListValueByName(ADataSets,'Clientes'));
end;

procedure TDtm.GetClientesTelefones;
var
  ADataSets: TFDJSONDatasets;
begin
  ADataSets := ClientModule1.ServerMethods1Client.GetClientesTelefones();
  MtClientes.Close();
  MtTelefones.Close();
  MtClientes.AppendData(TFDJSONDataSetsReader.GetListValueByName(ADataSets,'Clientes'));
  MtTelefones.AppendData(TFDJSONDataSetsReader.GetListValueByName(ADataSets,'Telefones'));
end;

procedure TDtm.GetTelefones;
var
  ADataSets: TFDJSONDatasets;
begin
  ADataSets := ClientModule1.ServerMethods1Client.GetTelefones();
  MtTelefones.Close();
  MtTelefones.AppendData(TFDJSONDataSetsReader.GetListValueByName(ADataSets,'Telefones'));
end;

procedure TDtm.Gravar;
var
  LDeltaList: TFDJSONDeltas;
begin
  if MtClientes.State in dsEditModes then
  begin
    MtClientes.Post();
  end;
  if MtTelefones.State in dsEditModes then
  begin
    MtTelefones.Post();
  end;
  LDeltaList := TFDJSONDeltas.Create();
  TFDJSONDeltasWriter.ListAdd(LDeltaList, 'Clientes', MtClientes);
  TFDJSONDeltasWriter.ListAdd(LDeltaList, 'Telefones', MtTelefones);
  ClientModule1.ServerMethods1Client.Gravar(LDeltaList);
end;

end.
