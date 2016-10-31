unit uFrmMobile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, Data.Bind.Components,
  Data.Bind.DBScope, FMX.wwDataGrid, FMX.wwLayouts, FMX.wwBaseGrid,
  FMX.TabControl, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, ksListView,
  FMX.Objects, FMX.Layouts, ksSegmentButtons, FMX.Edit, FMX.wwEdit,
  FMX.wwComboEdit, FMX.wwDateTimePicker, FMX.wwTypes, FMX.wwSearchBox,
  FMX.wwColumnTypes, FMX.wwLookupComboEdit, FireDAC.Comp.Client,
  FGX.ProgressDialog, FGX.ProgressDialog.Types;

type
  TfrmMobile = class(TForm)
    tbPrincipal: TTabControl;
    tbiMenu: TTabItem;
    tbiClientes: TTabItem;
    tbiProdutos: TTabItem;
    tbiPedidos: TTabItem;
    btnClientes: TButton;
    btnProdutos: TButton;
    btnPedidos: TButton;
    btnSinc: TButton;
    layoutImages: TLayout;
    imgHome: TImage;
    imgSearch: TImage;
    imgCalendar: TImage;
    imgMenu: TImage;
    imgContact: TImage;
    imgAbout: TImage;
    Image2: TImage;
    LVClientes: TksListView;
    LVProdutos: TksListView;
    Layout1: TLayout;
    StyleBook1: TStyleBook;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtDtPedido: TwwCalendarEdit;
    BDCliente: TBindSourceDB;
    edtIdCliente: TwwLookupComboEdit;
    wwLookupComboEdit1NOME: TwwGridColumn;
    wwLookupComboEdit1TELEFONE: TwwGridColumn;
    Button5: TButton;
    tbiPedItem: TTabItem;
    edtPedidoItem: TwwEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    BDPedidoItem: TBindSourceDB;
    Button6: TButton;
    edtQtde: TwwEdit;
    Label8: TLabel;
    BDProduto: TBindSourceDB;
    edtNrPedido: TwwEdit;
    edtProduto: TwwLookupComboEdit;
    edtProdutoNM_PRODUTO: TwwGridColumn;
    edtProdutoVL_PRODUTO: TwwGridColumn;
    wwDataGrid1: TwwDataGrid;
    wwDataGrid1ID_PEDIDO_ITEM: TwwGridColumn;
    wwDataGrid1ID_PEDIDO: TwwGridColumn;
    wwDataGrid1QT_PRODUTO: TwwGridColumn;
    wwDataGrid1PRODUTO: TwwGridColumn;
    wwDataGrid1Unbound: TwwGridColumn;
    btnExcluir: TButton;
    Button7: TButton;
    btnVoltar: TButton;
    Button2: TButton;
    Button3: TButton;
    edtPedido: TwwEdit;
    edtIdPedido: TwwEdit;
    fgProgressDialog: TfgProgressDialog;
    Button1: TButton;
    procedure btnClientesClick(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure btnPedidosClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure btnSincClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    procedure AtualizaDadosLocalmente;
    procedure AtualizaClientes(AMemoryTable: TFDMemTable);
    procedure AtualizaProdutos(AMemoryTable: TFDMemTable);
    procedure AtualizaPedidosRemotamente;
  public
    procedure LimpaTela;
  end;

var
  frmMobile: TfrmMobile;

implementation

uses
  Data.FireDACJSONReflect, uCC, uCM, Datasnap.DSClientRest, uDML, Data.DB;

{$R *.fmx}

procedure TfrmMobile.AtualizaClientes(AMemoryTable: TFDMemTable);
var
  FSqlInsertCliente  : string;
  I                  : integer;
begin
  FSqlInsertCliente :=
  'INSERT INTO TB_CLIENTE    ' +
  ' (IDCLIENTE , NOME,       ' +
  '  TELEFONE  , DT_INCLUSAO)' +
  ' VALUES (                 ' +
  ' :IDCLIENTE , :NOME,      ' +
  ' :TELEFONE  , :DT_INCLUSAO) ';

  //Limpa a tabela localmente
  DML.qryDinamico.SQL.Clear;
  DML.qryDinamico.SQL.Text := 'DELETE FROM TB_CLIENTE';
  DML.qryDinamico.ExecSQL;

  DML.qryDinamico.SQL.Clear;
  DML.qryDinamico.SQL.Text := FSqlInsertCliente;

  with AMemoryTable do
  begin
      First;

      for I := 0 to RecordCount-1 do
      begin
          DML.qryDinamico.ParamByName('IDCLIENTE').AsInteger    := AMemoryTable.FieldByName('IDCLIENTE').AsInteger;
          DML.qryDinamico.ParamByName('NOME').AsString          := AMemoryTable.FieldByName('NOME').AsString;
          DML.qryDinamico.ParamByName('TELEFONE').AsString      := AMemoryTable.FieldByName('TELEFONE').AsString;
          DML.qryDinamico.ParamByName('DT_INCLUSAO').AsDateTime := Date;
          DML.qryDinamico.ExecSQL;

          Next;
      end;
  end;
end;

procedure TfrmMobile.AtualizaDadosLocalmente;
begin
end;

procedure TfrmMobile.AtualizaPedidosRemotamente;
var
  FDataSets :  TFDJSONDataSets;
begin
   DML.fdQryPedido.Close;
   DML.fdQryPedido.Open;

   DML.fdQryPedidoItem.Close;
   DML.fdQryPedidoItem.Open;

   FDataSets := TFDJSONDataSets.Create;
   TFDJSONDataSetsWriter.ListAdd(FDataSets, 'TB_PEDIDO',     DML.fdQryPedido);
   TFDJSONDataSetsWriter.ListAdd(FDataSets, 'TB_PEDIDOITEM', DML.fdQryPedidoItem);

   if CM.SMClient.SetPedidos(FDataSets) then
   begin
      DML.qryDinamico.SQL.Clear;
      DML.qryDinamico.SQL.Text := 'DELETE FROM TB_PEDIDO';
      DML.qryDinamico.ExecSQL;

      DML.qryDinamico.SQL.Clear;
      DML.qryDinamico.SQL.Text := 'DELETE FROM TB_PEDIDO_ITEM';
      DML.qryDinamico.ExecSQL;
   end;
end;

procedure TfrmMobile.AtualizaProdutos(AMemoryTable: TFDMemTable);
var
  FSqlInsertProduto  : string;
  I                  : integer;
begin
  FSqlInsertProduto :=
  'INSERT INTO TB_PRODUTO     ' +
  ' (ID_PRODUTO , NM_PRODUTO,  ' +
  '  VL_PRODUTO  , DT_INCLUSAO)' +
  ' VALUES (                   ' +
  ' :ID_PRODUTO , :NM_PRODUTO, ' +
  ' :VL_PRODUTO  , :DT_INCLUSAO) ';

  //Limpa a tabela localmente
  DML.qryDinamico.SQL.Clear;
  DML.qryDinamico.SQL.Text := 'DELETE FROM TB_PRODUTO';
  DML.qryDinamico.ExecSQL;

  DML.qryDinamico.SQL.Clear;
  DML.qryDinamico.SQL.Text := FSqlInsertProduto;

  with AMemoryTable do
  begin
      First;

      for I := 0 to RecordCount-1 do
      begin
          DML.qryDinamico.ParamByName('ID_PRODUTO').AsInteger     := AMemoryTable.FieldByName('ID_PRODUTO').AsInteger;
          DML.qryDinamico.ParamByName('NM_PRODUTO').AsString      := AMemoryTable.FieldByName('NM_PRODUTO').AsString;
          DML.qryDinamico.ParamByName('VL_PRODUTO').AsFloat       := AMemoryTable.FieldByName('VL_PRODUTO').AsFloat;
          DML.qryDinamico.ParamByName('DT_INCLUSAO').AsDateTime := Date;
          DML.qryDinamico.ExecSQL;

          Next;
      end;
  end;
end;

procedure TfrmMobile.btnExcluirClick(Sender: TObject);
begin
  DML.fdQryPedidoItem.Delete;
end;

procedure TfrmMobile.btnClientesClick(Sender: TObject);
var
  ICount: integer;
  ARow: TKsListItemRow;
begin
  if LVClientes.Items.Count > 0 then
  begin
    LVClientes.ClearItems;
  end;


  DML.fdQryCliente.Close;
  DML.fdQryCliente.Open;

  DML.fdQryCliente.First;

  LVClientes.BeginUpdate;
  try
    for ICount := 0 to DML.fdQryCliente.RecordCount-1 do
    begin
      ARow := LVClientes.Items.AddRow('Cliente '+ DML.fdQryClienteNOME.AsString,
                                 'Telefone '+ DML.fdQryClienteTELEFONE.AsString,
                                 'Incluído em ' +  DML.fdQryClienteDT_INCLUSAO.AsString,
                                 atNone,
                                 Image2.Bitmap);



      // set image to circle shape
      ARow.Image.ImageShape := ksCircleImage;

      DML.fdQryCliente.Next;
    end;
  finally
    LVClientes.EndUpdate;
  end;

  tbPrincipal.ActiveTab := tbiClientes;
end;

procedure TfrmMobile.btnProdutosClick(Sender: TObject);
var
  ICount: integer;
  ARow: TKsListItemRow;
begin
  if LVProdutos.Items.Count > 0 then
  begin
    tbPrincipal.ActiveTab := tbiProdutos;
    Exit;
  end;

  DML.fdQryProduto.Close;
  DML.fdQryProduto.Open;
  DML.fdQryProduto.First;

  LVProdutos.BeginUpdate;
  try
    for ICount := 0 to DML.fdQryProduto.RecordCount-1 do
    begin
      ARow := LVProdutos.Items.AddRow('Produto '  +  DML.fdQryProdutoNM_PRODUTO.AsString,
                                 'Preço R$'       +  FormatFloat('0.00' , DML.fdQryProdutoVL_PRODUTO.AsFloat),
                                 'Incluído em '   +  DML.fdQryProdutoDT_INCLUSAO.AsString,
                                 atNone,
                                 imgContact.Bitmap);



      ARow.Image.ImageShape := ksCircleImage;

      DML.fdQryProduto.Next;
    end;
  finally
    LVProdutos.EndUpdate;
  end;

  tbPrincipal.ActiveTab := tbiProdutos;
end;

procedure TfrmMobile.btnPedidosClick(Sender: TObject);
begin
  btnClientesClick(Sender);
  btnProdutosClick(Sender);
  tbPrincipal.ActiveTab := tbiPedidos;
  edtIdPedido.Text      := '<INCLUSÃO>';
end;

procedure TfrmMobile.btnSincClick(Sender: TObject);
var
  LDataSetClientes : TFDJSONDataSets;
  LDataSetProdutos : TFDJSONDataSets;

procedure FillClientes(const ADataSetList: TFDJSONDataSets);
begin
  CM.tblCliente.Close;
  CM.tblCliente.AppendData(TFDJSONDataSetsReader.GetListValue(ADataSetList, 0));
end;

procedure FillProdutos(const ADataSetList: TFDJSONDataSets);
begin
  CM.tblProdutos.Close;
  CM.tblProdutos.AppendData(TFDJSONDataSetsReader.GetListValue(ADataSetList, 0));
end;

begin

  fgProgressDialog.ResetProgress;
  fgProgressDialog.Show;
  try

    try
      fgProgressDialog.Message := 'Iniciando processo';
      fgProgressDialog.Kind := TfgProgressDialogKind.Undeterminated;
      Sleep(1000);

      fgProgressDialog.Kind := TfgProgressDialogKind.Determinated;
      Sleep(1000);

      fgProgressDialog.Message := 'Iniciando transação';
      fgProgressDialog.Progress := 10;
      Sleep(1000);

      DML.FDLocal.StartTransaction;

      fgProgressDialog.Message := 'Carregando informações';
      fgProgressDialog.Progress := 20;
      Sleep(1000);


      LDataSetClientes := CM.SMClient.GetClientes;
      LDataSetProdutos := CM.SMClient.GetProdutos;

      fgProgressDialog.Message := 'Carregando em memória...';
      fgProgressDialog.Progress := 60;
      Sleep(1000);

      FillClientes(LDataSetClientes);
      FillProdutos(LDataSetProdutos);

      fgProgressDialog.Message := 'Gravando localmente...';
      fgProgressDialog.Progress := 90;
      Sleep(500);

      AtualizaClientes(CM.tblCliente);
      AtualizaProdutos(CM.tblProdutos);
      AtualizaPedidosRemotamente;

      fgProgressDialog.Progress := 100;
      Sleep(500);

      DML.FDLocal.Commit;

    except
      On E:Exception do
      begin
        DML.FDLocal.Rollback;
      end;
    end;
  finally
    fgProgressDialog.Hide;
  end;

end;

procedure TfrmMobile.btnVoltarClick(Sender: TObject);
begin
 tbPrincipal.ActiveTab := tbiMenu;
end;

procedure TfrmMobile.Button5Click(Sender: TObject);
begin
  with DML do
  begin
    if not fdQryPedido.Active then
      fdQryPedido.Open();

    fdQryPedido.Append;
    fdQryPedidoID_PEDIDO.AsInteger  := DML.GetNexPedidoId;
    fdQryPedidoID_CLIENTE.AsInteger := strToInt(edtIdCliente.LookupValue);
    fdQryPedidoDT_PEDIDO.AsDateTime := edtDtPedido.Date;
    fdQryPedidoNR_PEDIDO.AsString   := edtNrPedido.Text;
    fdQryPedidoST_PEDIDO.AsString   := 'N';
    fdQryPedido.Post;


    tbPrincipal.ActiveTab := tbiPedItem;
  end;
end;

procedure TfrmMobile.Button6Click(Sender: TObject);
begin
  with DML do
  begin
    if not fdQryPedidoItem.Active then
      fdQryPedidoItem.Open();

    fdQryPedidoItem.Append;
    fdQryPedidoItemID_PEDIDO_ITEM.AsInteger  := DML.GetNexPedidoItemId;
    fdQryPedidoItemID_PEDIDO.AsInteger       := DML.fdQryPedidoID_PEDIDO.AsInteger;
    fdQryPedidoItemID_PRODUTO.AsInteger      := strToInt(edtProduto.LookupValue);
    fdQryPedidoItemQT_PRODUTO.AsFloat        := StrToFloat(edtQtde.Text);
    fdQryPedidoItem.Post;

    edtProduto.LookupValue := '';
    edtQtde.Text           := '1';
  end;
end;

procedure TfrmMobile.Button7Click(Sender: TObject);
begin
   if DML.fdQryPedidoItem.State in [dsEdit,dsInsert] then
      DML.fdQryPedidoItem.Open();

    ShowMessage('Pedido gerado com sucesso !!!!');
    LimpaTela;
    tbPrincipal.ActiveTab := tbiMenu;
end;

procedure TfrmMobile.LimpaTela;
begin
  edtNrPedido.Text   := EmptyStr;
  edtPedidoItem.Text := EmptyStr;
  edtNrPedido.Text   := EmptyStr;
end;

end.
