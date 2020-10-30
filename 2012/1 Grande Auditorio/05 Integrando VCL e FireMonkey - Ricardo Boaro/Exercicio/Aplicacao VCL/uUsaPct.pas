unit uUsaPct;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.Menus;

type
  TFrmPrincipal = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    FormulrioVCL1: TMenuItem;
    FormulrioFiremonkeyHD1: TMenuItem;
    Image1: TImage;
    FormulrioFiremonkeyHD2: TMenuItem;
    procedure FormulrioVCL1Click(Sender: TObject);
    procedure FormulrioFiremonkeyHD1Click(Sender: TObject);
    procedure FormulrioFiremonkeyHD2Click(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses uformVCL, uFiremonkeyHD, uGridSlider;


procedure TFrmPrincipal.FormulrioFiremonkeyHD1Click(Sender: TObject);
var
 FFire : TFrmFormFiremonkeyHD;
begin
 {Criar o formulario Firemonkey HD antes de chamá-lo}
 FFire := TFrmFormFiremonkeyHD.Create(Self);
 try
  FFire.ShowModal;
 finally
  FFire.Free;
 end;
end;

procedure TFrmPrincipal.FormulrioFiremonkeyHD2Click(Sender: TObject);
var
 FGridSlider : TFrmGridSlider;
begin
 {Criar o formulario Firemonkey HD antes de chamá-lo}
 FGridSlider := TFrmGridSlider.Create(Self);
 try
  FGridSlider.ShowModal;
 finally
  FGridSlider.Free;
 end;
end;

procedure TFrmPrincipal.FormulrioVCL1Click(Sender: TObject);
var
 FVcl : TFormVCL;
begin
 {Criar o formulario VCL antes de chamá-lo}
 FVcl := TFormVCL.Create(Self);
 try
  FVcl.ShowModal;
 finally
  FVcl.free;
 end;
end;


end.
