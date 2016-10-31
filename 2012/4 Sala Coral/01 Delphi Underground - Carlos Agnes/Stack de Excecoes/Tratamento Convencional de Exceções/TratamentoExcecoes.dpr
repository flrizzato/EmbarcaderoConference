program TratamentoExcecoes;

uses
  FMX.Forms,
  fPrincipal in 'fPrincipal.pas' {frmPrincipal},
  uCliente in 'uCliente.pas',
  uConexao in 'uConexao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
