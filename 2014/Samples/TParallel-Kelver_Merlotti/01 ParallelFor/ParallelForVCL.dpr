program ParallelForVCL;

uses
  Forms,
  ParallelFor_MainForm in 'ParallelFor_MainForm.pas' {FormParallelFor};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormParallelFor, FormParallelFor);
  Application.Run;
end.
