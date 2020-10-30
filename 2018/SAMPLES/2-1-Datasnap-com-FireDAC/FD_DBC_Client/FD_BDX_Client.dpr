program FD_BDX_Client;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form6},
  Dm in 'Dm.pas' {Dtm: TDataModule},
  Unit2 in 'Unit2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TDtm, Dtm);
  Application.Run;
end.
