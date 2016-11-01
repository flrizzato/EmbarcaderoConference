unit uFramework;

interface

type
  // Handler
  TAutenticacao = class abstract
  strict protected
    FSucessor: TAutenticacao;
  public
    procedure SetSucessor(ASucessor: TAutenticacao);
    procedure Autenticar(Usuario,Senha: string); virtual; abstract;
  end;

  // Concrete Handler
  TAutenticacaoLocal = class(TAutenticacao)
    procedure Autenticar(Usuario,Senha: string); override;
  end;

    // Concrete Handler
  TAutenticacaoBD = class(TAutenticacao)
    procedure Autenticar(Usuario,Senha: string); override;
  end;

    // Concrete Handler
  TAutenticacaoWebService = class(TAutenticacao)
    procedure Autenticar(Usuario,Senha: string); override;
  end;

implementation

{ TAutenticacaoLocal }

procedure TAutenticacaoLocal.Autenticar(Usuario, Senha: string);
begin
  WriteLn('Autenticado local');
  if FSucessor <> nil then
    FSucessor.Autenticar(Usuario,Senha);
end;

{ TAutenticacaoBD }

procedure TAutenticacaoBD.Autenticar(Usuario, Senha: string);
begin
  WriteLn('Autenticado no BD');
  if FSucessor <> nil then
    FSucessor.Autenticar(Usuario,Senha);
end;

{ TAutenticacaoWebService }

procedure TAutenticacaoWebService.Autenticar(Usuario, Senha: string);
begin
  if FSucessor <> nil then
    FSucessor.Autenticar(Usuario,Senha);
  WriteLn('Autenticado no Web Service');
end;

{ TAutenticacao }

procedure TAutenticacao.SetSucessor(ASucessor: TAutenticacao);
begin
  self.FSucessor := ASucessor;
end;

end.
