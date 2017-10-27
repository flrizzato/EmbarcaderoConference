program POO_Feito_pra_Durar;

uses
  Vcl.Forms,
  POO.View.Principal in 'View\POO.View.Principal.pas' {Form3},
  POO.Model.Interfaces in 'Model\POO.Model.Interfaces.pas',
  POO.Controller.Interfaces in 'Controller\POO.Controller.Interfaces.pas',
  POO.Model.Log in 'Model\POO.Model.Log.pas',
  POO.Model.Log.TXT in 'Model\POO.Model.Log.TXT.pas',
  POO.Model.Log.Email in 'Model\POO.Model.Log.Email.pas',
  POO.Model.Log.Factory in 'Model\POO.Model.Log.Factory.pas',
  POO.Controller.Log.Facade in 'Controller\POO.Controller.Log.Facade.pas',
  POO.Controller.Exception in 'Controller\POO.Controller.Exception.pas',
  POO.Model.Log.BD in 'Model\POO.Model.Log.BD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
