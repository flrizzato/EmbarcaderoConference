unit ksCommon;


interface

uses FMX.Controls, FMX.Graphics, System.UITypes, FMX.Types, Types, System.UIConsts, ksTypes;

{$I ksComponents.inc}

  function GetScreenScale: single;
  procedure ProcessMessages;

  procedure ReplaceOpaqueColor(ABmp: TBitmap; Color : TAlphaColor);
  function GetColorOrDefault(AColor, ADefaultIfNull: TAlphaColor): TAlphaColor;

  procedure SimulateClick(AControl: TControl; x, y: single);


  function IsBlankBitmap(ABmp: TBitmap; const ABlankColor: TAlphaColor = claNull): Boolean;


  function GetTextSizeHtml(AText: string; AFont: TFont;
    const AWidth: single = 0): TPointF;

  function CalculateTextWidth(AText: string; AFont: TFont; AWordWrap: Boolean;
    const AMaxWidth: single = 0; const APadding: single = 0): single;

  function CalculateTextHeight(AText: string; AFont: TFont; AWordWrap: Boolean; ATrimming: TTextTrimming;
    const AWidth: single = 0; const APadding: single = 0): single;

  procedure RenderText(ACanvas: TCanvas; x, y, AWidth, AHeight: single;
    AText: string; AFont: TFont; ATextColor: TAlphaColor; AWordWrap: Boolean;
    AHorzAlign: TTextAlign; AVertAlign: TTextAlign; ATrimming: TTextTrimming;
    const APadding: single = 0); overload;

  procedure RenderText(ACanvas: TCanvas; ARect: TRectF;
    AText: string; AFont: TFont; ATextColor: TAlphaColor; AWordWrap: Boolean;
    AHorzAlign: TTextAlign; AVertAlign: TTextAlign; ATrimming: TTextTrimming;
    const APadding: single = 0); overload;

  procedure RenderHhmlText(ACanvas: TCanvas; x, y, AWidth, AHeight: single;
    AText: string; AFont: TFont; ATextColor: TAlphaColor; AWordWrap: Boolean;
    AHorzAlign: TTextAlign; AVertAlign: TTextAlign; ATrimming: TTextTrimming);

  procedure GenerateBadge(ACanvas: TCanvas; ATopLeft: TPointF; AValue: integer; AColor, ABackgroundColor, ATextColor: TAlphaColor);

implementation

uses FMX.Platform, FMX.Forms,  SysUtils, FMX.TextLayout, Math, FMX.Utils
  {$IFDEF IOS}
  , IOSApi.Foundation
  {$ENDIF}
  {$IFDEF USE_TMS_HTML_ENGINE} , FMX.TMSHTMLEngine {$ENDIF}
  ;

var
  AScreenScale: single;
  ATextLayout: TTextLayout;


function GetScreenScale: single;
var
  Service: IFMXScreenService;
begin
  if AScreenScale > 0 then
  begin
    Result := AScreenScale;
    Exit;
  end;
  Service := IFMXScreenService(TPlatformServices.Current.GetPlatformService(IFMXScreenService));

  Result := Service.GetScreenScale;

  {$IFDEF IOS}
  if Result < 2 then
   Result := 2;
  {$ENDIF}

  AScreenScale := Result;
end;


procedure ProcessMessages;
{$IFDEF IOS}
var
  TimeoutDate: NSDate;
begin
  TimeoutDate := TNSDate.Wrap(TNSDate.OCClass.dateWithTimeIntervalSinceNow(0.0));
  TNSRunLoop.Wrap(TNSRunLoop.OCClass.currentRunLoop).runMode(NSDefaultRunLoopMode, TimeoutDate);
end;
{$ELSE}
begin
  // FMX can occasionally raise an exception.
  try
    Application.ProcessMessages;
  except
    //
  end;
end;
{$ENDIF}

function GetColorOrDefault(AColor, ADefaultIfNull: TAlphaColor): TAlphaColor;
begin
  Result := AColor;
  if Result = claNull then
    Result := ADefaultIfNull;
