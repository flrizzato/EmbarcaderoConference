unit uFramework;

interface

type

 // State
  TTipoAutenticacao = class abstract
    procedure Autenticar(); virtual; abstract;
  end;

  // Concrete State
  TAutenticacaoLocal = class(TTipoAutenticacao)
    procedure Autenticar(); override;
  end;

    // Concrete State
  TAutenticacaoBD = class(TTipoAutenticacao)
    procedure Autenticar(); override;
  end;

    // Concrete State
  TAutenticacaoWebService = class(TTipoAutenticacao)
    procedure Autenticar(); override;
  end;

  TAutenticacao = class
    Usuario, Senha: string;
    Tipo: TTipoAutenticacao;
    procedure Autenticar();
  end;


implementation

{ TAutenticacaoLocal }

procedure TAutenticacaoLocal.Autenticar();
begin
  WriteLn('Autenticado local');
end;

{ TAutenticacaoBD }

procedure TAutenticacaoBD.Autenticar();
begin
  WriteLn('Autenticado no BD');
end;

{ TAutenticacaoWebService }

procedure TAutenticacaoWebService.Autenticar();
begin
  WriteLn('Autenticado no Web Service');
end;

{ TContext }

procedure TAutenticacao.Autenticar();
begin
  Tipo.Autenticar();
end;


end.
