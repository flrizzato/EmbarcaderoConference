unit uAppLib;

interface

uses
  FMX.Forms;

type
  TAppLib = class
    class function NumberFormat(value: string): double;
    class procedure ChangeReadOnly(form: TForm; bValue: boolean);
  end;

implementation

uses
  System.SysUtils, FMX.Dialogs, FMX.Edit;

{ TAppLib }

class procedure TAppLib.ChangeReadOnly(form: TForm; bValue: boolean);
var
  i: Integer;
begin
  for i := 0 to form.ComponentCount-1 do
    if form.Components[i].Tag = 99 then
      TEdit(form.Components[i]).ReadOnly := bValue;
end;

class function TAppLib.NumberFormat(value: string): double;
var s: string;
begin
  s := StringReplace(value, '.', '', [rfReplaceAll]);
  if not TryStrToFloat(s, result) then
    ShowMessage('Valor inválido!');
end;

end.
