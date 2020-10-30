unit ExemploComDIP1;

interface

type
  ICredenciais = interface
    procedure SetID(const aID: string);
    procedure SetSenha(const aSenha: string);
    function ValidarAcesso: boolean;
  end;

  ILogin = interface
    procedure SetCredenciais(aCredenciais: ICredenciais);
    procedure FazerLogin;
  end;

  TLoginSistema = class(TInterfacedObject, ILogin)
  private
    FCredenciais: ICredenciais;
  public
    procedure SetCredenciais(aCredenciais: ICredenciais);
    procedure FazerLogin;
  end;

  TLoginApp = class(TInterfacedObject, ILogin)
  private
    FCredenciais: ICredenciais;
  public
    procedure SetCredenciais(aCredenciais: ICredenciais);
    procedure FazerLogin;
  end;

implementation

{ TLoginSistema }

procedure TLoginSistema.SetCredenciais(aCredenciais: ICredenciais);
begin
  FCredenciais := aCredenciais;
end;

procedure TLoginSistema.FazerLogin;
begin
  if FCredenciais.ValidarAcesso then
    // Exibe mensagem de boas-vindas e abre o sistema desktop
end;

{ TLoginApp }

procedure TLoginApp.FazerLogin;
begin
  if FCredenciais.ValidarAcesso then
    // Exibe notificação de entrada
end;

procedure TLoginApp.SetCredenciais(aCredenciais: ICredenciais);
begin
  FCredenciais := aCredenciais;
end;

end.
