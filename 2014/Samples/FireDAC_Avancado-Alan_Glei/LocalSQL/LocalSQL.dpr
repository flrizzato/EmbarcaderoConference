program LocalSQL;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Dm in 'Dm.pas' {Dtm: TDataModule},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDtm, Dtm);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
