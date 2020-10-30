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
  // Product
  Autenticacao = class abstract
    public procedure Autenticar(); virtual; abstract;
  end;

  // Produto Concreto
  AutenticacaoFacebook = class(Autenticacao)
    public procedure Autenticar(); override;
  end;

   // Produto Concreto
  AutenticacaoGoogle = class(Autenticacao)
    public procedure Autenticar(); override;
  end;

  // Creator - define o Factory Method abstrato
  Creator = class abstract
    public function CreateInstance(): Autenticacao; virtual; abstract;
  end;

  // Concrete Creator
  FacebookCreator = class(Creator)
    public function CreateInstance(): Autenticacao; override;
  end;

  // Concrete Creator
  GoogleCreator = class(Creator)
    public function CreateInstance(): Autenticacao; override;
  end;


implementation

procedure AutenticacaoFacebook.Autenticar();
begin
  WriteLn('Autenticado via Facebook');
end;

procedure AutenticacaoGoogle.Autenticar();
begin
  WriteLn('Autenticado via Google');
end;

function FacebookCreator.CreateInstance(): Autenticacao;
begin
  result := AutenticacaoFacebook.Create();
end;

function GoogleCreator.CreateInstance(): Autenticacao;
begin
  result := AutenticacaoGoogle.Create();
end;

end.
