unit ExemploComDIP2;

interface

uses
  ExemploComDIP1;

type
  TCliente = class
  private
    function FactoryLogin: ILogin;
    function FactoryCredenciais: ICredenciais;
  public
    procedure Login;
  end;

implementation

{ TCliente }

{$REGION 'Factories'}

function TCliente.FactoryCredenciais: ICredenciais;
begin
  result := nil;
end;

function TCliente.FactoryLogin: ILogin;
begin
  result := nil;
end;

{$ENDREGION}

procedure TCliente.Login;
var
  Login: ILogin;
  Credenciais: ICredenciais;
begin
  Credenciais := FactoryCredenciais;
  Credenciais.SetID('andre.celestino');
  Credenciais.SetSenha('04102017');

  Login := FactoryLogin;
  Login.SetCredenciais(Credenciais);
  Login.FazerLogin;
end;

end.
