unit uSM;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
    FireDAC.Stan.StorageJSON,
    FireDAC.Stan.StorageBin,
    Data.FireDACJSONReflect, FireDAC.Stan.Intf, FireDAC.Stan.Option,
    FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
    FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
    FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
    FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
    FireDAC.VCLUI.Wait, FireDAC.Phys.ODBCBase, FireDAC.Comp.UI,Dialogs,
    Datasnap.Provider;

type
{$METHODINFO ON}
  TSM = class(TDataModule)
    qryClientes: TFDQuery;
    FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDStanStorageJSONLink: TFDStanStorageJSONLink;
    FDStanStorageBinLink: TFDStanStorageBinLink;
    FDConn: TFDConnection;
    qryClientesIDCLIENTE: TIntegerField;
    qryClientesNOME: TStringField;
    qryClientesTELEFONE: TStringField;
    qryProdutos: TFDQuery;
    qryProdutosID_PRODUTO: TIntegerField;
    qryProdutosNM_PRODUTO: TStringField;
    qryProdutosVL_PRODUTO: TFloatField;
    qryProdutosDT_INCLUSAO: TBytesField;
    tblPedido: TFDMemTable;
    tblPedidoItem: TFDMemTable;
    qryPedido: TFDQuery;
    qryPedidoItem: TFDQuery;
    stGeraId: TFDStoredProc;
    qrySelectPedido: TFDQuery;
    qrySelectPedidoItem: TFDQuery;
  private
    const
      sClientes = 'TB_CLIENTE';

    function GetId(ATabela,ACampo:string):integer;
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GetClientes: TFDJSONDataSets;
    function GetProdutos: TFDJSONDataSets;

    function SetPedidos(ADataset: TFDJSONDataSets):boolean;


    function GetPedidoAndItem : TFDJSONDataSets;

  end;
{$METHODINFO OFF}

implementation


{$R *.dfm}


uses System.StrUtils;

procedure LogSystem(ALog: WideString);
var
   SL: TStringList;
   Log: string;
begin
   Log := Copy(ExtractFileName(ParamStr(0)), 1, Length(ExtractFileName(ParamStr(0))) - 4) + '.log';

   SL := TStringList.Create;

   if FileExists(Log) then
      SL.LoadFromFile(Log);

   SL.Add(FormatDateTime('yyyy.mm.dd hh:nn:ss:zzz', Now) + ': ' + ALog);

   try
      SL.SaveToFile(Log);
   finally
      FreeAndNil(SL);
   end;

end;


function TSM.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TSM.GetClientes: TFDJSONDataSets;
begin
   qryClientes.Close;
   try
      qryClientes.Open;
   except
      on E: Exception do
      begin
         LogSystem('sql dinamico: ' + E.Message);
      end;
   end;
   Result := TFDJSONDataSets.Create;
   TFDJSONDataSetsWriter.ListAdd(Result, 'TB_CLIENTE', qryClientes);
end;

function TSM.GetId(ATabela, ACampo: string): integer;
begin
    stGeraId.Close;
    stGeraId.Params.ParamByName('@DS_TABELA').AsString := ATabela;
    stGeraId.Params.ParamByName('@DS_CAMPO').AsString  := ACampo;
    stGeraId.ExecProc;

    result := stGeraId.ParamByName('@ID_NEW').AsInteger;
end;

function TSM.GetPedidoAndItem: TFDJSONDataSets;
begin
   qrySelectPedido.Close;
   qrySelectPedidoItem.Close;
   try
      qrySelectPedido.Open;
      qrySelectPedidoItem.Open;
   except
      on E: Exception do
      begin
         LogSystem('sql dinamico: ' + E.Message);
      end;
   end;
   Result := TFDJSONDataSets.Create;
   TFDJSONDataSetsWriter.ListAdd(Result, 'TB_PEDIDO', qrySelectPedido);
   TFDJSONDataSetsWriter.ListAdd(Result, 'TB_PEDIDO_ITEM', qrySelectPedidoItem);
end;

