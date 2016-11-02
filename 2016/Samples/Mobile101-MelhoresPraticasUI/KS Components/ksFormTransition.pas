{*******************************************************************************
*                                                                              *
*  TksFormTransition - Animated Form Transition Component                      *
*                                                                              *
*  https://github.com/gmurt/KernowSoftwareFMX                                  *
*                                                                              *
*  Copyright 2015 Graham Murt                                                  *
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

unit ksFormTransition;

interface

{$I ksComponents.inc}

uses System.UITypes, FMX.Controls, FMX.Layouts, FMX.Objects, System.Classes,
  FMX.Types, Generics.Collections, FMX.Graphics, System.UIConsts, FMX.Effects,
  FMX.StdCtrls, System.Types, FMX.Forms, ksTypes;

const
  C_TRANSITION_DELAY = 0.3;
  C_TRANSITION_FADE  = 0.5;
  C_TRANSITION_PART_SCROLL_FACTOR = 0.3;
  C_INTERPOLATION_TYPE = TInterpolationType.Quadratic;
  C_ANIMATION_TYPE  = TAnimationType.InOut;

type
  TAnimateDirection = (ksAdHorizontal, ksAdVertical);

  TksFormTransitionType = (ksFtSlideInFromLeft,
                           ksFtSlideInFromTop,
                           ksFtSlideInFromRight,
                           ksFtSlideInFromBottom,
                           ksFtSlideOutToLeft,
                           ksFtSlideOutToTop,
                           ksFtSlideOutToRight,
                           ksFtSlideOutToBottom);

  TksFormImage = class(TImage)
  private
    FRectangle: TRectangle;
    procedure SetFade(const Value: single);
    function GetFade: single;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Fade;
    procedure UnFade;
  published
    property FadeValue: single read GetFade write SetFade;
  end;

  TksFormTransitionInfo = class
  private
    [weak]FFormFrom: TForm;
    [weak]FFormTo: TForm;
    FTransitionType: TksFormTransitionType;
    FBackgroundScroll: Boolean;
    function GetReverseTransition: TksFormTransitionType;
  public
    property FormFrom: TForm read FFormFrom write FFormFrom;
    property FormTo: TForm read FFormTo write FFormTo;
    property TransitionType: TksFormTransitionType read FTransitionType write FTransitionType;
    property ReverseTransition: TksFormTransitionType read GetReverseTransition;
    property BackgroundScroll: Boolean read FBackgroundScroll write FBackgroundScroll;
  end;

  TksFormTransitioIntoList = class(TObjectList<TksFormTransitionInfo>)
  public
    procedure AddTransition(AFrom, ATo: TForm; AType: TksFormTransitionType; ABackgroundScroll: Boolean);
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or
    {$IFDEF XE8_OR_NEWER} pidiOSDevice32 or pidiOSDevice64
    {$ELSE} pidiOSDevice {$ENDIF} or pidiOSSimulator or pidAndroid)]
  TksFormTransition = class(TksComponent)
  private
    FPreventAdd: Boolean;
    procedure AddBorder(ABmp: TBitmap; ABorder: TSide);
    procedure AnimateImage(AImage: TksFormImage; ADirection: TAnimateDirection;
      ANewValue: single; AWait: Boolean);
    class function GenerateFormImage(AForm: TForm): TBitmap;
    procedure PushForm(AFrom, ATo: TForm; ATransition: TksFormTransitionType; const ScrollBackgroundForm: Boolean = True);
    procedure PopForm(const Animate: Boolean = True);
    procedure PopAllForms;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  {$R *.dcr}

  procedure Register;

  procedure PushForm(AFrom, ATo: TForm; ATransition: TksFormTransitionType; const ScrollBackgroundForm: Boolean = True);
  procedure PopForm;
  procedure PopAllForms;
  procedure ClearTransitionTrail;

var
  TransitionFading: Boolean;

implementation

uses FMX.Ani, SysUtils, ksCommon;

var
  AAnimating: Boolean;
  ATransitionList: TksFormTransitioIntoList;


procedure Register;
begin
  RegisterComponents('Kernow Software FMX', [TksFormTransition]);
end;

procedure PushForm(AFrom, ATo: TForm; ATransition: TksFormTransitionType; const ScrollBackgroundForm: Boolean = True);
var
  ATran: TksFormTransition;
begin
  ATran := TksFormTransition.Create(nil);
  try
    ATran.PushForm(AFrom, ATo, ATransition, ScrollBackgroundForm);
  finally
    ATran.DisposeOf;
  end;
end;

procedure PopForm;
var
  ATran: TksFormTransition;
