unit DSServerModuleClientesUnt;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  DBXDBReaders, DBXCommon, DBXJSon,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Data.DBXMSSQL, Data.DB,
  Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.UI, FireDAC.Phys.ODBCBase,
  FireDAC.Comp.DataSet, DATA.FireDacJSONReflect, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin;

type
  TDSServerClientes = class(TDSServerModule)
    sqlConnCliente: TSQLConnection;
    FDConnProtheus11_r7: TFDConnection;
    fdqPedidosCli: TFDQuery;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    fdqAutentCliente: TFDQuery;
    fdqTitulosAB: TFDQuery;
    fdqTitulosNF: TFDQuery;
    fdqAtualizaStatusXMLEnvio: TFDQuery;
    FDCommAtualizaXML: TFDCommand;
    FDUpdateSQL1: TFDUpdateSQL;
  private
    { Private declarations }
  public
    { Public declarations }
{$METHODINFO ON}
    //Modulo Apk Cliente

    // Por FD Reflection
    function GetPedidos(CodCliente : string): TFDJSONDataSets;
    function AutenticaCNPJ(CNPJ : string): TFDJSONDataSets;
    function GetTitulosAb(CodCliente : string): TFDJSONDataSets;
    function GetTitulosNF(CodCliente, NotaFiscal : string): TFDJSONDataSets;
    function AtualizaStatusXMLEnvio(CNPJ, NF, email : string) : Boolean;
{$METHODINFO OFF}
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
uses URotinasGenericas, StrUtils, DateUtils ;

{$R *.dfm}

{ TDSServerClientes }

function TDSServerClientes.AtualizaStatusXMLEnvio(CNPJ, NF,
  email: string): Boolean;
begin
//  fdqAtualizaStatusXMLEnvio.Close;
//  fdqAtualizaStatusXMLEnvio.SQL.Clear;
//  fdqAtualizaStatusXMLEnvio.SQL.Append( 'UPDATE SPED2012.DBO.SPED050 SET ');
//  if email <> EmptyStr then
//    fdqAtualizaStatusXMLEnvio.SQL.Append(Format('EMAIL = %s, ',
//                                          [QuotedStr(LowerCase(email))]));
//
//  fdqAtualizaStatusXMLEnvio.SQL.Append(
//            Format('STATUSMAIL = 1 WHERE DOC_ID = %s AND CNPJDEST = %s',
//                                                [QuotedStr(NF), QuotedStr(CNPJ)]));
//  fdqAtualizaStatusXMLEnvio.ExecSQL;

//  FDCommAtualizaXML.CommandText.Clear;
//  FDCommAtualizaXML.CommandText.Append('UPDATE SPED2012.DBO.SPED050 SET ');
//  if email <> EmptyStr then
//    FDCommAtualizaXML.CommandText.Append(Format('EMAIL = %s, ',
//                                          [QuotedStr(LowerCase(email))]));
//  FDCommAtualizaXML.CommandText.Append(
//          Format('STATUSMAIL = 1 WHERE DOC_ID = %s AND CNPJDEST = %s',
//                                       [QuotedStr(NF), QuotedStr(CNPJ)]));
//  if not FDCommAtualizaXML.Prepared then
//    FDCommAtualizaXML.Prepare();
//
//  FDCommAtualizaXML.OpenOrExecute();


end;

function TDSServerClientes.AutenticaCNPJ(CNPJ: string): TFDJSONDataSets;
begin
  fdqAutentCliente.Close;
  fdqAutentCliente.Params[0].AsString := CNPJ;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, 'CLIENTE', fdqAutentCliente);


//  // Clear active so that query will reexecute.
//  FDQueryDepartmentNames.Active := False;
//  Result := TFDJSONDataSets.Create;
//  // The "TFDJSONDataSetsWriter" class provides static "ListAdd" method.
//  // It uses reflection to convert results of the query into "TFDJSONDataSets".
//  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryDepartmentNames);

end;

function TDSServerClientes.GetPedidos(CodCliente: string): TFDJSONDataSets;
begin
  fdqPedidosCli.Close;
  fdqPedidosCli.Params[0].AsString := CodCliente;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, 'PEDIDOSCLI', fdqPedidosCli);

end;

function TDSServerClientes.GetTitulosAb(CodCliente: string): TFDJSONDataSets;
begin
  fdqTitulosAB.Close;
  fdqTitulosAB.Params[0].AsString := CodCliente;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, 'TITABERTOS', fdqTitulosAB);

end;

function TDSServerClientes.GetTitulosNF(CodCliente,
  NotaFiscal: string): TFDJSONDataSets;
begin
  fdqTitulosNF.Close;
  fdqTitulosNF.Params[0].AsString := CodCliente;
  fdqTitulosNF.Params[1].AsString := NotaFiscal;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, 'TitulosNF', fdqTitulosNF);

end;


end.

