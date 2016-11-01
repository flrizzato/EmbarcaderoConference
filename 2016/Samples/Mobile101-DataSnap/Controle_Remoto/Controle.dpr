program Controle;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmInicioUnt in 'frmInicioUnt.pas' {frmInicio},
  frmPrincipalUnt in 'frmPrincipalUnt.pas' {frmPrincipal},
  ClientClassesDistrimedUnt in 'ClientClassesDistrimedUnt.pas',
  ClientModuleDistrimedUnt in 'ClientModuleDistrimedUnt.pas' {ClientModuleDistrimed: TDataModule},
  frmProdutosUnt in 'frmProdutosUnt.pas' {frmProdutos},
  frmMoldeTelasUnt in 'frmMoldeTelasUnt.pas' {frmMoldeTelas},
  frmVendedoresUnt in 'frmVendedoresUnt.pas' {frmVendedores},
  frmClientesUnt in 'frmClientesUnt.pas' {frmClientes};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmInicio, frmInicio);
  Application.CreateForm(TClientModuleDistrimed, ClientModuleDistrimed);
  Application.CreateForm(TfrmMoldeTelas, frmMoldeTelas);
  Application.Run;
end.
