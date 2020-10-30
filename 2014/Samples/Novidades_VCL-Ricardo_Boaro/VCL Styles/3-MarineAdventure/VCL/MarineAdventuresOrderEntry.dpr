program MarineAdventuresOrderEntry;

uses
  Vcl.Forms,
  About in 'About.pas' {AboutBox},
  BrCstOrd in 'BrCstOrd.pas' {BrCustOrdForm},
  BRPARTS in 'BRPARTS.PAS' {BrPartsForm},
  DataMod in 'DataMod.pas' {MastData: TDataModule},
  EDCUST in 'EDCUST.PAS' {EdCustForm},
  EDORDERS in 'EDORDERS.PAS' {EdOrderForm},
  EDPARTS in 'EDPARTS.PAS' {EdPartsForm},
  FormMainUnit in 'FormMainUnit.pas' {MainForm},
  Pickdate in 'Pickdate.pas' {BrDateForm},
  PickInvc in 'PickInvc.pas' {PickOrderNoDlg},
  QryCust in 'QryCust.pas' {QueryCustDlg},
  Splash in 'Splash.pas' {SplashForm},
  SrchDlg in 'SrchDlg.pas' {SearchDlg},
  Utils in 'Utils.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  SplashForm := TSplashForm.Create(Application);
  SplashForm.Show;
  SplashForm.Update;
  TStyleManager.TrySetStyle('Glossy');
  Application.Title := 'Marine Adventures Order Entry';
//  Application.HelpFile := 'MASTAPP.HLP';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TBrCustOrdForm, BrCustOrdForm);
  Application.CreateForm(TBrPartsForm, BrPartsForm);
  Application.CreateForm(TMastData, MastData);
  Application.CreateForm(TEdCustForm, EdCustForm);
  Application.CreateForm(TEdOrderForm, EdOrderForm);
  Application.CreateForm(TEdPartsForm, EdPartsForm);
  Application.CreateForm(TBrDateForm, BrDateForm);
  Application.CreateForm(TPickOrderNoDlg, PickOrderNoDlg);
  Application.CreateForm(TQueryCustDlg, QueryCustDlg);
  Application.CreateForm(TSearchDlg, SearchDlg);
  SplashForm.Hide;
  SplashForm.Free;
  Application.Run;
end.
