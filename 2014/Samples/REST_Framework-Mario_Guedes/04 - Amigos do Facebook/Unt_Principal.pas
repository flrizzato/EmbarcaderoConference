unit Unt_Principal;

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
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Label1: TLabel;
    eAccessToken: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Unt_Nucleo;

procedure TForm1.Button1Click(Sender: TObject);
var
  iQuantidade: Integer;
begin
  dmNucleo.ProcessarLista(Self.eAccessToken.Text, iQuantidade);

  Self.Label1.Caption := IntToStr(iQuantidade);
end;

end.
