program FastReport;

uses
  Vcl.Forms,
  fPrincipal in 'fPrincipal.pas' {frmPrincipalExemplo1},
  uDMConexao in 'uDMConexao.pas' {DMConexao: TDataModule},
  uDMConsultas in 'uDMConsultas.pas' {DMConsultas: TDataModule},
  uMetodosClient in 'uMetodosClient.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMConexao, DMConexao);
  Application.CreateForm(TDMConsultas, DMConsultas);
  Application.CreateForm(TfrmPrincipalExemplo1, frmPrincipalExemplo1);
  Application.Run;
end.
