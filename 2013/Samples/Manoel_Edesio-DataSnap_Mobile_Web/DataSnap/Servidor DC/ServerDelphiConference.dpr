program ServerDelphiConference;

uses
  Vcl.Forms,
  uFrmServidor in 'uFrmServidor.pas' {Form55},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' {ServerDelphiConference: TDSServerModule},
  ServerContainerUnit1 in 'ServerContainerUnit1.pas' {ServerContainer1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm55, Form55);
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.Run;
end.

