program QualiData;

uses
  System.StartUpCopy,
  FMX.Forms,
  U_FormPrincipal in 'U_FormPrincipal.pas' {FormPrincipal},
  U_Proxy in 'U_Proxy.pas',
  Lib.Android.Account in 'Lib\Lib.Android.Account.pas',
  Lib.AndroidUtils in 'Lib\Lib.AndroidUtils.pas',
  Lib.Data.Helpers in 'Lib\Lib.Data.Helpers.pas',
  Lib.DeviceInfo in 'Lib\Lib.DeviceInfo.pas',
  Lib.Persistent.Helpers in 'Lib\Lib.Persistent.Helpers.pas',
  Lib.Ver in 'Lib\Lib.Ver.pas',
  lJSONReqResp in 'Lib\lJSONReqResp.pas',
  lPush in 'Lib\lPush.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