begin
  ATran := TksFormTransition.Create(nil);
  try
    ATran.PopForm;
  finally
    ATran.DisposeOf;
  end;
end;

procedure ClearTransitionTrail;
begin
  ATransitionList.Clear;
end;

procedure PopAllForms;
var
  ATran: TksFormTransition;
begin
  ATran := TksFormTransition.Create(nil);
  try
    ATran.PopAllForms;
  finally
    ATran.DisposeOf;
  end;
end;

procedure TksFormTransition.AddBorder(ABmp: TBitmap; ABorder: TSide);
{var
  ASides: TSides;
  ASaveState: TCanvasSaveState;
  ARect: TRectF;}
begin
 { ASides := [ABorder];
  ASaveState := ABmp.Canvas.SaveState;
  try
    ABmp.Canvas.BeginScene;
    try
      ARect := RectF(0, 0, ABmp.Width/GetScreenScale, ABmp.Height/GetScreenScale);
      ABmp.Canvas.IntersectClipRect(ARect);
      ABmp.Canvas.Stroke.Color := claSilver;
      ABmp.Canvas.Stroke.Thickness := GetScreenScale;
      ABmp.Canvas.DrawRectSides(ARect, 0, 0, AllCorners, 1, ASides);
    finally
      ABmp.Canvas.EndScene;
    end;
  finally
    ABmp.Canvas.RestoreState(ASaveState);
  end;
  Application.ProcessMessages;}
end;

procedure TksFormTransition.AnimateImage(AImage: TksFormImage; ADirection: TAnimateDirection;
  ANewValue: single; AWait: Boolean);
var
  AProperty: string;
begin

  case ADirection of
    ksAdHorizontal: AProperty := 'X';
    ksAdVertical: AProperty := 'Y';
  end;
  if AWait then
  begin
    AImage.BringToFront;
    //
  end;
  //Application.ProcessMessages;
  //AImage.Fade := 0;
  //if AFade then
 //   AImage.Fade;

  case AWait of
    False: TAnimator.AnimateFloat(AImage, 'Position.'+AProperty, ANewValue, C_TRANSITION_DELAY);
    True: TAnimator.AnimateFloatWait(AImage, 'Position.'+AProperty, ANewValue, C_TRANSITION_DELAY);
  end;
end;

constructor TksFormTransition.Create(AOwner: TComponent);
begin
  inherited;
  FPreventAdd := False;
end;

class function TksFormTransition.GenerateFormImage(AForm: TForm): TBitmap;
var
  AScale: single;
begin
  Result := TBitmap.Create;
  AScale := GetScreenScale;
  Result.BitmapScale := AScale;
  Result.Width := Round(AForm.Width * AScale);
  Result.Height := Round(AForm.Height * AScale);
  Result.Clear(claWhite);
  Result.Canvas.BeginScene;
  AForm.PaintTo(Result.Canvas);
  Result.Canvas.EndScene;
end;

procedure TksFormTransition.PopForm(const Animate: Boolean = True);
var
  AInfo: TksFormTransitionInfo;
begin
  if ATransitionList.Count = 0 then
    Exit;
  AInfo := ATransitionList.Last;

  FPreventAdd := True;
  //if Animate then
  PushForm(AInfo.FormTo, AInfo.FormFrom, AInfo.ReverseTransition, AInfo.BackgroundScroll);
  FPreventAdd := False;
  Application.ProcessMessages;
  ATransitionList.Delete(ATransitionList.Count-1);
end;

procedure TksFormTransition.PopAllForms;
var
  AFirst: TksFormTransitionInfo;
  ALast: TksFormTransitionInfo;
begin
  if ATransitionList.Count = 0 then
    Exit;
  ALast := ATransitionList.Last;
  AFirst := ATransitionList.First;
  FPreventAdd := True;
  //if Animate then
  PushForm(ALast.FormTo, AFirst.FormFrom, ALast.ReverseTransition, ALast.BackgroundScroll);
  FPreventAdd := False;
  ClearTransitionTrail;
  Application.ProcessMessages;
end;

procedure TksFormTransition.PushForm(AFrom, ATo: TForm;
  ATransition: TksFormTransitionType; const ScrollBackgroundForm: Boolean = True);
var
  AImageFrom: TksFormImage;
  AImageTo: TksFormImage;
  ABmp: TBitmap;
