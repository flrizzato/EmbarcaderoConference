unit UntCadCli;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation;

type
  TfrmCadCli = class(TForm)
    lytBase: TLayout;
    toolSup: TToolBar;
    spbMenu: TSpeedButton;
    Label1: TLabel;
    procedure spbMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCli: TfrmCadCli;

implementation

{$R *.fmx}

uses
  UntPrincipal;

procedure TfrmCadCli.spbMenuClick(Sender: TObject);
begin
  frmPrincipal.MudarAba(frmPrincipal.tbitemMenu, Sender);
end;

end.
