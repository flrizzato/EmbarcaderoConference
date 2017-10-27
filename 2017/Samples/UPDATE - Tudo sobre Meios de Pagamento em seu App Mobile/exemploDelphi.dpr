program exemploDelphi;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.Principal in 'Form.Principal.pas' {frmPrincipal},
  Form.REST in 'Form.REST.pas' {frmREST},
  Form.SOAP in 'Form.SOAP.pas' {frmSOAP},
  Form.NFC in 'Form.NFC.pas' {frmNFC},
  Form.BlueTooth in 'Form.BlueTooth.pas' {frmBlueTooth},
  globalweather in 'globalweather.pas',
  Classes.Custom.Adapter in 'Classes.Custom.Adapter.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmREST, frmREST);
  Application.CreateForm(TfrmSOAP, frmSOAP);
  Application.CreateForm(TfrmNFC, frmNFC);
  Application.CreateForm(TfrmBlueTooth, frmBlueTooth);
  Application.Run;
end.
