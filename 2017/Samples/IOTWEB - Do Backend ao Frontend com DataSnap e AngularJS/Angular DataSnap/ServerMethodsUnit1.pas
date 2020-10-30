unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.JSON;

type
  TServerMethods1 = class(TDSServerModule)
    FDQuery1: TFDQuery;
  private
    { Private declarations }
    function DataSetToJSONArray(aDataSet: TDataSet): TJSONArray;
    function GetClientes: TDataSet;
  public
    { Public declarations }
    function updateClientes(Cliente: TJSONObject): TJSONValue;
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function Clientes: TJSONArray;
  end;

implementation


{$R *.dfm}


uses System.StrUtils, ServerContainerUnit1, cliente, Vcl.Dialogs;

function TServerMethods1.updateClientes(Cliente: TJSONObject): TJSONValue;
var
  C: TCliente;
begin
  C := TJson.JsonToObject<TCliente>(Cliente);
  FDQuery1.Open();
  FDQuery1.Insert;
  FDQuery1.FieldByName('nome').AsString := C.nome;
  FDQuery1.FieldByName('email').AsString := C.email;
  FDQuery1.Post;
  result := TJSONString.Create('200 OK');
end;

function TServerMethods1.Clientes: TJSONArray;
begin
  Result := DataSetToJSONArray(GetClientes);
end;

function TServerMethods1.DataSetToJSONArray(aDataSet: TDataSet): TJSONArray;
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

function TServerMethods1.GetClientes: TDataSet;
begin
  FDQuery1.Open;
  Result := FDQuery1;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

