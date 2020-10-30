program EC2016_PPL;

uses
  Vcl.Forms,
  PPL.Main in 'PPL.Main.pas' {Form1},
  PPL.Rules in 'PPL.Rules.pas' {dmRules: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmRules, dmRules);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
