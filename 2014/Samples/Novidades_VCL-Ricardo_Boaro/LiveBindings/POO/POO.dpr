program POO;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uClientes in 'uClientes.pas',
  uDmDados in 'uDmDados.pas' {DataModule1: TDataModule},
  uCadClientes in 'uCadClientes.pas' {FrmCadClientes},
  uCidades in 'uCidades.pas',
  uLoadObjetos in 'uLoadObjetos.pas',
  uCadCidades in 'uCadCidades.pas' {FrmCadCidades};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
