unit frmInicioUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects;

type
  TfrmInicio = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure Image1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInicio: TfrmInicio;

implementation

{$R *.fmx}

uses frmPrincipalUnt, FMX.Helpers.Android, Androidapi.Helpers; //FMX.Platform.Android;

procedure TfrmInicio.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
// if MessageDlg('Deseja realmente fechar a aplicação?',
//        TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0, TMsgDlgBtn.mbNo) = mrYes  then
//   begin
//      CanClose := True;
//      SharedActivity.finish
////      MainActivity.finish;
//   end
//
// else
//  begin
//    CanClose := False;
//    ShowMessage('Você respondeu não');
//  end;


end;



procedure TfrmInicio.Image1Click(Sender: TObject);
begin
  frmPrincipal := TfrmPrincipal.Create(Application);
  frmPrincipal.Show;


end;

procedure TfrmInicio.Timer1Timer(Sender: TObject);
begin
  Image1Click(Sender);
  Image1.Visible := False;
  Timer1.Enabled := Image1.Visible;
end;

end.
