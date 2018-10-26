program Conference2018;

uses
  Vcl.Forms,
  fMenuConference2018 in 'fMenuConference2018.pas' {frmMenuConference2018},
  fWebLogin in 'fWebLogin.pas' {frmWebLogin},
  uEvent in 'uEvent.pas',
  uGoogleMapsClass in 'uGoogleMapsClass.pas',
  uJsonMaps in 'uJsonMaps.pas',
  fWebMaps in 'fWebMaps.pas' {frmWebMaps},
  uGoogleTranslateClass in 'uGoogleTranslateClass.pas',
  fExtrairImagemDfm in 'fExtrairImagemDfm.pas' {frmExtrairImagemDfm},
  Vcl.Themes,
  Vcl.Styles,
  uExtratorImagemDfm in 'uExtratorImagemDfm.pas',
  uHandleUtils in 'uHandleUtils.pas',
  fTranslate in 'fTranslate.pas' {frmTranslate};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenuConference2018, frmMenuConference2018);
  Application.Run;
end.
