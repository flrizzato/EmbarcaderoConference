unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  System.Win.TaskbarCore, Vcl.Taskbar, Vcl.ExtCtrls, System.Actions,
  Vcl.ActnList;

type
  TForm1 = class(TForm)
    Taskbar1: TTaskbar;
    TrackBar1: TTrackBar;
    Button1: TButton;
    Image1: TImage;
    ActionList1: TActionList;
    Action1: TAction;
    procedure Button1Click(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Action1Execute(Sender: TObject);
begin
 ShowMessage('Embarcadero Conference!');
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: Integer;
begin
 Taskbar1.ProgressMaxValue := TrackBar1.Max;
 Taskbar1.ProgressValue := TrackBar1.Position;

 Taskbar1.OverlayIcon :=Image1.Picture.Icon;

 for i := 0 to 10000 do
 begin
  sleep(10);
  TrackBar1.Position := i;
 end;

 Form1.WindowState :=wsMinimized;

end;

end.
