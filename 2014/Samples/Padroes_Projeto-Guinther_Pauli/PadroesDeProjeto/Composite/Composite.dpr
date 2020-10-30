{
Sobre o autor:
Guinther Pauli
Delphi Certified Professional - 3,5,6,7,2005,2006,Delphi Web,Kylix,XE
Microsoft Certified Professional - MCP,MCAD,MCSD.NET,MCTS,MCPD (C#, ASP.NET, Arquitetura)
Colaborador Editorial Revistas .net Magazine e ClubeDelphi
MVP (Most Valuable Professional) - Embarcadero Technologies - US
http://gpauli.com
http://www.facebook.com/guintherpauli
http://www.twitter.com/guintherpauli
http://br.linkedin.com/in/guintherpauli
}
program Composite;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  form: Formulario;
begin
  form := Formulario.Create('Padrões de Projeto em Delphi');
  form.Add(Panel.Create(''));
  form.Add(&Label.Create('Cadastro de Clientes'));
  form.Add(TextBox.Create('Código'));
  form.Add(TextBox.Create('Nome'));
  form.Add(TextBox.Create('Fone'));
  form.Add(TextBox.Create('Endereço'));
  form.Add(Button.Create('Incluir'));
  form.Add(Button.Create('Consultar'));
  //form.Add(form);
  form.Display();
  ReadLn;
 end.
