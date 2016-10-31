program EC2015_JSON;



uses
  Vcl.Forms,
  EC2015_JSON.Principal in 'EC2015_JSON.Principal.pas' {fPrincipal},
  EC2015_JSON.InstagramApiREST in 'EC2015_JSON.InstagramApiREST.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfPrincipal, fPrincipal);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
