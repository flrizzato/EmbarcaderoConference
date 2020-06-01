unit uFrmBaseForm;

interface

uses
  SysUtils, Variants, Classes, ExtCtrls, Forms,
  DBCtrls,Controls;

type
  TMyWinControl = class(TWinControl);

  TFrmBaseForm = class(TForm)
    FadeIn: TTimer;
    FadeOut: TTimer;
    procedure FadeInTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FadeOutTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  protected
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBaseForm: TFrmBaseForm;

implementation

uses
  StdCtrls, Winapi.Windows, Winapi.Messages;

{$R *.dfm}

procedure TFrmBaseForm.FadeInTimer(Sender: TObject);
begin
  AlphaBlendValue := AlphaBlendValue + 15;
    FadeIn.Enabled := not (AlphaBlendValue = 255);
end;

procedure TFrmBaseForm.FadeOutTimer(Sender: TObject);
begin
//  AlphaBlendValue := AlphaBlendValue - 15;
//  if AlphaBlendValue = 0 then
    Close;
end;

procedure TFrmBaseForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action      := Cafree;
  FrmBaseForm := nil;
end;

procedure TFrmBaseForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
   VK_ESCAPE: FadeOut.Enabled := true;
   VK_RETURN: Perform(WM_NEXTDLGCTL,0,1);
  end;
end;

procedure TFrmBaseForm.FormShow(Sender: TObject);
begin
  AlphaBlendValue := 0;
  FadeIn.Enabled := true;
end;


end.
