program Teste;

{$R *.dres}

uses
  FMX.Forms,
  FMX.Styles,
  uTeste in 'uTeste.pas' {Form1};

{$R *.res}

begin
//  TStyleManager.SetStyleFromFile('C:\Evento\Botao\Dark.style');

  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
