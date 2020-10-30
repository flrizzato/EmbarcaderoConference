program State;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  aut: TAutenticacao;
begin
  aut := TAutenticacao.Create();
  aut.Usuario := 'guinther';
  aut.Usuario := '123456';
  aut.Tipo := TAutenticacaoWebService.Create();
  aut.Autenticar();
  readln;
end.
