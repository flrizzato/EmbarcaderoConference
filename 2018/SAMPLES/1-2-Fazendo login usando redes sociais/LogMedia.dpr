program LogMedia;

uses
  System.StartUpCopy,
  FMX.Forms,
  FLogin in 'PAS\FLogin.pas' {frmLogin},
  FAutenticacao in 'PAS\FAutenticacao.pas' {frmAutenticacao},
  uDM in 'PAS\uDM.pas' {dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmAutenticacao, frmAutenticacao);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
