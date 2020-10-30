program FireMonkeyHints;

uses
  System.StartUpCopy,
  FMX.Forms,
  FireMonkeyHintsButton in 'FireMonkeyHintsButton.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
