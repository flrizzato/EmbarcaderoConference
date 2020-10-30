program Observer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  b: TBalanco;
  v: TVenda;
begin
  b := TBalanco.Create();
  v := TVenda.Create();
  v.SetBalanco(b);
  b.Attach(v);
  b.Iniciar();
  // b.Finalizar(); // comenta esta linha para testar
  v.Iniciar();
  v.Finalizar();
  readln;
end.
