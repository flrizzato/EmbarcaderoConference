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
program ChainOfResponsability;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  frm: Formulario;
  app: Server;
  BD: BancoDados;
  Usuario, Senha: string;
begin
  Writeln('Usuario:');
  Readln(Usuario);
  Writeln('Senha:');
  Readln(Senha);
  frm := Formulario.Create();
  app := Server.Create();
  BD := BancoDados.Create();
  frm.setSucessor(app);
  app.setSucessor(BD);
  // passando requisição para cadeia de responsabilidade
  frm.Autenticar(Usuario,Senha);
  Readln;
end.
