program firebase;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ChatFacade in 'sources\ChatFacade.pas',
  Firebase.Auth in 'sources\Firebase.Auth.pas',
  Firebase.Database in 'sources\Firebase.Database.pas',
  Firebase.Interfaces in 'sources\Firebase.Interfaces.pas',
  Firebase.Request in 'sources\Firebase.Request.pas',
  Firebase.Response in 'sources\Firebase.Response.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
