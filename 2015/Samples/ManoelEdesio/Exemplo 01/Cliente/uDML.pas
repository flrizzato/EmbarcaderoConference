unit uDML;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, System.IOUtils;

type
  TDML = class(TDataModule)
    FDLocal: TFDConnection;
    fdQryCliente: TFDQuery;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    fdQryProduto: TFDQuery;
    fdQryPedido: TFDQuery;
    fdQryPedidoItem: TFDQuery;
    fdQryClienteIDCLIENTE: TIntegerField;
    fdQryClienteNOME: TWideStringField;
    fdQryClienteTELEFONE: TWideStringField;
    fdQryClienteDT_INCLUSAO: TSQLTimeStampField;
    fdQryProdutoID_PRODUTO: TIntegerField;
    fdQryProdutoNM_PRODUTO: TWideStringField;
    fdQryProdutoVL_PRODUTO: TFloatField;
    fdQryProdutoDT_INCLUSAO: TSQLTimeStampField;
    fdQryPedidoID_PEDIDO: TIntegerField;
    fdQryPedidoID_CLIENTE: TIntegerField;
    fdQryPedidoDT_PEDIDO: TSQLTimeStampField;
    fdQryPedidoNR_PEDIDO: TWideStringField;
    fdQryPedidoST_PEDIDO: TStringField;
    fdQryPedidoItemID_PEDIDO_ITEM: TIntegerField;
    fdQryPedidoItemID_PEDIDO: TIntegerField;
    fdQryPedidoItemID_PRODUTO: TIntegerField;
    fdQryPedidoItemQT_PRODUTO: TIntegerField;
    qryDinamico: TFDQuery;
    fdQryPedidoItemPRODUTO: TStringField;
    qryDinamico2: TFDQuery;
    dsPedido: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
        FIdPed     : integer;
        FIdPedItem : integer;
  public
    function GetNexPedidoId:integer;
    function GetNexPedidoItemId:integer;

  end;

var
  DML: TDML;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDML.DataModuleCreate(Sender: TObject);
var
  sPath: String;
begin
  with FDLocal do
  begin
    {$IF DEFINED(IOS) OR DEFINED(ANDROID)}
      Params.Values['DriverID'] := 'SQLite';
      Params.Values['OpenMode'] := 'ReadWrite';
      try
        FDLocal.Params.Values['Database'] :=  TPath.Combine(TPath.GetDocumentsPath, 'DCExemplo.s3db');
        Connected := True;
      except on E: Exception do
        begin
        end;
      end;
    {$ENDIF}
  end;

  FIdPed      := 0;
  FIdPedItem  := 0;
end;

function TDML.GetNexPedidoId: integer;
begin
  with qryDinamico2 do
  begin
    Close;
    Sql.Clear;
    SQL.Text := 'SELECT MIN(ID_PEDIDO)-1 FROM TB_PEDIDO';
    open;
    if not qryDinamico2.Fields[0].IsNull then
       FIdPed := Fields[0].AsInteger
    else
      FIdPed := FIdPed - 1;

    result := FIdPed;
  end;
end;

function TDML.GetNexPedidoItemId: integer;
begin
  with qryDinamico2 do
  begin
    Close;
    Sql.Clear;
    SQL.Text := 'SELECT MIN(ID_PEDIDO_ITEM)-1 FROM TB_PEDIDO_ITEM';
    open;

    if not qryDinamico2.Fields[0].IsNull then
       FIdPedItem := Fields[0].AsInteger
    else
      FIdPedItem := FIdPedItem - 1;

    result := FIdPedItem;
  end;
end;

end.
