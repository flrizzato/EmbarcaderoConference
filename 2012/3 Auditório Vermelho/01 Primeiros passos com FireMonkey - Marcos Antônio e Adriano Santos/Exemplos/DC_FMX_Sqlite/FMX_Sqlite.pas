program FMX_Sqlite;

uses
  cwstring, cthreads, FMX_Forms,
  Unit1 in 'Unit1.pas' {Form1};

{.$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
