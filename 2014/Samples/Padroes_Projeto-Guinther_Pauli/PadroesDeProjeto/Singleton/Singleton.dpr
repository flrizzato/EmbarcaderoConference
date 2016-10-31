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

program Singleton;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  con1,con2: ConexaoBD;
begin
  con1 := ConexaoBD.Instance();
  con1.stringConexao := 'SQL Server';
  con1.Open();
  con2 := ConexaoBD.Instance();
  con2.Open();
  // comprovando que são a mesma instância
  if (con1 = con2) then // está referenciado a mesma posição de memória, apontando para o mesmo objeto?
    WriteLn('São a mesma instância');
  ReadLn;
end.
