unit fPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uMapeamento, FMX.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    btnVerificarIdiomaTecladoCorrente: TButton;
    procedure btnVerificarIdiomaTecladoCorrenteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.btnVerificarIdiomaTecladoCorrenteClick(Sender: TObject);
var
  lCurrentImputMode: Pointer;
begin
  lCurrentImputMode := TUITextInputMode.OCClass.currentInputMode;

  if Assigned(lCurrentImputMode) then
  begin
    ShowMessage('Teclado corrente: ' +
      string(TUITextInputMode.Wrap(lCurrentImputMode).primaryLanguage.UTF8String));
  end else begin
    ShowMessage('Não foi possível capturar o teclado corrente.');
  end;
end;

end.
