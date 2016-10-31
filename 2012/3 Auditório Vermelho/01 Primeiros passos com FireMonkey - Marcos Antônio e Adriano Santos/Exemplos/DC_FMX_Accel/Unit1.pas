
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Unit1;

interface

uses
  SysUtils, Types, UITypes, Classes, Variants, FMX_Types, FMX_Controls, FMX_Forms,
  FMX_Dialogs, FMX_Objects, FMX_Effects, Accelerometer;

type
  TForm1 = class(TForm)
    Ball: TCircle;
    Hole: TCircle;
    Score: TLabel;
    iOSAccelerometer1: TiOSAccelerometer;
    procedure FormCreate(Sender: TObject);
    procedure iOSAccelerometer1Accelerate(x, y, z: Double);
  private
    { Private declarations }
    procedure MoveBall(ax, ay : Double);
    procedure RandomizeHolePosition;
    procedure ResetBallPosition;
    procedure ChangeBallImage;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

var
  x, y : Single;
  vx, vy : Single;

procedure TForm1.ResetBallPosition;
begin
  x := 135;
  y := 215;
  vx := 0;
  vy := 0;
  Ball.Position.X := Round(x);
  Ball.Position.Y := Round(y);
end;

function VectorDistance2(const v1, v2: TPointF): Single;
begin
  Result := Sqr(v2.X-v1.X)+Sqr(v2.Y-v1.Y);
end;

var
  PngNo : Integer = 2;

procedure TForm1.ChangeBallImage;
var
  Stream : TStream;
begin
  Inc(PngNo);
  if PngNo > 5 then
    PngNo := 1;
  Stream := TResourceStream.Create(HInstance, 'PngImage_'+IntToStr(PngNo), RT_RCDATA);
  try
    Ball.Fill.Bitmap.Bitmap.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TForm1.MoveBall(ax, ay : Double);
var
  BallCenter, HoleCenter : TPointF;
begin
  vx := vx + 0.25*ax;
  vy := vy - 0.25*ay;

  x := x+vx;
  y := y+vy;

  if x < 0 then begin
    x := 0;
    vx := 0;
  end;
  if y < 0 then begin
    y := 0;
    vy := 0;
  end;
  if x > 320-Ball.Width then begin
    x := 320-Ball.Width;
    vx := 0;
  end;
  if y > 460-Ball.Width then begin
    y := 460-Ball.Width;
    vy := 0;
  end;

  Ball.Position.X := Round(x);
  Ball.Position.Y := Round(y);

  BallCenter.X := Ball.Position.X+Ball.Width/2;
  BallCenter.Y := Ball.Position.Y+Ball.Height/2;
  HoleCenter.X := Hole.Position.X+Hole.Width/2;
  HoleCenter.Y := Hole.Position.Y+Hole.Height/2;

  if VectorDistance2(BallCenter,HoleCenter) <= Sqr(10) then begin
    Score.Text := IntToStr(StrToInt(Score.Text)+1);
    ResetBallPosition;
    RandomizeHolePosition;
    ChangeBallImage;
  end;
end;

procedure TForm1.RandomizeHolePosition;
begin
  Hole.Position.X := Random(260)+1;
  Hole.Position.Y := Random(400)+1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ResetBallPosition;
end;

procedure TForm1.iOSAccelerometer1Accelerate(x, y, z: Double);
begin
  MoveBall(x,y);
end;

end.

