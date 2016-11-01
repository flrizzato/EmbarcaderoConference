program Chain;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  local, web, bd: TAutenticacao;
begin
  local := TAutenticacaoLocal.Create();
  web := TAutenticacaoWebService.Create();
  bd := TAutenticacaoBD.Create();
  local.SetSucessor(web);
  web.SetSucessor(bd);
  local.Autenticar('guinther','123456');
  readln;
end.
