unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.MultiView, FMX.Controls.Presentation, FMX.Layouts, FMX.WebBrowser,
  FMX.StdCtrls, FMX.Objects, ceffmx, ceflib, Winapi.Windows, Form_NFe;

type
  TMainForm = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    Layout3: TLayout;
    MultiView1: TMultiView;
    SpeedButton1: TSpeedButton;
    StyleBook1: TStyleBook;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Layout2: TLayout;
    ChromiumFMX1: TChromiumFMX;
    SpeedButton6: TSpeedButton;
    procedure SpeedButton6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure ExibirFormPrincipal;
  public
    { Public declarations }
    ExitAction : Boolean;
  end;

var
  MainForm: TMainForm;

implementation

uses
  Form_Principal;

{$R *.fmx}

procedure TMainForm.ExibirFormPrincipal;
var
  FormPrincipal : TFormPrincipal;
begin
  FormPrincipal := TFormPrincipal.Create(Self);
  FormPrincipal.MainForm := Self;
  Self.Layout3.RemoveObject(0);
  Self.Layout3.AddObject(FormPrincipal.Layout1);
  ExitAction := true;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  ExibirFormPrincipal;
end;

procedure TMainForm.SpeedButton6Click(Sender: TObject);
begin
  if ExitAction then
    Close
  else
    ExibirFormPrincipal;
end;

end.
