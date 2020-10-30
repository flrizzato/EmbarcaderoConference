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

program FactoryMethod;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Generics.Collections,
  uFramework in 'uFramework.pas';

var
  Creators: TList<Creator>;
  c: Creator;
  aut: Autenticacao;
begin
  Creators := TList<Creator>.Create();
  Creators.Add(FacebookCreator.Create());
  Creators.Add(GoogleCreator.Create());
  for c in Creators do
  begin
    aut := c.CreateInstance(); // Factory Method
    aut.Autenticar();
  end;
  ReadLn;
end.
