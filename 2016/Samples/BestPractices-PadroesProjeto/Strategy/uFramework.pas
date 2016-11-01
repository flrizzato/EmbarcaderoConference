unit uFramework;

interface

type
  // Strategy
  TAutenticacao = class abstract
    procedure Autenticar(Usario,Senha: string); virtual; abstract;
  end;

  // Concrete Strategy
  TAutenticacaoLocal = class(TAutenticacao)
    procedure Autenticar(Usario,Senha: string); override;
  end;

    // Concrete Strategy
  TAutenticacaoBD = class(TAutenticacao)
    procedure Autenticar(Usario,Senha: string); override;
  end;

    // Concrete Strategy
  TAutenticacaoWebService = class(TAutenticacao)
    procedure Autenticar(Usario,Senha: string); override;
  end;

  TContext = class
  strict private
    FAutenticacao: TAutenticacao;
  public
    procedure Autenticar(Usuario,Senha: string);
    constructor Create();
  end;


implementation

{ TAutenticacaoLocal }

procedure TAutenticacaoLocal.Autenticar(Usario, Senha: string);
begin
  WriteLn('Autenticado local');
end;

{ TAutenticacaoBD }

procedure TAutenticacaoBD.Autenticar(Usario, Senha: string);
begin
  WriteLn('Autenticado no BD');
end;

{ TAutenticacaoWebService }

procedure TAutenticacaoWebService.Autenticar(Usario, Senha: string);
begin
  WriteLn('Autenticado no Web Service');
end;

{ TContext }

procedure TContext.Autenticar(Usuario, Senha: string);
begin
  FAutenticacao.Autenticar(Usuario,Senha);
end;

constructor TContext.Create();
begin
  FAutenticacao := TAutenticacaoLocal.Create();
end;

end.
