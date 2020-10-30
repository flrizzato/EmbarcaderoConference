unit UClientePC1RSA;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DBXDataSnap, IndyPeerImpl, Data.DBXCommon, Data.DB, Data.SqlExpr;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    edtBusca: TEdit;
    btnBuscar: TBitBtn;
    SQLCN: TSQLConnection;
    procedure FormShow(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses UServerMethodsClient;

procedure TForm1.btnBuscarClick(Sender: TObject);
var objMetodosPC1RSA:TServerMethodsClient;
begin
  objMetodosPC1RSA := TServerMethodsClient.Create(SQLCN.DBXConnection);
  try
    edtBusca.Text := objMetodosPC1RSA.ReverseString(edtBusca.Text);
  finally
    FreeAndNil(objMetodosPC1RSA);
  end;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if not SQLCN.Connected then
  begin
    SQLCN.Connected := True;
  end;

end;

end.
