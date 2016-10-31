program EC2014Twitter;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {fPrincipal},
  Twittada in 'Twittada.pas' {Frame1: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfPrincipal, fPrincipal);
  Application.Run;
end.
