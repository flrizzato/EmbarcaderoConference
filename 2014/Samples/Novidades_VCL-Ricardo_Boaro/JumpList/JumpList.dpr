program JumpList;

uses
  Vcl.Forms,
  Windows,
  Unit1 in 'Unit1.pas' {Form1},
  WinProcessHelpers in 'WinProcessHelpers.pas';

{$R *.res}


// check if mutex already exists
begin
HMutex := CreateMutex(nil, False, 'JumpListFilesDemoMutex');
if WaitForSingleObject(hMutex, 0) <> wait_TimeOut then
 begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
 end
 else
  ActivateWindow (TForm1);
end.
