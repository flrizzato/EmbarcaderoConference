unit Unit3;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.StorageJSON, FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait,
  FireDAC.Phys.ODBCBase, FireDAC.ConsoleUI.Wait;

type

  [ResourceName('FD2014')]
  TFDResource1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    qrPessoa: TFDQuery;
    spPessoaINSERT: TFDStoredProc;
    qrPessoaCodigo: TIntegerField;
    qrPessoaNome: TStringField;
    qrPessoaByID: TFDQuery;
    qrPessoaByIDCodigo: TFDAutoIncField;
    qrPessoaByIDNome: TStringField;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
  published
    procedure Get(const AContext: TEndpointContext;
      const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure GetItem(const AContext: TEndpointContext;
      const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    procedure Post(const AContext: TEndpointContext;
      const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

procedure Register;

implementation

{ %CLASSGROUP 'System.Classes.TPersistent' }

uses Negocio, REST.JSON;

{$R *.dfm}

procedure TFDResource1.Get(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  jClientes: TJSONArray;
begin
  jClientes := TJSONArray.Create;
  qrPessoa.Close;
  qrPessoa.Open;
  while not qrPessoa.Eof do
  begin
    jClientes.AddElement(TJson.ObjectToJsonObject
      (TCliente.Create(qrPessoaCodigo.AsInteger, qrPessoaNome.AsString)));
    qrPessoa.Next;
  end;
  AResponse.Body.SetValue(jClientes, True);
end;

procedure TFDResource1.GetItem(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
  jClientes: TJSONArray;
begin
  LItem := ARequest.Params.Values['item'];
  jClientes := TJSONArray.Create;
  qrPessoaByID.Close;
  qrPessoaByID.ParamByName('CODIGO').AsInteger := StrToIntDef(LItem, -1);
  qrPessoaByID.Open;
  while not qrPessoaByID.Eof do
  begin
    jClientes.AddElement(TJson.ObjectToJsonObject
      (TCliente.Create(qrPessoaByIDCodigo.AsInteger, qrPessoaByIDNome.AsString)));
    qrPessoaByID.Next;
  end;
  AResponse.Body.SetValue(jClientes, True);
end;

procedure TFDResource1.Post(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LJSON: TJSONObject;
  codigo: Integer;
  nome: string;
begin
  if ARequest.Body.TryGetObject(LJSON) then
  begin
    nome := LJSON.Values['nome'].Value;
    spPessoaINSERT.ParamByName('@Nome').AsString := nome;
    spPessoaINSERT.ExecProc;
    codigo := spPessoaINSERT.ParamByName('@RETURN_VALUE').AsInteger;
    AResponse.Body.SetValue(TJSONNumber.Create(codigo), True);
  end
  else
  begin
    AResponse.RaiseBadRequest('JSON expected');
  end;
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TFDResource1));
end;

end.
