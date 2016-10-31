unit uFrmBuscaCliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit;

type
  TFrmBuscaCliente = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edtCliente: TEdit;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblCidade: TLabel;
    lblEstado: TLabel;
    lblEndereco: TLabel;
    lblTelefone: TLabel;
    SpeedButton2: TSpeedButton;
    lblNome: TLabel;
    ClearEditButton1: TClearEditButton;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBuscaCliente: TFrmBuscaCliente;

implementation

{$R *.fmx}

uses uFrmPrincipal, uWebService;

procedure TFrmBuscaCliente.SpeedButton1Click(Sender: TObject);
var
  FServer  : IDC;
  FCliente : TCliente;
begin
  try
    cursor := crHourGlass;
    Application.ProcessMessages;
    FServer          := GetIDC();
    FCliente         := FServer.Getcliente(StrToInt(edtCliente.Text));

    lblNome.Text     := FCliente.Nome;
    lblCidade.Text   := FCliente.Cidade;
    lblEstado.Text   := FCliente.Estado;
    lblEndereco.Text := FCliente.Endereco;
    lblTelefone.Text := FCliente.Telefone;
  finally
    Cursor := crDefault;
  end;
end;

procedure TFrmBuscaCliente.SpeedButton2Click(Sender: TObject);
begin
   Self.Hide;
   FrmHome.Show;
end;

end.
