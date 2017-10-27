unit uRestaurante;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.Buttons;

type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    edtNome: TLabeledEdit;
    edtDocumento: TLabeledEdit;
    grbPedido: TGroupBox;
    cbxProduto: TComboBox;
    Label1: TLabel;
    edtQTD: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    dbgPedido: TDBGrid;
    mtblPedido: TFDMemTable;
    mtblPedidodocumento: TStringField;
    mtblPedidonome: TStringField;
    mtblPedidoproduto: TIntegerField;
    mtblPedidoqtd: TIntegerField;
    dtsPedido: TDataSource;
    mtblPedidodescricao: TStringField;
    GroupBox2: TGroupBox;
    lblTotal: TLabel;
    mtblPedidototal: TFloatField;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    total: extended;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
begin
  mtblPedido.CreateDataSet;
  total := 0;
end;

procedure TForm3.SpeedButton1Click(Sender: TObject);
var
  valor: extended;
begin

  if StrToInt(FormatDateTime('HH', Now)) > 16 then
  begin
    if cbxProduto.ItemIndex <> 3 then
      valor := 10.00
    else
      valor := 4.00;

  end
  else
  begin
    if cbxProduto.ItemIndex <> 3 then
      valor := 15.00
    else
      valor := 7.00;
  end;
  valor := valor * StrToInt(edtQTD.Text);

  mtblPedido.Insert;
  mtblPedidodocumento.AsString := edtDocumento.Text;
  mtblPedidonome.AsString := edtNome.Text;
  mtblPedidoproduto.AsInteger := cbxProduto.ItemIndex;
  mtblPedidodescricao.AsString := cbxProduto.Text;
  mtblPedidoqtd.AsInteger := StrToInt(edtQTD.Text);
  mtblPedidototal.asFloat := valor;
  mtblPedido.Post;
  total := total + valor;

  lblTotal.caption := 'R$ ' + FormatFloat('#0,.00', total);

end;

end.