begin
  if AAnimating then
    Exit;
  AAnimating := True;

  if FPreventAdd = False then
    ATransitionList.AddTransition(AFrom, ATo, ATransition, ScrollBackgroundForm);


  AImageFrom := TksFormImage.Create(nil);
  AImageTo := TksFormImage.Create(nil);
  try
    ATo.SetBounds(AFrom.Left, AFrom.Top, AFrom.Width, AFrom.Height);
    AFrom.SetBounds(AFrom.Left, AFrom.Top, AFrom.Width, AFrom.Height);

    AImageFrom.Width := AFrom.Width;
    AImageFrom.Height := AFrom.Height;

    AImageTo.Width := ATo.Width;
    AImageTo.Height := ATo.Height;

    ABmp := TksFormTransition.GenerateFormImage(AFrom);
    try
      AImageFrom.Bitmap := ABmp;
    finally
      FreeAndNil(ABmp);
    end;
    AImageFrom.Position.X := 0;
    AImageFrom.Position.Y := 0;
    AFrom.AddObject(AImageFrom);

    AImageTo.Position.X := 0;
    AImageTo.Position.Y := 0;
    AFrom.AddObject(AImageTo);
    ABmp := TksFormTransition.GenerateFormImage(ATo);
    try
      AImageTo.Bitmap := ABmp;
    finally
      FreeAndNil(ABmp);
    end;

    case ATransition of
      ksFtSlideInFromLeft: AImageTo.Position.X := 0-AImageTo.Width;
      ksFtSlideInFromTop: AImageTo.Position.Y := 0-AImageTo.Height;
      ksFtSlideInFromRight: AImageTo.Position.X := AFrom.Width;
      ksFtSlideInFromBottom: AImageTo.Position.Y := AFrom.Height;

    end;

    if ScrollBackgroundForm then
    begin
      case ATransition of
        ksFtSlideOutToLeft: AImageTo.Position.X := (AImageTo.Width * C_TRANSITION_PART_SCROLL_FACTOR);
        ksFtSlideOutToTop: AImageTo.Position.Y := (AImageTo.Height * C_TRANSITION_PART_SCROLL_FACTOR);
        ksFtSlideOutToRight: AImageTo.Position.X := 0-(AImageTo.Width * C_TRANSITION_PART_SCROLL_FACTOR);
        ksFtSlideOutToBottom: AImageTo.Position.Y := 0-(AImageTo.Height * C_TRANSITION_PART_SCROLL_FACTOR);
      end;
    end;

    if (ATransition in [ksFtSlideOutToLeft, ksFtSlideOutToRight, ksFtSlideOutToBottom, ksFtSlideOutToTop]) then
      AImageFrom.BringToFront;

    Application.ProcessMessages;

    case ATransition of
      // slide ins...
      ksFtSlideInFromRight:
      begin
        AImageTo.BringToFront;
        AddBorder(AImageTo.Bitmap, TSide.Left);
        AImageFrom.Fade;
        if ScrollBackgroundForm then
          AnimateImage(AImageFrom, ksAdHorizontal, 0-(AImageFrom.Width * C_TRANSITION_PART_SCROLL_FACTOR), False);
          //TAnimator.AnimateFloat(AImageFrom, 'Fade', 0.5, C_TRANSITION_DELAY);
        AnimateImage(AImageTo, ksAdHorizontal, 0, True);
      end;

      ksFtSlideInFromLeft:
      begin
        AImageTo.BringToFront;
        AddBorder(AImageTo.Bitmap, TSide.Right);
        AImageFrom.Fade;
        if ScrollBackgroundForm then
          AnimateImage(AImageFrom, ksAdHorizontal, AImageFrom.Width * C_TRANSITION_PART_SCROLL_FACTOR, False);
        AnimateImage(AImageTo, ksAdHorizontal, 0, True);
      end;


      ksFtSlideInFromBottom:
      begin
        AddBorder(AImageTo.Bitmap, TSide.Top);
        AImageFrom.Fade;
        if ScrollBackgroundForm then
          AnimateImage(AImageFrom, ksAdVertical, 0-(AImageFrom.Height * C_TRANSITION_PART_SCROLL_FACTOR), False);
        AnimateImage(AImageTo, ksAdVertical, 0, True);
      end;

      ksFtSlideInFromTop:
      begin
        AddBorder(AImageTo.Bitmap, TSide.Bottom);
        AImageFrom.Fade;
        if ScrollBackgroundForm then
          AnimateImage(AImageFrom, ksAdVertical, AImageFrom.Height * C_TRANSITION_PART_SCROLL_FACTOR, False);
        AnimateImage(AImageTo, ksAdVertical, 0, True);
      end;

      // slide outs...
      ksFtSlideOutToLeft:
      begin
        AddBorder(AImageFrom.Bitmap, TSide.Right);
        AImageTo.UnFade;
        if ScrollBackgroundForm then
          AnimateImage(AImageTo, ksAdHorizontal, 0, False);
        AnimateImage(AImageFrom, ksAdHorizontal, 0-AImageFrom.Width, True);
      end;


      ksFtSlideOutToTop:
      begin
        AddBorder(AImageFrom.Bitmap, TSide.Bottom);
        AImageTo.UnFade;
        if ScrollBackgroundForm then
          AnimateImage(AImageTo, ksAdVertical, 0, False);
        AnimateImage(AImageFrom, ksAdVertical, 0-AImageFrom.Height, True);
      end;

      ksFtSlideOutToRight:
      begin
        AddBorder(AImageFrom.Bitmap, TSide.Left);
        AImageTo.UnFade;
        if ScrollBackgroundForm then
          AnimateImage(AImageTo, ksAdHorizontal, 0, False);
        AnimateImage(AImageFrom, ksAdHorizontal, AImageFrom.Width, True);
      end;

      ksFtSlideOutToBottom:
      begin
        AddBorder(AImageFrom.Bitmap, TSide.Top);
        AImageTo.UnFade;
        if ScrollBackgroundForm then
          AnimateImage(AImageTo, ksAdVertical, 0, False);
        AnimateImage(AImageFrom, ksAdVertical, AImageFrom.Height, True);
      end;
    end;
  finally
    ATo.Show;
    ATo.Invalidate;
    Application.ProcessMessages;
    AImageFrom.DisposeOf;
    AImageTo.DisposeOf;
    AFrom.Hide;
    AAnimating := False;
  end;
