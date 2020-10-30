program BatchMove;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Dm in 'Dm.pas' {Dtm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDtm, Dtm);
  Application.Run;
end.
