program NFCe;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  uDM_ModuloEnvio in 'uDM_ModuloEnvio.pas' {DM_ModuloEnvio: TDataModule},
  uNotaFiscal in 'classes\uNotaFiscal.pas',
  uProduto in 'classes\uProduto.pas',
  uEmpresa in 'classes\uEmpresa.pas',
  ufrmProduto in 'ufrmProduto.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
