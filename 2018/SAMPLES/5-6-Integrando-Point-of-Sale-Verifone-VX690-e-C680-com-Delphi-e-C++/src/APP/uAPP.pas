unit uAPP;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Edit,
  FMX.EditBox,
  FMX.NumberBox,
  System.Rtti,
  FMX.Grid.Style,
  FMX.ScrollBox,
  FMX.Grid,
  FMX.SpinBox,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.Bind.EngExt,
  FMX.Bind.DBEngExt,
  FMX.Bind.Grid,
  System.Bindings.Outputs,
  FMX.Bind.Editors,
  Data.Bind.Components,
  Data.Bind.Grid,
  Data.Bind.DBScope,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  System.ImageList,
  FMX.ImgList,
  FMX.Objects,
  FMX.Effects,
  Rest.Json,
  Rest.Client,
  Rest.Types,
  System.uJson,
  Data.DB.Helper,
  IPPeerClient,
  Data.Bind.ObjectScope;

type
  TForm1 = class(TForm)
    sbxAPP: TScrollBox;
    lytAPP: TLayout;
    gbxProdutos: TGroupBox;
    grbFormas: TGroupBox;
    edtCodigo: TNumberBox;
    edtDescricao: TEdit;
    edtQtd: TSpinBox;
    edtTotal: TNumberBox;
    grdItens: TGrid;
    tblItens: TFDMemTable;
    tblItenscodigo: TIntegerField;
    tblItensdescricao: TStringField;
    tblItensqtd: TIntegerField;
    tblItensunitario: TFloatField;
    tblItenstotal: TFloatField;
    lytTotais: TLayout;
    lblValorTotal: TLabel;
    tblProdutos: TFDMemTable;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    FloatField1: TFloatField;
    edtValorTotalItem: TNumberBox;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    rctMensagens: TRectangle;
    lblMensagens: TLabel;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    btnpagar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtQtdChange(Sender: TObject);
    procedure edtQtdKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnpagarClick(Sender: TObject);
  private
    nTotal: Extended;

    { Private declarations }
    procedure carregaprod();
    function pesquisaprod(): Boolean;
    procedure AdicionaItem();
    procedure limpa();
    function ItensParaJson(): string;
    procedure mensagem(mensagem: string);
    procedure EnviaParaOServidor(Json: string; forma: string; valor: Extended);

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.AdicionaItem;
begin

  if not tblItens.Active then
    tblItens.CreateDataSet;

  tblItens.Insert;
  tblItens.FieldByName('codigo').AsInteger := tblProdutos.FieldByName('codigo').AsInteger;
  tblItens.FieldByName('descricao').asString := tblProdutos.FieldByName('descricao').asString;
  tblItens.FieldByName('unitario').AsFloat := tblProdutos.FieldByName('unitario').AsFloat;
  tblItens.FieldByName('total').AsFloat := edtQtd.Value * tblProdutos.FieldByName('unitario').AsFloat;
  tblItens.FieldByName('qtd').AsInteger := trunc(edtQtd.Value);

  tblItens.Post;

  nTotal := nTotal + edtQtd.Value * tblProdutos.FieldByName('unitario').AsFloat;

  lblValorTotal.Text := FormatFloat('###0,.00', nTotal);

end;

procedure TForm1.btnpagarClick(Sender: TObject);
begin
  mensagem('Enviando pedido, aguarde...');
  EnviaParaOServidor(ItensParaJson(), 'CCR', nTotal);
  tblItens.EmptyDataSet;
  nTotal := 0;
  ShowMessage('Pedido enviado!');
  limpa();

end;

procedure TForm1.carregaprod;
begin
  tblProdutos.CreateDataSet;
  tblProdutos.Insert;
  tblProdutos.FieldByName('codigo').AsInteger := 1;
  tblProdutos.FieldByName('descricao').asString := 'ARROZ';
  tblProdutos.FieldByName('unitario').AsFloat := 2.10;
  tblProdutos.Post;

  tblProdutos.Insert;
  tblProdutos.FieldByName('codigo').AsInteger := 2;
  tblProdutos.FieldByName('descricao').asString := 'FEIJAO';
  tblProdutos.FieldByName('unitario').AsFloat := 1.99;
  tblProdutos.Post;

  tblProdutos.Insert;
  tblProdutos.FieldByName('codigo').AsInteger := 3;
  tblProdutos.FieldByName('descricao').asString := 'CARNE PATINHO';
  tblProdutos.FieldByName('unitario').AsFloat := 24.50;
  tblProdutos.Post;

  tblProdutos.Insert;
  tblProdutos.FieldByName('codigo').AsInteger := 4;
  tblProdutos.FieldByName('descricao').asString := 'CARNE COLCHAO MOLE';
  tblProdutos.FieldByName('unitario').AsFloat := 44.50;
  tblProdutos.Post;
end;

procedure TForm1.edtCodigoExit(Sender: TObject);
var
  Shift: TShiftState;
  Key: Word;
  KeyChar: Char;
begin
  Key := 13;
  KeyChar := #13;
  edtCodigoKeyDown(Sender, Key, KeyChar, Shift);
end;

procedure TForm1.edtCodigoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    if pesquisaprod then
    begin
      edtDescricao.Text := tblProdutos.FieldByName('descricao').asString;
      edtValorTotalItem.Value := tblProdutos.FieldByName('unitario').AsFloat;
      edtQtd.Value := 1;
      edtQtd.SetFocus();
      mensagem('Escolha a quantidade e pressione <enter> para adicionar');

    end
    else
    begin
      edtCodigo.SetFocus();
      limpa();
    end;
  end;
end;

procedure TForm1.edtQtdChange(Sender: TObject);
begin
  edtTotal.Value := (edtQtd.Value * edtValorTotalItem.Value);
end;

procedure TForm1.edtQtdKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    AdicionaItem();
    limpa();
  end;
end;

procedure TForm1.EnviaParaOServidor(Json: string; forma: string; valor: Extended);
begin
  RESTRequest.Params.clear;
  RESTRequest.AddParameter('numero', FormatDateTime('ss', now));
  RESTRequest.AddParameter('forma', forma);
  RESTRequest.AddParameter('vendas', Json);
  RESTRequest.AddParameter('valor_total', FormatFloat('###0.00', valor));
  RESTRequest.Execute;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  nTotal := 0;
  carregaprod();
  limpa();
end;

function TForm1.ItensParaJson: string;
begin
  result := tblItens.ToJson()
end;

procedure TForm1.limpa;
begin
  edtCodigo.Value := 0;
  edtDescricao.Text := '';
  edtQtd.Value := 0;
  edtValorTotalItem.Value := 0;
  edtCodigo.SelectAll;
  edtCodigo.SetFocus;

  mensagem('Digite o codigo do produto e pressione <enter>');

end;

procedure TForm1.mensagem(mensagem: string);
begin
  lblMensagens.Text := mensagem;
end;

function TForm1.pesquisaprod: Boolean;
begin
  tblProdutos.Filtered := false;
  tblProdutos.Filter := 'codigo=' + edtCodigo.Text;
  tblProdutos.Filtered := true;
  result := tblProdutos.FieldByName('codigo').AsInteger = edtCodigo.Value;
end;

end.