end;

function IsBlankBitmap(ABmp: TBitmap; const ABlankColor: TAlphaColor = claNull): Boolean;
var
  ABlank: TBitmap;
begin
  ABlank := TBitmap.Create(ABmp.Width, ABmp.Height);
  try
    ABlank.Clear(ABlankColor);
    Result := ABmp.EqualsBitmap(ABlank);
  finally
    FreeAndNil(ABlank);
  end;
end;

procedure RenderText(ACanvas: TCanvas; x, y, AWidth, AHeight: single;
  AText: string; AFont: TFont; ATextColor: TAlphaColor; AWordWrap: Boolean;
  AHorzAlign: TTextAlign; AVertAlign: TTextAlign; ATrimming: TTextTrimming;
  const APadding: single = 0); overload;
begin
  if AText = '' then
    Exit;
  ATextLayout.BeginUpdate;
  ATextLayout.Text := AText;
  ATextLayout.WordWrap := AWordWrap;
  ATextLayout.Font.Assign(AFont);
  ATextLayout.Color := ATextColor;
  ATextLayout.HorizontalAlign := AHorzAlign;
  ATextLayout.VerticalAlign := AVertAlign;
  ATextLayout.Padding.Rect := RectF(APadding, APadding, APadding, APadding);
  ATextLayout.Trimming := ATrimming;
  if AWordWrap  then
    ATextLayout.Trimming := TTextTrimming.None;
  ATextLayout.TopLeft := PointF(x, y);
  ATextLayout.MaxSize := PointF(AWidth, AHeight);
  ATextLayout.EndUpdate;
  ATextLayout.RenderLayout(ACanvas);
end;

procedure RenderText(ACanvas: TCanvas; ARect: TRectF;
  AText: string; AFont: TFont; ATextColor: TAlphaColor; AWordWrap: Boolean;
  AHorzAlign: TTextAlign; AVertAlign: TTextAlign; ATrimming: TTextTrimming;
  const APadding: single = 0); overload;
begin
  RenderText(ACanvas, ARect.Left, ARect.Top, ARect.Width, ARect.Height, AText, AFont, ATextColor, AWordWrap, AHorzAlign, AVertAlign, ATrimming, APadding);
end;

function GetTextSizeHtml(AText: string; AFont: TFont;
  const AWidth: single = 0): TPointF;
{$IFDEF USE_TMS_HTML_ENGINE}
var
  AnchorVal, StripVal, FocusAnchor: string;
  XSize, YSize: single;
  HyperLinks, MouseLink: integer;
  HoverRect: TRectF;
  ABmp: TBitmap;
{$ENDIF}
begin
  Result := PointF(0, 0);
{$IFDEF USE_TMS_HTML_ENGINE}
  XSize := AWidth;

  if XSize <= 0 then
    XSize := MaxSingle;

  ABmp := TBitmap.Create(10, 10);
  try
    ABmp.BitmapScale := GetScreenScale;
    ABmp.Canvas.Assign(AFont);
{$IFDEF USE_TMS_HTML_ENGINE}
    HTMLDrawEx(ABmp.Canvas, AText, RectF(0, 0, XSize, MaxSingle), 0, 0, 0, 0, 0,
      False, False, False, False, False, False, False, 1, claNull, claNull,
      claNull, claNull, AnchorVal, StripVal, FocusAnchor, XSize, YSize,
      HyperLinks, MouseLink, HoverRect, 1, nil, 1);
    Result := PointF(XSize, YSize);
{$ELSE}
    Result := PointF(0, 0);
{$ENDIF}
  finally
    FreeAndNil(ABmp);
  end;
{$ENDIF}
end;

function CalculateTextWidth(AText: string; AFont: TFont; AWordWrap: Boolean;
  const AMaxWidth: single = 0; const APadding: single = 0): single;
var
  APoint: TPointF;
