program TemplateMethod;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  prv, red: TCorrecao;
begin
  prv := TCorrecaoProva.Create();
  prv.Processar();
  red := TCorrecaoRedacao.Create();
  red.Processar();
  readln;
end.
