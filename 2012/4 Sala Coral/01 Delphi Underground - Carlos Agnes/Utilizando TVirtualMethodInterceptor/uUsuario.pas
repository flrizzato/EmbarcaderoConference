unit uUsuario;

interface

type
  TUsuario = class
  public
    class procedure VerificarPermissao(const pNomePermissao: string);
  end;

implementation

uses
  FMX.Dialogs;

class procedure TUsuario.VerificarPermissao(const pNomePermissao: string);
begin
  ShowMessage('TUsuario.VerificarPermissao: ' + pNomePermissao);
end;

end.
