unit uAppLib;

interface

type
  TAppLib = class
    class function NumberFormat(value: string): double;
  end;

implementation

uses
  System.SysUtils, FMX.Dialogs;

{ TAppLib }

class function TAppLib.NumberFormat(value: string): double;
var s: string;
begin
  s := StringReplace(value, '.', '', [rfReplaceAll]);
  if not TryStrToFloat(s, result) then
    ShowMessage('Valor inválido!');
end;

end.
