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

type

  // Strategy
  Autenticacao = class abstract
     public function Autenticar(UserName, Password: string): boolean; virtual; abstract;
  end;

  // Context (Open Closed Principle - OCP)
  Context = class
    private _autenticacao: Autenticacao;
    public constructor Create(AAutenticacao: Autenticacao);
    public destructor Destroy(); override;
    public function Autenticar(Usuario, Senha: string): boolean;
  end;

  // Concrete Strategy
  AutenticacaoSQL = class(Autenticacao)
    public function Autenticar(Usuario, Senha: string): boolean; override;
  end;

  // Concrete Strategy
  AutenticacaoWebService = class(Autenticacao)
    public function Autenticar(Usuario, Senha: string): boolean; override;
  end;

  // Concrete Strategy
  AutenticacaoXML = class(Autenticacao)
    public function Autenticar(Usuario, Senha: string): boolean;
  end;


implementation

{ AutenticacaoSQL }

function AutenticacaoSQL.Autenticar(Usuario, Senha: string): boolean;
begin
  // valida usuário usando conexão com SQL Server
  result := (Usuario = 'guinther') and (Senha = '123');
end;

{ AutenticacaoWebService }

function AutenticacaoWebService.Autenticar(Usuario, Senha: string): boolean;
begin
   // valida usuário usando Web Service
  result := (Usuario = 'guinther') and (Senha = '123');
end;

{ AutenticacaoXML }

function AutenticacaoXML.Autenticar(Usuario, Senha: string): boolean;
begin
  // valida usuário usando dados de um arquivo XML
  result := (Usuario = 'guinther') and (Senha = '123');
end;

{ Context }

constructor Context.Create(AAutenticacao: Autenticacao);
begin
  Self._autenticacao := AAutenticacao;
end;

destructor Context.Destroy();
begin
  Self._autenticacao.Free();
  inherited;
end;

function Context.Autenticar(Usuario, Senha: string): boolean;
begin
  result := _autenticacao.Autenticar(Usuario,Senha);
end;

end.
