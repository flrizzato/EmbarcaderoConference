program ParallelTaskAndFutures;

uses
  Vcl.Forms,
  ParallelForm in 'ParallelForm.pas' {FormThreading};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormThreading, FormThreading);
  Application.Run;
end.
