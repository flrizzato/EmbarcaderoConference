unit uFrmconfig;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Layouts, FMX.ListBox, FMX.StdCtrls;

type
  TfrmConfig = class(TForm)
    GroupBox1: TGroupBox;
    lblPedidos: TLabel;
    SpeedButton2: TSpeedButton;
    ListBox1: TListBox;
    edtHost: TClearingEdit;
    edtPorta: TClearingEdit;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    lblMensagem: TLabel;
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfig: TfrmConfig;

implementation

{$R *.fmx}

uses uFrmPrincipal, uDMDados, uFrmClientes, uFrmPedidos, uFrmProdutos;

procedure TfrmConfig.FormCreate(Sender: TObject);
begin
  edtHost.Text  := DMDados.SQLConnection1.Params.Values['hostname'];
  edtPorta.Text := DMDados.SQLConnection1.Params.Values['port'];
   lblMensagem.Text := '';
end;

procedure TfrmConfig.SpeedButton1Click(Sender: TObject);
begin
  DMDados.SQLConnection1.Close;

  DMDados.SQLConnection1.Params.Values['hostname'] := edtHost.Text;
  DMDados.SQLConnection1.Params.Values['port']     := edtPorta.Text;

  try
    DMDados.SQLConnection1.Open;
    lblMensagem.Text := 'Conectado com sucesso!!!';
    frmClientes.cdsClientes.Close;
    frmProdutos.cdsProdutos.Close;
    FrmPedidos.cdsPedidos.Close;
    Self.Hide;
  except
    On E:Exception do
    begin
    lblMensagem.Text := 'Erro de conexão: ' + E.Message;
    end;
  end;
end;

procedure TfrmConfig.SpeedButton2Click(Sender: TObject);
begin
   Self.Hide;
   FrmHome.Show;
end;

end.
