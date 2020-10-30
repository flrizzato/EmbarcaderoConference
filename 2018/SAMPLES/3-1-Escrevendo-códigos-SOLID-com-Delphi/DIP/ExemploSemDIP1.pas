unit ExemploSemDIP1;

interface

type
  TDadosConta = class
  public
    procedure SetID(const ID: string);
    procedure SetSenha(const Senha: string);
    function ValidarAcesso: boolean;
  end;

  TLoginSistema = class
  private
    FCredenciais: TDadosConta;
  public
    procedure SetCredenciais(aCredenciais: TDadosConta);
    procedure FazerLogin;
  end;

implementation

{$REGION 'TDadosConta'}
{ TCredenciais }

procedure TDadosConta.SetID(const ID: string);
begin

end;

procedure TDadosConta.SetSenha(const Senha: string);
begin

end;

function TDadosConta.ValidarAcesso: boolean;
begin
  result := True;
end;
{$ENDREGION}

{ TLoginSistema }

procedure TLoginSistema.SetCredenciais(aCredenciais: TDadosConta);
begin
  FCredenciais := aCredenciais;
end;

procedure TLoginSistema.FazerLogin;
begin
  if FCredenciais.ValidarAcesso then
    // exibe mensagem de boas-vindas
end;

end.
