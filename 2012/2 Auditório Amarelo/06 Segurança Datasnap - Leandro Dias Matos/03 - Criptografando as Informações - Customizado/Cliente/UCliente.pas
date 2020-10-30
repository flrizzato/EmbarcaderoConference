unit UCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB,
  Data.SqlExpr, Data.DBXDataSnap, IPPeerClient, Data.DBXCommon;

type
  TFrmClienteFiltro = class(TForm)
    grpClient: TGroupBox;
    Label1: TLabel;
    edtHora: TEdit;
    BitBtn1: TBitBtn;
    SQLCN: TSQLConnection;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmClienteFiltro: TFrmClienteFiltro;

implementation

{$R *.dfm}

uses UMetodos;

procedure TFrmClienteFiltro.BitBtn1Click(Sender: TObject);
var objMetodosFiltro:TServerMethodsFiltroClient;
begin
  objMetodosFiltro := TServerMethodsFiltroClient.Create(SQLCN.DBXConnection);
  try
    edtHora.Text := objMetodosFiltro.HoraServidor;
  finally
    FreeAndNil(objMetodosFiltro);
  end;
end;

procedure TFrmClienteFiltro.FormShow(Sender: TObject);
begin
  if not SQLCN.Connected then
    SQLCN.Connected := True;
end;

end.
