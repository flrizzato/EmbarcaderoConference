program CheckMarks;

uses
  System.StartUpCopy,
  FMX.Forms,
  untMain in 'untMain.pas' {Form24};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm24, Form24);
  Application.Run;
end.
