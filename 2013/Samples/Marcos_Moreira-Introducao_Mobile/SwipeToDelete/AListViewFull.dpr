program AListViewFull;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainFm in 'MainFm.pas' {MainForm},
  RandomTextUtils in 'RandomTextUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
