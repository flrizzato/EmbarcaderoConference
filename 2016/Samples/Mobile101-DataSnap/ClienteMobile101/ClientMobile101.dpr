program ClientMobile101;

uses
  System.StartUpCopy,
  FMX.Forms,
  fraTopoUnt in 'fraTopoUnt.pas' {fraTopo: TFrame},
  frmModeloUnt in 'frmModeloUnt.pas' {frmModelo},
  frmPrincipalUnt in 'frmPrincipalUnt.pas' {Form2},
  ClassesClientUnt in 'ClassesClientUnt.pas',
  ModuloClientRestUnt in 'ModuloClientRestUnt.pas' {ModuloClientRest: TDataModule},
  fraMenuTopUnt in 'fraMenuTopUnt.pas' {fraMenuTop: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TfrmModelo, frmModelo);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TModuloClientRest, ModuloClientRest);
  Application.Run;
end.
