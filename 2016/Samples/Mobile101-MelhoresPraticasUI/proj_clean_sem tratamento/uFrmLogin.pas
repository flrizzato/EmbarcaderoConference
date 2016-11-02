unit uFrmLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts;

type
  TfrmLogin = class(TForm)
    lytLogin: TLayout;
    VertScrollBox1: TVertScrollBox;
    rctBackground: TRectangle;
    lytTopo: TLayout;
    imgLogo: TImage;
    Layout2: TLayout;
    Layout3: TLayout;
    Label1: TLabel;
    edtLogin: TEdit;
    Layout1: TLayout;
    Layout4: TLayout;
    edtSenha: TEdit;
    Label2: TLabel;
    Entrar: TButton;
    procedure EntrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

uses uMain;

procedure TfrmLogin.EntrarClick(Sender: TObject);
begin
  try
    frmMain.tbcMain.ActiveTab := frmMain.tbiEmpresa;

    frmMain.ShowModal(
      procedure(ModalResult: TModalResult)
      begin

      end);

  finally
    // frmMobile.DisposeOf;
  end;
end;

end.
