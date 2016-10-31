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

uses
   System.SysUtils;

type

  // Handler
  Autenticacao = class abstract
    protected _sucessor: Autenticacao;
    public procedure setSucessor(Sucessor: Autenticacao);
    public function Autenticar(UserName, Password: string): boolean; virtual; abstract;
  end;

  // ConcreteHandler
  Formulario = class(Autenticacao)
    public function Autenticar(Usuario, Senha: string): boolean; override;
  end;

  // ConcreteHandler
  Server = class(Autenticacao)
    public function Autenticar(Usuario, Senha: string): boolean; override;
  end;

  // ConcreteHandler
  BancoDados = class(Autenticacao)
    public function Autenticar(Usuario, Senha: string): boolean; override;
  end;

implementation

{ Autenticacao }

procedure Autenticacao.setSucessor(Sucessor: Autenticacao);
begin
  self._sucessor := Sucessor;
end;

{ Formulario }

function Formulario.Autenticar(Usuario, Senha: string): boolean;
begin
  result := (Usuario = 'guinther') and (Senha = '123');
  WriteLn('Validação feita no Formulário:' + BoolToStr(result,true));
  // encadeia chamada
  if (_sucessor <> nil) then
    result := _sucessor.Autenticar(Usuario, Senha);
end;

{ Server }

function Server.Autenticar(Usuario, Senha: string): boolean;
begin
  result := (Usuario = 'guinther') and (Senha = '123');
  WriteLn('Validação feita no AppServer:' + BoolToStr(result,true));
  // encadeia chamada
  if (_sucessor <> nil) then
    result := _sucessor.Autenticar(Usuario, Senha);
end;

{ BancoDados }

function BancoDados.Autenticar(Usuario, Senha: string): boolean;
begin
  result := (Usuario = 'guinther') and (Senha = '123');
  WriteLn('Validação feita no Banco de Dados:' + BoolToStr(result,true));
  // encadeia chamada
  if (_sucessor <> nil) then
    result := _sucessor.Autenticar(Usuario, Senha);
end;

end.
