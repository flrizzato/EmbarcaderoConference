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

program TemplateMethod;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  // Programe para uma interface/abstração
  prova: Correcao;
  redacao: Correcao;
  inscricao: Correcao;
begin
  inscricao := CorrecaoInscricao.Create();
  inscricao.Processar();
  prova := CorrecaoProva.Create();
  prova.Processar();
  redacao := CorrecaoRedacao.Create();
  redacao.Processar();
  Readln;
end.
