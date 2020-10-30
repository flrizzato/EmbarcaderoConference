program PhoneMasterDetailApplication;

uses
  System.StartUpCopy,
  FMX.Forms,
  MasterDetail_Phone in 'MasterDetail_Phone.pas' {PhoneMasterDetail};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TPhoneMasterDetail, PhoneMasterDetail);
  Application.Run;
end.
