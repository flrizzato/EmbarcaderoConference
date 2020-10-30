unit Utils;

interface

function Confirm(Msg: string): Boolean;

implementation

uses
  Dialogs, UITypes;

function Confirm(Msg: string): Boolean;
begin
  Result := MessageDlg(Msg, mtConfirmation, mbYesNoCancel, 0) = mrYes;
end;

end.
