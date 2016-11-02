{*******************************************************************************
*                                                                              *
*  TksCircleProgress - Circular Progress Component                             *
*                                                                              *
*  https://github.com/gmurt/KernowSoftwareFMX                                  *
*                                                                              *
*  Copyright 2016 Graham Murt                                                  *
*                                                                              *
*  email: graham@kernow-software.co.uk                                         *
*                                                                              *
*  Licensed under the Apache License, Version 2.0 (the "License");             *
*  you may not use this file except in compliance with the License.            *
*  You may obtain a copy of the License at                                     *
*                                                                              *
*    http://www.apache.org/licenses/LICENSE-2.0                                *
*                                                                              *
*  Unless required by applicable law or agreed to in writing, software         *
*  distributed under the License is distributed on an "AS IS" BASIS,           *
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    *
*  See the License for the specific language governing permissions and         *
*  limitations under the License.                                              *
*                                                                              *
*******************************************************************************}

unit ksCircleProgress;

interface

{$I ksComponents.inc}

uses Classes, ksTypes, FMX.Graphics, System.UITypes, System.UIConsts;

type
  TksCircleProgressCaptionType = (ksCirclePercent, ksCircleNone, ksCircleCustom);

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or
    {$IFDEF XE8_OR_NEWER} pidiOSDevice32 or pidiOSDevice64
    {$ELSE} pidiOSDevice {$ENDIF} or pidiOSSimulator or pidAndroid)]
  TksCircleProgress = class(TksControl)
  private
    FBitmap: TBitmap;
    FValue: single;
    FBackgroundColor: TAlphaColor;
    FColor: TAlphaColor;
    FCaptionType: TksCircleProgressCaptionType;
    FText: string;
    procedure RecreateBitmap;
    procedure SetValue(const Value: single);
    procedure SetColor(const Value: TAlphaColor);
    procedure SetBackgroundColor(const Value: TAlphaColor);
    procedure SetCaptionType(const Value: TksCircleProgressCaptionType);
    procedure SetText(const Value: string);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AnimateToValue(AValue: single; const ADurationSecs: integer = 1);
  published
    property CaptionType: TksCircleProgressCaptionType read FCaptionType write SetCaptionType default ksCirclePercent;
    property Height;
    property Width;
    property Size;
    property Position;
    property BackgroundColor: TAlphaColor read FBackgroundColor write SetBackgroundColor default claGainsboro;
    property Color: TAlphaColor read FColor write SetColor default claDodgerblue;
    property Value: single read FValue write SetValue;
    property Text: string read FText write SetText;
  end;

  procedure Register;

implementation

uses FMX.Controls, Math, SysUtils, Types, FMX.Types, FMX.Ani;

const
  C_SCALE = 3;

procedure Register;
begin
  RegisterComponents('Kernow Software FMX', [TksCircleProgress]);
end;


{ TksCircleProgress }

procedure TksCircleProgress.AnimateToValue(AValue: single; const ADurationSecs: integer = 1);
begin
  TAnimator.AnimateFloat(Self, 'Value', AValue, ADurationSecs);
end;

constructor TksCircleProgress.Create(AOwner: TComponent);
begin
  inherited;
  FBitmap := TBitmap.Create;
  FCaptionType := TksCircleProgressCaptionType.ksCirclePercent;
  FColor := claDodgerblue;
  FBackgroundColor := claGainsboro;
  FText := '';
  FValue := 0;
  Width := 150;
  Height := 150;
end;

destructor TksCircleProgress.Destroy;
begin
  FreeAndNil(FBitmap);
  inherited;
end;

procedure TksCircleProgress.Paint;
var
  r: TRectF;
  ACaption: string;
