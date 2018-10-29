program ParallelFor;

uses
  Vcl.Forms,
  ParallelForMain in 'ParallelForMain.pas' {btnParallelFor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TbtnParallelFor, btnParallelFor);
  Application.Run;
end.