begin
  ATextLayout.BeginUpdate;
  // Setting the layout MaxSize
  if AMaxWidth > 0 then
    APoint.X := AMaxWidth
  else
    APoint.x := MaxSingle;
  APoint.y := 100;
  ATextLayout.MaxSize := APoint;
  ATextLayout.Text := AText;
  ATextLayout.WordWrap := AWordWrap;
  ATextLayout.Padding.Rect := RectF(APadding, APadding, APadding, APadding);
  ATextLayout.Font.Assign(AFont);
  ATextLayout.HorizontalAlign := TTextAlign.Leading;
  ATextLayout.VerticalAlign := TTextAlign.Leading;
  ATextLayout.EndUpdate;
  //ATextLayout.RenderLayout(ATextLayout.LayoutCanvas);
  Result := ATextLayout.Width;
end;

function CalculateTextHeight(AText: string; AFont: TFont; AWordWrap: Boolean; ATrimming: TTextTrimming;
  const AWidth: single = 0; const APadding: single = 0): single;
var
  APoint: TPointF;
begin
  Result := 0;
  if AText = '' then
    Exit;
  ATextLayout.BeginUpdate;
  // Setting the layout MaxSize
  APoint.x := MaxSingle;
  if AWidth > 0 then
    APoint.x := AWidth;
  APoint.y := MaxSingle;
  ATextLayout.Font.Assign(AFont);
  ATextLayout.Trimming := ATrimming;
  ATextLayout.MaxSize := APoint;
  ATextLayout.Text := AText;
  ATextLayout.WordWrap := AWordWrap;
  ATextLayout.Padding.Rect := RectF(APadding, APadding, APadding, APadding);
  ATextLayout.HorizontalAlign := TTextAlign.Leading;
  ATextLayout.VerticalAlign := TTextAlign.Leading;
  ATextLayout.EndUpdate;
  Result := ATextLayout.Height;
end;

procedure RenderHhmlText(ACanvas: TCanvas; x, y, AWidth, AHeight: single;
  AText: string; AFont: TFont; ATextColor: TAlphaColor; AWordWrap: Boolean;
  AHorzAlign: TTextAlign; AVertAlign: TTextAlign; ATrimming: TTextTrimming);
{$IFDEF USE_TMS_HTML_ENGINE}
var
  AnchorVal, StripVal, FocusAnchor: string;
  XSize, YSize: single;
  HyperLinks, MouseLink: integer;
  HoverRect: TRectF;
{$ENDIF}
begin
{$IFDEF USE_TMS_HTML_ENGINE}
  ACanvas.Fill.Color := ATextColor;
  ACanvas.Font.Assign(AFont);
  HTMLDrawEx(ACanvas, AText, RectF(x, y, x + AWidth, y + AHeight), 0, 0, 0, 0,
    0, False, False, True, False, False, False, AWordWrap, 1, claNull, claNull,
    claNull, claNull, AnchorVal, StripVal, FocusAnchor, XSize, YSize,
    HyperLinks, MouseLink, HoverRect, 1, nil, 1);
{$ELSE}
  AFont.Size := 10;
  RenderText(ACanvas, x, y, AWidth, AHeight, 'Requires TMS FMX', AFont,
    ATextColor, AWordWrap, AHorzAlign, AVertAlign, ATrimming);
{$ENDIF}
end;
        {
procedure DrawAccessory(ACanvas: TCanvas; ARect: TRectF; AAccessory: TksAccessoryType;
  AStroke, AFill: TAlphaColor);
var
  AState: TCanvasSaveState;
begin
  AState := ACanvas.SaveState;
  try
    ACanvas.IntersectClipRect(ARect);
    ACanvas.Fill.Color := AFill;
    ACanvas.Fill.Kind := TBrushKind.Solid;
    ACanvas.FillRect(ARect, 0, 0, AllCorners, 1);
    AccessoryImages.GetAccessoryImage(AAccessory).DrawToCanvas(ACanvas, ARect, False);
    ACanvas.Stroke.Color := AStroke;
    ACanvas.DrawRect(ARect, 0, 0, AllCorners, 1);
  finally
    ACanvas.RestoreState(AState);
  end;
end;    }