begin
  inherited;
  RecreateBitmap;
  r := RectF(0, 0, Width, Height);
  Canvas.DrawBitmap(FBitmap, RectF(0, 0, FBitmap.Width, FBitmap.Height), r, 1, True);


  ACaption := '';
  case FCaptionType of
    ksCirclePercent: ACaption := ' '+InTToStr(Round(FValue))+'%';
    ksCircleCustom: ACaption := Text;
  end;
  Canvas.Fill.Color := FColor;
  Canvas.Font.Size := 24;
  Canvas.FillText(ClipRect, ACaption, False, 1, [], TTextAlign.Center, TTextAlign.Center);
end;

procedure TksCircleProgress.RecreateBitmap;
var
  AAngle: single;
  x1, y1, x2, y2, x3, y3: single;
  AThickness: integer;
begin
  FBitmap.SetSize(Round(Width*C_SCALE), Round(Height*C_SCALE));
  FBitmap.Clear(claNull);
  FBitmap.Canvas.BeginScene(nil);
  try
    AAngle := 0;
    x1 := Round((Width * C_SCALE)/2);
    y1 := Round((Height * C_SCALE)/2);

    AThickness := Round(25 * C_SCALE);

    FBitmap.Canvas.StrokeThickness := 4;
    FBitmap.Canvas.Stroke.Color := FBackgroundColor;
    FBitmap.Canvas.Stroke.Kind := TBrushKind.Solid;

    while AAngle < 360 do
    begin


      x2 := x1 + (cos(DegToRad(AAngle-90)) * (((Width*C_SCALE)/2)-AThickness));
      y2 := y1 + (sin(DegToRad(AAngle-90)) * (((Height*C_SCALE)/2)-AThickness));
      x3 := x1 + (cos(DegToRad(AAngle-90)) * (((Width*C_SCALE)/2)-4));
      y3 := y1 + (sin(DegToRad(AAngle-90)) * (((Height*C_SCALE)/2)-4));

      FBitmap.Canvas.DrawLine(PointF(x2, y2), PointF(x3, y3), 1);
      AAngle := AAngle + 1;
    end;

    AAngle := 0;

    FBitmap.Canvas.StrokeThickness := 4;
    FBitmap.Canvas.Stroke.Color := FColor;
    FBitmap.Canvas.Stroke.Kind := TBrushKind.Solid;

    while AAngle < ((360 / 100) * FValue) do
    begin

      x2 := x1 + (cos(DegToRad(AAngle-90)) * (((Width*C_SCALE)/2)-AThickness));
      y2 := y1 + (sin(DegToRad(AAngle-90)) * (((Height*C_SCALE)/2)-AThickness));
      x3 := x1 + (cos(DegToRad(AAngle-90)) * (((Width*C_SCALE)/2)-4));
      y3 := y1 + (sin(DegToRad(AAngle-90)) * (((Height*C_SCALE)/2)-4));

      FBitmap.Canvas.DrawLine(PointF(x2, y2), PointF(x3, y3), 1);
      AAngle := AAngle + 1;
    end;

  finally
    FBitmap.Canvas.EndScene;
  end;
end;

procedure TksCircleProgress.SetBackgroundColor(const Value: TAlphaColor);
begin
  if FBackgroundColor <> Value then
  begin
    FBackgroundColor := Value;
    InvalidateRect(ClipRect);
  end;
end;

procedure TksCircleProgress.SetCaptionType(
  const Value: TksCircleProgressCaptionType);
begin
  if FCaptionType <> Value then
  begin
    FCaptionType := Value;
    InvalidateRect(ClipRect);
  end;
end;

procedure TksCircleProgress.SetColor(const Value: TAlphaColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    InvalidateRect(ClipRect);
  end;
end;

procedure TksCircleProgress.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    InvalidateRect(ClipRect);
  end;
end;

procedure TksCircleProgress.SetValue(const Value: single);
begin
  if FValue <> Value then
  begin
    FValue := Value;
    FValue := Max(FValue, 0);
    FValue := Min(FValue, 100);
    InvalidateRect(ClipRect);
  end;
end;

end.


