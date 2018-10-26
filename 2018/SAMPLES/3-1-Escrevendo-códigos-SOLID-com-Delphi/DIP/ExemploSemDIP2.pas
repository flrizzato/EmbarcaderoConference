unit ExemploSemDIP2;

interface

type
  TDadosConta = class
  public
    procedure SetID(const ID: string);
    procedure SetSenha(const Senha: string);
    function ValidarAcesso: boolean;
  end;

  ILogin = interface
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

end.
