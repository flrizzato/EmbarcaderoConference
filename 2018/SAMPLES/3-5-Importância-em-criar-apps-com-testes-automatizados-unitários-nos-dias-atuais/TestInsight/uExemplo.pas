unit uexemplo;

interface

type
{$M+}
  ILog = interface
    ['{1A69442D-CDDF-46B2-A7A7-E65545A91F72}']
    procedure Logar(ATexto: String);
  end;


type
  IUsuario = interface
    ['{96BDB0CE-F6C0-475D-B4A2-2870BB637E7D}']
    function NomeUsuario: String;
  end;
{$M-}

type
  TUsuario = class
  public
    function EhUsuarioValido(const pLog: ILog; const pUsuario : IUsuario): Boolean;
  end;

implementation


{ TUsuario }

function TUsuario.EhUsuarioValido(const pLog: ILog; const pUsuario: IUsuario): Boolean;
begin
  Result := False;
  if pUsuario.NomeUsuario = 'master' then
  begin
    Result := True;
    pLog.Logar('O usuário ' + pUsuario.NomeUsuario + ' entrou no sistema!');
  end
  else
    pLog.Logar('Usuário inválido.');
end;

end.
