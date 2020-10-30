unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
  DataSnap.DSProviderDataModuleAdapter,
  DataSnap.DSServer, DataSnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, ClienteUnit;

type
  TServerMethods1 = class(TDSServerModule)
    ExtremeDelphi: TFDConnection;
    spClientesDELETE: TFDStoredProc;
    spClientesINSERT: TFDStoredProc;
    spClientesSELECT: TFDStoredProc;
    spClientesUPDATE: TFDStoredProc;
  private
    function DataSetToJSON(ADataSet: TDataSet): TJSONArray;
    function LerClientes: TDataSet;
    procedure acceptCliente(ACliente: TCliente);
    procedure updateCliente(ACliente: TCliente);
    procedure cancelCliente(ACodigo: Integer);
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GetImage(Index: Integer): TStream;
    function LerClientesJSON: TJSONArray;
    function updateClientes(ACliente: TJSONArray): Boolean;
  end;

implementation

{$R *.dfm}

uses System.StrUtils, REST.Json;

procedure TServerMethods1.acceptCliente(ACliente: TCliente);
begin
  spClientesINSERT.ParamByName('@Nome').AsString := ACliente.Nome;
  spClientesINSERT.ParamByName('@Salario').Value := ACliente.Salario;
  spClientesINSERT.ExecProc;
end;

procedure TServerMethods1.cancelCliente(ACodigo: Integer);
begin
  spClientesDELETE.ParamByName('@Codigo').AsInteger := ACodigo;
  spClientesDELETE.ExecProc;
end;

function TServerMethods1.DataSetToJSON(ADataSet: TDataSet): TJSONArray;
var
  objRegistro: TJSONObject;
  i: Integer;
begin
  ADataSet.First;
  Result := TJSONArray.Create;
  while not ADataSet.Eof do
  begin
    objRegistro := TJSONObject.Create;
    for i := 0 to ADataSet.FieldCount - 1 do
    begin
      objRegistro.AddPair(ADataSet.Fields[i].FieldName,
        ADataSet.Fields[i].AsString);
    end;
    Result.AddElement(objRegistro);
    ADataSet.Next;
  end;
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GetImage(Index: Integer): TStream;
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  case Index of
    0:
      ms.LoadFromFile('images\mike0.jpg');
    1:
      ms.LoadFromFile('images\mike1.jpg');
  end;
  Result := ms;
end;

function TServerMethods1.LerClientes: TDataSet;
begin
  spClientesSELECT.Close;
  spClientesSELECT.Open;
  Result := spClientesSELECT;
end;

function TServerMethods1.LerClientesJSON: TJSONArray;
begin
  Result := DataSetToJSON(LerClientes);
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

procedure TServerMethods1.updateCliente(ACliente: TCliente);
begin
  spClientesUPDATE.ParamByName('@Codigo').AsInteger := ACliente.Codigo;
  spClientesUPDATE.ParamByName('@Nome').AsString := ACliente.Nome;
  spClientesUPDATE.ParamByName('@Salario').Value := ACliente.Salario;
  spClientesUPDATE.ExecProc;
end;

function TServerMethods1.updateClientes(ACliente: TJSONArray): Boolean;
var
  clienteJSON: TJSONValue;
  cliente: TCliente;
begin
  for clienteJSON in ACliente do
  begin
    cliente := TJson.JsonToObject<TCliente>(clienteJSON as TJSONObject);
    try
      if cliente.Situacao = 'I' then
      begin
        acceptCliente(cliente);
      end
      else if cliente.Situacao = 'U' then
      begin
        updateCliente(cliente);
      end
      else if cliente.Situacao = 'D' then
      begin
        cancelCliente(cliente.Codigo);
      end
    finally
      cliente.Free;
    end;
  end;
  Result := True;
end;

end.