end;

{ TksFormTransitioIntoList }

procedure TksFormTransitioIntoList.AddTransition(AFrom, ATo: TForm; AType: TksFormTransitionType; ABackgroundScroll: Boolean);
var
  AInfo: TksFormTransitionInfo;
begin
  AInfo := TksFormTransitionInfo.Create;
  AInfo.FormFrom := AFrom;
  AInfo.FormTo := ATo;
  AInfo.TransitionType := AType;
  AInfo.BackgroundScroll := ABackgroundScroll;
  Add(AInfo);
end;

{ TksFormTransitionInfo }

function TksFormTransitionInfo.GetReverseTransition: TksFormTransitionType;
begin
  Result := ksFtSlideInFromLeft;
  case FTransitionType of
    ksFtSlideInFromLeft: Result := ksFtSlideOutToLeft;
    ksFtSlideInFromTop: Result := ksFtSlideOutToTop;
    ksFtSlideInFromRight: Result := ksFtSlideOutToRight;
    ksFtSlideInFromBottom: Result := ksFtSlideOutToBottom;

    ksFtSlideOutToLeft: Result := ksFtSlideInFromLeft;
    ksFtSlideOutToTop: Result := ksFtSlideInFromTop;
    ksFtSlideOutToRight: Result := ksFtSlideInFromRight;
    ksFtSlideOutToBottom: Result := ksFtSlideInFromBottom;
  end;

end;

{ TksFormImage }

constructor TksFormImage.Create(AOwner: TComponent);
begin
  inherited;
  FRectangle := TRectangle.Create(Self);
  FRectangle.Align := TAlignLayout.Client;
  FRectangle.Fill.Color := claBlack;
  FRectangle.Fill.Kind := TBrushKind.Solid;

  FRectangle.Opacity := 0;
  AddObject(FRectangle);
end;

destructor TksFormImage.Destroy;
begin
  {$IFDEF IOS}
  FRectangle.DisposeOf;
  {$ELSE}
  FRectangle.Free;
  {$ENDIF}
  inherited;
end;

procedure TksFormImage.Fade;
begin
  FRectangle.Opacity := 0;
  if TransitionFading then
    TAnimator.AnimateFloat(Self, 'FadeValue', C_TRANSITION_FADE, C_TRANSITION_DELAY);
end;

function TksFormImage.GetFade: single;
begin
  Result := FRectangle.Opacity;
end;

procedure TksFormImage.SetFade(const Value: single);
begin
  FRectangle.Opacity := Value;
end;

procedure TksFormImage.UnFade;
begin
  if TransitionFading = False then
  begin
    FRectangle.Opacity := 0;
    Exit;
  end;
  FRectangle.Opacity := C_TRANSITION_FADE;
  TAnimator.AnimateFloat(Self, 'FadeValue', 0, C_TRANSITION_DELAY);
end;

initialization

  ATransitionList := TksFormTransitioIntoList.Create;
  TransitionFading := True;

finalization

  FreeAndNil(ATransitionList);

end.


