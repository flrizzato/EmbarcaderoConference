program CentralDataViewer;

uses
  Vcl.Forms,
  formCentralDataMain in 'formCentralDataMain.pas' {Form2},
  dmDatabase in 'dmDatabase.pas' {dtmdDatabase: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
