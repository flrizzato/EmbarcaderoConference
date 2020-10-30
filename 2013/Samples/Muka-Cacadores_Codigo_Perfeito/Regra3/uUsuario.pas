unit uUsuario;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  TUsuario = class
  private
    FNome: string;
    FSenha: string;
    class var FUsuario : TUsuario;
    class function GetUsuario: TUsuario; static;
  public
    property Nome: string read FNome write FNome;
    property Senha: string read FSenha write FSenha;
    class property Usuario : TUsuario read GetUsuario;
  end;

implementation

{ TUsuario }

class function TUsuario.GetUsuario: TUsuario;
begin
  if FUsuario = nil then
  begin
    FUsuario := TUsuario.Create;
  end;
  Result := FUsuario;
end;

initialization

finalization
  FreeAndNil(TUsuario.FUsuario);

end.
