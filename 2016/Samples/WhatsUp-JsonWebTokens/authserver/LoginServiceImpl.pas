unit LoginServiceImpl;

interface

uses
  LoginService,
  XData.Service.Common;

type
  [ServiceImplementation]
  TLoginService = class(TInterfacedObject, ILoginService)
  public
    function Login(const User, Password: string): string;
  end;

implementation

uses
  Bcl.JOSE.Core.Builder,
  Bcl.JOSE.Core.JWT,
  XData.Sys.Exceptions;

{ TLoginService }

function TLoginService.Login(const User, Password: string): string;
var
  JWT: TJWT;
begin
  if User <> Password then
    raise EXDataHttpUnauthorized.Create('Invalid password');

  JWT := TJWT.Create;
  try
    JWT.Claims.SetClaimOfType<string>('user', User);
    JWT.Claims.SetClaimOfType<boolean>('admin', User = 'admin');
    Result := TJOSE.SHA256CompactToken('super_secret', JWT);
  finally
    JWT.Free;
  end;
end;

initialization
  RegisterServiceType(TLoginService);
end.
