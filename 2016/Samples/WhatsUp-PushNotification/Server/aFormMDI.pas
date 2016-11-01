unit aFormMDI;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFormMDI = class(TForm)
  private
    FID: integer;
    constructor CreateID(AOwner: TComponent; ID: integer);
  protected
    function CloseAllMDI: boolean;
  public
    class function CreateSingle(AOwner:TComponent; Id: Integer):TForm;
  end;

implementation

{$R *.dfm}

class function TFormMDI.CreateSingle(AOwner: TComponent; ID: Integer):TForm;
var
  i: integer;
begin
  result:= nil;
  for i:= 0 to Application.MainForm.MDIChildCount - 1 do
  if TFormMDI(Application.MainForm.MDIChildren[i]).FID = ID then
    result:= Application.MainForm.MDIChildren[i];
  if not assigned(result) then
    result:= CreateID(AOwner, ID);
end;

function TFormMDI.CloseAllMDI: boolean;
var
  i: integer;
begin
  for i:= MDIChildCount - 1 downto 0 do
    MDIChildren[i].Close;
  Application.ProcessMessages;
  result:= MDIChildCount = 0;
end;

constructor TFormMDI.CreateID(AOwner: TComponent; ID: integer);
begin
  inherited create(AOwner);
  FID:= ID;
end;

end.
