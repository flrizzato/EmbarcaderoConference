program MoleculeHero;

uses
  System.StartUpCopy,
  FMX.Forms,
  MolHero.FormMain in 'MolHero.FormMain.pas' {FormMain},
  MolHero.Types in 'MolHero.Types.pas',
  MolHero.DMMain in 'MolHero.DMMain.pas' {DMMain: TDataModule},
  MolHero.FormAdd in 'MolHero.FormAdd.pas' {FormAdd},
  MolHero.FormRes in 'MolHero.FormRes.pas' {FormRes},
  MolHero.ImportPDB in 'MolHero.ImportPDB.pas',
  MolHero.Materials in 'MolHero.Materials.pas',
  MolHero.MoleculeModel in 'MolHero.MoleculeModel.pas',
  MolHero.Utils in 'MolHero.Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMMain, DMMain);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormRes, FormRes);
  Application.Run;
end.