function TSM.GetProdutos: TFDJSONDataSets;
begin
   qryProdutos.Close;
   try
      qryProdutos.Open;
   except
      on E: Exception do
      begin
         LogSystem('qryProdutos: ' + E.Message);
      end;
   end;
   Result := TFDJSONDataSets.Create;
   TFDJSONDataSetsWriter.ListAdd(Result, 'TB_PRODUTO', qryProdutos);
end;

function TSM.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TSM.SetPedidos(ADataset: TFDJSONDataSets): boolean;
var
  i,j     : integer;
  FPedido : integer;
const
  _INSERT_PEDIDO =
      'INSERT INTO TB_PEDIDO( ' +
      'ID_PEDIDO,             ' +
      'ID_CLIENTE,            ' +
      'DT_PEDIDO,             ' +
      'NR_PEDIDO)             ' +
      'VALUES( :ID_PEDIDO,    ' +
      '        :ID_CLIENTE,   ' +
      '        :DT_PEDIDO,    ' +
      '        :NR_PEDIDO)    ' ;

  _INSERT_PEDIDO_ITEM =
      'INSERT INTO TB_PEDIDO_ITEM( ' +
      'ID_PEDIDO_ITEM,             ' +
      'ID_PEDIDO,                  ' +
      'ID_PRODUTO,                 ' +
      'QT_PRODUTO)                 ' +
      'VALUES( :ID_PEDIDO_ITEM,    ' +
      '        :ID_PEDIDO,         ' +
      '        :ID_PRODUTO,        ' +
      '        :QT_PRODUTO)        ' ;

begin
  result := False;
  try
    FDConn.StartTransaction;

    tblPedido.Close;
    tblPedido.AppendData(TFDJSONDataSetsReader.GetListValue(ADataset, 0));

    tblPedidoItem.Close;
    tblPedidoItem.AppendData(TFDJSONDataSetsReader.GetListValue(ADataset, 1));

    tblPedido.First;

    for I := 0 to tblPedido.RecordCount-1 do
    begin
      qryPedido.Close;
      qryPedido.SQL.Clear;
      qryPedido.SQL.Text := _INSERT_PEDIDO;
      FPedido            := GetId('TB_PEDIDO','ID_PEDIDO');
      qryPedido.ParamByName('ID_PEDIDO').AsInteger      := FPedido;
      qryPedido.ParamByName('ID_CLIENTE').AsInteger     := tblPedido.FieldByName('ID_CLIENTE').AsInteger;
      qryPedido.ParamByName('DT_PEDIDO').AsDate         := tblPedido.FieldByName('DT_PEDIDO').AsDateTime;
      qryPedido.ParamByName('NR_PEDIDO').AsString       := tblPedido.FieldByName('NR_PEDIDO').AsString;
      qryPedido.ExecSQL;


      tblPedidoItem.Filtered := False;
      tblPedidoItem.Filter   := 'ID_PEDIDO=' + tblPedido.FieldByName('ID_PEDIDO').AsString;
      tblPedidoItem.Filtered := True;

      tblPedidoItem.First;
      for j := 0 to tblPedidoItem.RecordCount-1 do
      begin
         qryPedidoItem.Close;
         qryPedidoItem.SQL.Clear;
         qryPedidoItem.SQL.Text := _INSERT_PEDIDO_ITEM;
         qryPedidoItem.ParamByName('ID_PEDIDO_ITEM').AsInteger  := GetId('TB_PEDIDO_ITEM','ID_PEDIDO_ITEM');
         qryPedidoItem.ParamByName('ID_PEDIDO').AsInteger       := FPedido;
         qryPedidoItem.ParamByName('ID_PRODUTO').AsInteger      := tblPedidoItem.FieldByName('ID_PRODUTO').AsInteger;
         qryPedidoItem.ParamByName('QT_PRODUTO').AsFloat        := tblPedidoItem.FieldByName('QT_PRODUTO').AsFloat;
         qryPedidoItem.ExecSQL;

         tblPedidoItem.Next;
      end;

      tblPedido.Next;
    end;
    FDConn.Commit;
    result := True;
  except
  On E:Exception do
    begin
     FDConn.Rollback;
     Result := false;
    end;
  end;

end;

end.

