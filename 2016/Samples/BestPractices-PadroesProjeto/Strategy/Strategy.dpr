program Strategy;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  ctx: TContext;
begin
  ctx := TContext.Create();
  ctx.Autenticar('guinther','123456');
  readln;
end.
