unit uFrmLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts;

type
  TfrmLogin = class(TForm)
    lytLogin: TLayout;
    VertScrollBox1: TVertScrollBox;
    lytTopo: TLayout;
    imgLogo: TImage;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout1: TLayout;
    Entrar: TButton;
    Image1: TImage;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Image4: TImage;
    Edit1: TEdit;
    Layout5: TLayout;
    Layout4: TLayout;
    Image2: TImage;
    Layout6: TLayout;
    Edit2: TEdit;
    Layout7: TLayout;
    Rectangle3: TRectangle;
    Label1: TLabel;
    procedure Rectangle3Click(Sender: TObject);
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

procedure TfrmLogin.Rectangle3Click(Sender: TObject);
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
