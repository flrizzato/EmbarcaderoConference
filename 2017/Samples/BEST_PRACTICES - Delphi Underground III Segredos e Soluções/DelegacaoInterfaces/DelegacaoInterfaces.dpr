program DelegacaoInterfaces;

uses
  System.StartUpCopy,
  FMX.Forms,
  fPricnipalDelegacao in 'fPricnipalDelegacao.pas' {Form4},
  uDelegacao in 'uDelegacao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
