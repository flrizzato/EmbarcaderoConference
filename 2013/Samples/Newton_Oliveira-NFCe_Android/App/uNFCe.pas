unit uNFCe;

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
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Edit,
  uDMNFCe,
  System.Rtti,
  System.Bindings.Outputs,
  FMX.Bind.Editors,
  Data.Bind.EngExt,
  FMX.Bind.DBEngExt,
  Data.Bind.Components,
  Data.Bind.DBScope,
  FMX.Layouts,
  FMX.ListBox,
  uServerDataSnap,
  uNota,
  FMX.WebBrowser;

type
  TfrmNota = class(TForm)
    tbrTopo: TToolBar;
    tbrRodape: TToolBar;
    Label1: TLabel;
    ToolBar1: TToolBar;
    btnEnvia: TSpeedButton;
    imgEnvia: TImage;
    BindSourceDB2: TBindSourceDB;
    Edit1: TEdit;
    Label2: TLabel;
    WebBrowser1: TWebBrowser;
    procedure imgEnviaClick(Sender: TObject);
    procedure cbxProdutoChange(Sender: TObject);
  private
    FNota: TNotaFiscal;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNota: TfrmNota;

implementation

{$R *.fmx}

procedure TfrmNota.cbxProdutoChange(Sender: TObject);
begin
  // DMNFCe.tblCliente.FieldByName('descricao').AsString;
end;

procedure TfrmNota.imgEnviaClick(Sender: TObject);
var
  lServidor: TServerMethods1Client;
  lResultado: string;
  lItem: TItem;
begin
  FNota := TNotaFiscal.create;
  FNota.NumeroNota := Edit1.Text;
  FNota.Cliente.Nome := 'Consumidor';

  lItem := TItem.create;
  lItem.Descricao := 'Produto 1';
  FNota.Itens.Add(lItem);

  lItem := TItem.create;
  lItem.Descricao := 'Produto 2';
  FNota.Itens.Add(lItem);

  DMNFCe.Android.Open;
  lServidor := TServerMethods1Client.create(DMNFCe.Android.DBXConnection);
  lResultado := lServidor.EnviarNota(FNota);

  DMNFCe.Android.Close;
  FNota.Free;

  ShowMessage(lResultado);

  WebBrowser1.URL :=
    'http://chart.apis.google.com/chart?chs=200x200&cht=qr&chl=' + lResultado;
  WebBrowser1.Navigate;

end;

end.
