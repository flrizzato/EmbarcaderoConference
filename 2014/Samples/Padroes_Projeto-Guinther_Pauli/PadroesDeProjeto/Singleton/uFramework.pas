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

unit uFramework;

interface
// Singleton
type
  ConexaoBD = class
    // guarda internamente a instância
    private class var _instance: ConexaoBD;
    // esconde construtor
    protected constructor Create();
    // método que retorna singleton
    public class function Instance(): ConexaoBD;
    public stringConexao: string;
    public procedure Open();
  end;

implementation

constructor ConexaoBD.Create();
begin
end;

class function ConexaoBD.Instance(): ConexaoBD;
begin
  // garantir que sempre uma instância exista, só uma
  if _instance = nil then
    _instance := ConexaoBD.Create();
  result := _instance
end;

procedure ConexaoBD.Open();
begin
  WriteLn('Abrindo conexão com banco ' + stringConexao);
end;

end.

