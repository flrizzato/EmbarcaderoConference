unit uFrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Ani;

type
  TFrmMain = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Timer1: TTimer;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation3: TFloatAnimation;
    FloatAnimation4: TFloatAnimation;
    FloatAnimation5: TFloatAnimation;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FloatAnimation2Finish(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    PathAnimation1: TPathAnimation;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.fmx}

procedure TFrmMain.Button1Click(Sender: TObject);
begin
  Timer1.Enabled := not Timer1.Enabled;
  Button2.Enabled := not Timer1.Enabled;
  Button3.Enabled := not Timer1.Enabled;
end;

procedure TFrmMain.Button2Click(Sender: TObject);
begin
  if not FloatAnimation1.Running then
  begin
    FloatAnimation1.Start;
    FloatAnimation2.Start;
  end
  else
  begin
    FloatAnimation1.Stop;
    FloatAnimation2.Stop;
  end;
end;

procedure TFrmMain.Button3Click(Sender: TObject);
begin
  PathAnimation1.Start;
end;

procedure TFrmMain.FloatAnimation2Finish(Sender: TObject);
begin
 FloatAnimation3.Start;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FrmMain.Width := 500;
  FrmMain.Height := 500;
  FrmMain.Caption := 'FMX Timer Animation';
  Image1.Width := 100;
  Image1.Height := 100;
  Image1.Position.X := 0;
  Image1.Position.Y := 200;
  Button1.Position.X := 200;
  Button1.Position.Y := 240;
  Button2.Position.X := 300;
  Button2.Position.Y := 240;
  Button3.Position.X := 400;
  Button3.Position.Y := 240;
  Button1.Text := 'Timer';
  Button2.Text := 'FloatAnimation';
  Button3.Text := 'PathAnimation';

  Timer1 := TTimer.Create(Self);
  Timer1.Interval := 100;
  Timer1.OnTimer := Timer1Timer;
  Timer1.Enabled := False;

  FloatAnimation1.PropertyName := 'Position.X';
  FloatAnimation1.StartFromCurrent := True;
  FloatAnimation1.StopValue := Image1.Position.X + 400;
  FloatAnimation1.Duration := 4;
  FloatAnimation1.Loop := True;
  FloatAnimation1.AutoReverse := True;

  FloatAnimation2.PropertyName := 'Position.Y';
  FloatAnimation2.StartFromCurrent := True;
  FloatAnimation2.StopValue := Image1.Position.Y - 200;
  FloatAnimation2.Duration := 2;

  FloatAnimation3.PropertyName := 'Position.Y';
  FloatAnimation2.StartFromCurrent := True;
  FloatAnimation3.StopValue := Image1.Position.Y + 200;
  FloatAnimation3.Duration := 4;
  FloatAnimation3.Loop := True;
  FloatAnimation3.AutoReverse := True;

  PathAnimation1 := TPathAnimation.Create(Self);
  PathAnimation1.Parent := Image1;
  PathAnimation1.Path.MoveTo(PointF(0, 0));
  PathAnimation1.Path.LineTo(PointF(200,-200));
  PathAnimation1.Path.LineTo(PointF(400,0));
  PathAnimation1.Path.LineTo(PointF(200,200));
  PathAnimation1.Path.ClosePath;
  PathAnimation1.Loop := True;
  PathAnimation1.Duration := 8;
end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
begin
{ Move in diamond, clockwise }
  with Image1.Position do
  begin
    { Left to Top }
    if (X < 200) and (Y <= 200) then
    begin
      X := X + 10;
      Y := Y - 10;
    end
    { Top to Right }
    else if (X >= 200) and (Y < 200) then
    begin
      X := X + 10;
      Y := Y + 10;
    end
    { Right to Bottom }
    else if (X > 200) and (Y >= 200) then
    begin
      X := X - 10;
      Y := Y + 10;
    end
    { Bottom to Left }
    else
    begin
      X := X - 10;
      Y := Y - 10;
    end;
  end;
end;

end.
