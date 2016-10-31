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

program IteratorApp;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

function CriaClientes(): TClienteList;
begin
  result := TClienteList.Create();
  result.Add(TCliente.Create(1,'Guinther'));
  result.Add(TCliente.Create(2,'Rudolfo'));
  result.Add(TCliente.Create(3,'Wesley'));
  result.Add(TCliente.Create(4,'Erlei'));
  result.Add(TCliente.Create(5,'Paulo'));
  result.Add(TCliente.Create(6,'Daniel'));
end;

var
  list: TClienteList;
  itr: TClienteIterator;
begin
  list := CriaClientes();
  try
    itr := TClienteIterator.Create(list);
    try
      while itr.Next() do
        WriteLn(itr.CurrentItem.Nome);
    finally
      itr.Free();
    end;
  finally
    list.Free;
  end;
  Readln;
end.