procedure ReplaceOpaqueColor(ABmp: TBitmap; Color : TAlphaColor);
var
  x,y: Integer;
  AMap: TBitmapData;
  PixelColor: TAlphaColor;
  PixelWhiteColor: TAlphaColor;
  C: PAlphaColorRec;
begin
  if (Assigned(ABmp)) then
  begin
    if ABmp.Map(TMapAccess.ReadWrite, AMap) then
    try
      AlphaColorToPixel(Color   , @PixelColor, AMap.PixelFormat);
      AlphaColorToPixel(claWhite, @PixelWhiteColor, AMap.PixelFormat);
      for y := 0 to ABmp.Height - 1 do
      begin
        for x := 0 to ABmp.Width - 1 do
        begin
          C := @PAlphaColorArray(AMap.Data)[y * (AMap.Pitch div 4) + x];
          if (C^.Color<>claWhite) and (C^.A>0) then
            C^.Color := PremultiplyAlpha(MakeColor(PixelColor, C^.A / $FF));
        end;
      end;
    finally
      ABmp.Unmap(AMap);
    end;
  end;
end;

procedure SimulateClick(AControl: TControl; x, y: single);
var
  AForm     : TCommonCustomForm;
  AFormPoint: TPointF;
begin
  AForm := nil;
  if (AControl.Root is TCustomForm) then
    AForm := (AControl.Root as TCustomForm);
  if AForm <> nil then
  begin
    AFormPoint := AControl.LocalToAbsolute(PointF(X,Y));
    AForm.MouseDown(TMouseButton.mbLeft, [], AFormPoint.X, AFormPoint.Y);
    AForm.MouseUp(TMouseButton.mbLeft, [], AFormPoint.X, AFormPoint.Y);
  end;
end;

procedure GenerateBadge(ACanvas: TCanvas; ATopLeft: TPointF; AValue: integer; AColor, ABackgroundColor, ATextColor: TAlphaColor);

  procedure DrawEllipse(ACanvas: TCanvas; ARect: TRectF; AColor: TAlphaColor);
  begin
    ACanvas.Fill.Color := AColor;
    ACanvas.FillEllipse(ARect, 1);
    ACanvas.Stroke.Color := AColor;
    ACanvas.StrokeThickness := 1;
    ACanvas.DrawEllipse(ARect, 1);
  end;
var
  ABmp: TBitmap;
  AOutlineRect: TRectF;
  ARect: TRectF;
  r, r2: TRectF;
  s: single;
begin
  s := GetScreenScale;
  ABmp := TBitmap.Create(Round(32*s), Round(32*s));
  try
    ARect := RectF(ATopLeft.X, ATopLeft.Y, ATopLeft.X + 16, ATopLeft.Y + 16);

    AOutlineRect := ARect;
    InflateRect(AOutlineRect, GetScreenScale, GetScreenScale);

    ABmp.Clear(claNull);
    ABmp.Canvas.BeginScene;
    r := RectF(2, 2, 30*s, 30*s);
    r2 := RectF(0, 0, 32*s, 32*s);
    DrawEllipse(ABmp.Canvas, r2, ABackgroundColor);
    DrawEllipse(ABmp.Canvas, r, AColor);
    ABmp.Canvas.EndScene;
    ACanvas.DrawBitmap(ABmp, RectF(0, 0, ABmp.Width, ABmp.Height), ARect, 1, False);
    ACanvas.Fill.Color := ATextColor;
    ACanvas.Font.Size := 9;
    ACanvas.FillText(ARect, IntToStr(AValue), False, 1, [], TTextAlign.Center);
  finally
    FreeAndNil(ABmp);
  end;
end;

initialization

  AScreenScale := 0;
  ATextLayout := TTextLayoutManager.DefaultTextLayout.Create;

finalization

  FreeAndNil(ATextLayout);


end.

