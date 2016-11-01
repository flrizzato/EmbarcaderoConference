program MestreDetalhe;

uses
  Vcl.Forms,
  Unit6 in 'Unit6.pas' {Form6},
  Unit7 in 'Unit7.pas' {DataModule7: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TDataModule7, DataModule7);
  Application.Run;
end.
