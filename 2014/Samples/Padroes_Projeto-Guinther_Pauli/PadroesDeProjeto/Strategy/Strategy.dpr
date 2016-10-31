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
program Strategy;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  ctx: Context;
  Usuario, Senha: string;
begin
  Writeln('Usuario:');
  Readln(Usuario);
  Writeln('Senha:');
  Readln(Senha);
  // trocar aqui forma de autenticação para teste
  ctx := Context.Create(AutenticacaoWebService.Create());
  if ctx.Autenticar(Usuario,Senha) then
    Writeln('Usuário autenticado com sucesso')
  else
    Writeln('Credenciais inválidas');
  Readln;
end.
