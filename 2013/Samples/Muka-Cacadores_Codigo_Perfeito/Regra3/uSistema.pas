unit uSistema;

interface

uses uUsuario;

type
  TSistema = class
  private
    class function GetUsuario: TUsuario; static;
  public
    class property Usuario: TUsuario read GetUsuario;
  end;

implementation

{ TSistema }

class function TSistema.GetUsuario: TUsuario;
begin
  Result := TUsuario.Usuario;
end;

end.
