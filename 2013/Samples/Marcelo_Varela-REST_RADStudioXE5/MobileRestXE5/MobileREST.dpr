program MobileREST;

uses
  System.StartUpCopy,
  FMX.Forms,
  RESTMainForm in 'RESTMainForm.pas' {TabbedForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTabbedForm, TabbedForm);
  Application.Run;
end.
