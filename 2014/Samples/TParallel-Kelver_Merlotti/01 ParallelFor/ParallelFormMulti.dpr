program ParallelFormMulti;

uses
  System.StartUpCopy,
  FMX.Forms,
  ParallelForMultiForm in 'ParallelForMultiForm.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
