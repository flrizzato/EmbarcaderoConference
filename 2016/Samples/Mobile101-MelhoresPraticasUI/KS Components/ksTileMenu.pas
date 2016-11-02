{*******************************************************************************
*                                                                              *
*  TksTileMenu - tile menu compoonent                                          *
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
*  See the License forthe specific language governing permissions and          *
*  limitations under the License.                                              *
*                                                                              *
*******************************************************************************}


unit ksTileMenu;

interface

{$I ksComponents.inc}

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Graphics,
  System.Types, System.Generics.Collections, System.UITypes, ksTypes
  {$IFDEF XE8_OR_NEWER}
  , FMX.ImgList
  {$ENDIF}
  ;

type
  TksTileMenu = class;

  TksMenuOptionClickEvent = procedure(Sender: TObject; AIndex: integer; AID: string) of object;

  TksTileMenuOptionItem = class
  private
    [weak]FTileMenu: TksTileMenu;
    FBitmap: TBitmap;
    FText: string;
    FId: string;
    FFill: TAlphaColor;
    FTextColor: TAlphaColor;
    FRow: integer;
    FCol: integer;
    FIndex: integer;
    FMouseDown: Boolean;
    procedure SetBitmap(const Value: TBitmap);
    procedure SetText(const Value: string);
    procedure SetFill(const Value: TAlphaColor);
    procedure SetTextColor(const Value: TAlphaColor);
    function GetTileRect: TRectF;
    procedure MouseDown;
    procedure MouseUp;
    function AlterColor(const Color: TAlphaColor; const Pct: Single): TAlphaColor;
    function AlterColorChannel(const Channel: Byte; const Pct: Single): Byte;
    procedure ReplaceOpaqueColor(ABmp: TBitmap; Color: TAlphaColor);
  public
    constructor Create(ATileMenu: TksTileMenu); virtual;
    destructor Destroy; override;
    procedure DrawToCanvas(ACanvas: TCanvas);
    property Text: string read FText write SetText;
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property ID: string read FId write FId;
    property Fill: TAlphaColor read FFill write SetFill;
    property TextColor: TAlphaColor read FTextColor write SetTextColor;
    property Row: integer read FRow;
    property Col: integer read FCol;
    property Index: integer read FIndex write FIndex;
    property TileRect: TRectF read GetTileRect;

  end;

  TksTileMenuOptionItemList = class(TObjectList<TksTileMenuOptionItem>)
  private
    FMainMenu: TksTileMenu;
  public
    constructor Create(AMainMenu: TksTileMenu);
    function TileFromXY(x, y: single): TksTileMenuOptionItem;
    procedure AddOption(AText, AId: string; AColor, ATextColor: TAlphaColor; AImage: TBitmap); overload;
    {$IFDEF XE8_OR_NEWER}
    procedure AddOption(AText, AId: string; AColor, ATextColor: TAlphaColor; AImageIndex: integer); overload;
    {$ENDIF}
  end;


  TksTileMenuTileOptions = class(TPersistent)
  private
    [weak]FMenu: TksTileMenu;
    FTileRows: integer;
    FTileColumns: integer;
    FTilePadding: integer;
    FShowCaptions: Boolean;
    procedure SetShowCaptions(const Value: Boolean);
    procedure SetTileColumns(const Value: integer);
    procedure SetTilePadding(const Value: integer);
    procedure SetTileRows(const Value: integer);
    procedure RecreateMenu;
  public
    constructor Create(AMainMenu: TksTileMenu);

  published
    property TileRows: integer read FTileRows write SetTileRows default 3;
    property TileColumns: integer read FTileColumns write SetTileColumns default 2;
    property TilePadding: integer read FTilePadding write SetTilePadding default 10;
    property ShowCaptions: Boolean read FShowCaptions write SetShowCaptions default True;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or
    {$IFDEF XE8_OR_NEWER} pidiOSDevice32 or pidiOSDevice64
    {$ELSE} pidiOSDevice {$ENDIF} or pidiOSSimulator or pidAndroid)]
  TksTileMenu = class(TksControl)
  private
    FPainting: Boolean;
    FBackground: TBrush;
    FTileOptions: TksTileMenuTileOptions;
    FItems: TksTileMenuOptionItemList;
    {$IFDEF XE8_OR_NEWER}
    FImages: TImageList;
    {$ENDIF}
    FOnOptionClicked: TksMenuOptionClickEvent;
    procedure RecreateMenu;
    procedure SetTileOptions(const Value: TksTileMenuTileOptions);
    //procedure DrawTileOutline(ACanvas: TCanvas; ACol, ARow: integer);
    procedure GetTileRects(ACol, ARow: integer; var ATile, AGraphic, AText: TRectF);
    //procedure ClickTile(Sender: TObject; x, y: single; AIndex: integer; AId: string);
    {$IFDEF XE8_OR_NEWER}
    procedure SetImages(const Value: TImageList);
    {$ENDIF}
    procedure SetBackground(const Value: TBrush);
    function GetBackground: TBrush;
    { Private declarations }
  protected
    procedure Resize; override;
    procedure Paint; override;
    function GetColWidth: single;
    function GetRowHeight: single;
    function GetTileRowCount: integer;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;

    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Items: TksTileMenuOptionItemList read FItems;
    { Public declarations }
  published
    property Align;
    property Background: TBrush read GetBackground write SetBackground;
    {$IFDEF XE8_OR_NEWER}
    property Images: TImageList read FImages write SetImages;
    {$ENDIF}
    property TileOptions: TksTileMenuTileOptions read FTileOptions write SetTileOptions;
    property Position;
    property Size;
    property OnOptionClicked: TksMenuOptionClickEvent read FOnOptionClicked write FOnOptionClicked;
    { Published declarations }
  end;

  {$R *.dcr}

procedure Register;

implementation

uses System.UIConsts, Math, FMX.MultiResBitmap, FMX.Forms, FMX.Utils;

const
  MaxBytePercent = 2.55;

procedure Register;
begin
  RegisterComponents('Kernow Software FMX', [TksTileMenu]);
end;

{ TksMainMenu }
     {
procedure TksTileMenu.ClickTile(Sender: TObject; x, y: single; AIndex: integer; AId: string);
begin
  if Assigned(FOnOptionClicked) then
  begin
    FOnOptionClicked(Self, AIndex, AId);
  end;
end;  }

function TksTileMenuOptionItem.AlterColorChannel(const Channel: Byte; const Pct: Single): Byte;
var
  Temp: Integer;
  ABrighter: Boolean;
begin
  ABrighter := Pct > 0;
  if ABrighter then
  begin
    Temp := Round(Channel + (Pct * MaxBytePercent));
    if Temp > High(Result) then
      Result := High(Result)
    else
      Result := Temp;
  end
  else
  begin
    Temp := Round(Channel - (Pct * (0-MaxBytePercent)));
    if Temp < Low(Result) then
      Result := Low(Result)
    else
      Result := Temp;
  end;
end;

function TksTileMenuOptionItem.AlterColor(const Color: TAlphaColor; const Pct: Single): TAlphaColor;
var
  r,g,b: Byte;
begin
  Result := Color;
  r := TAlphaColorRec(Result).R;
  g := TAlphaColorRec(Result).G;
  b := TAlphaColorRec(Result).B;

  r := AlterColorChannel(r, Pct);
  g := AlterColorChannel(g, Pct);
  b := AlterColorChannel(b, Pct);

  TAlphaColorRec(Result).R := r;
  TAlphaColorRec(Result).G := g;
  TAlphaColorRec(Result).B := b;
end;


constructor TksTileMenu.Create(AOwner: TComponent);
begin
  inherited;
  FTileOptions := TksTileMenuTileOptions.Create(Self);
  FBackground := TBrush.Create(TBrushKind.None, claWhite);
  FItems := TksTileMenuOptionItemList.Create(Self);
  FPainting := False;
end;

destructor TksTileMenu.Destroy;
begin
  FreeAndNil(FTileOptions);
  FreeAndNil(FItems);
  FreeAndNil(FBackground);
  inherited;
end;

function TksTileMenu.GetBackground: TBrush;
begin
  Result := FBackground;
end;

function TksTileMenu.GetColWidth: single;
begin
  Result := (Width / FTileOptions.TileColumns);
end;

function TksTileMenu.GetRowHeight: single;
begin
  //Result := (Height / FTileOptions.FTileRows);
  Result := GetColWidth;
end;

procedure TksTileMenu.GetTileRects(ACol, ARow: integer; var ATile: TRectF; var AGraphic: TRectF; var AText: TRectF);
var
  AWidth, AHeight: Single;
begin
  AWidth := GetColWidth;
  AHeight := GetRowHeight;
  ATile := RectF(0, 0, AWidth, AHeight);
  InflateRect(ATile, 0-FTileOptions.TilePadding, 0-FTileOptions.TilePadding);

  OffsetRect(ATile, (ACol-1) * AWidth, (ARow-1)*AHeight);

  AGraphic := ATile;
  AGraphic.Height := 32; //ATile.Height - 30;
  AGraphic.Width := 32;

  OffsetRect(AGraphic, (ATile.Width - AGraphic.Width) / 2, (ATile.Height - AGraphic.Height) / 3);

  AText := AGraphic;
  AText.Left := ATile.Left;
  AText.Width := ATile.Width;
  AText.Top := AGraphic.Bottom;

  AText.Bottom := ATile.Bottom;
end;

function TksTileMenu.GetTileRowCount: integer;
begin
  Result := Round((FItems.Count / FTileOptions.TileColumns) + 0.5);
end;

procedure TksTileMenu.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  ATile: TksTileMenuOptionItem;
begin
  inherited;
  ATile := FItems.TileFromXY(x, y);
  if ATile = nil then
    Exit;

  ATile.MouseDown;

end;

procedure TksTileMenu.Mouseup(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  ATile: TksTileMenuOptionItem;
begin
  inherited;
  ATile := FItems.TileFromXY(x, y);
  if ATile = nil then
    Exit;

  ATile.MouseUp;

  if Assigned(FOnOptionClicked) then
    FOnOptionClicked(Self, ATile.Index, ATile.ID);
end;

procedure TksTileMenu.Paint;
var
  ICount: integer;
begin
  begin
    if not FPainting then
    begin
      FPainting := True;
      try
        // design-time border
        if (csDesigning in ComponentState) then
        begin
          Canvas.Stroke.Color := claBlack;
          Canvas.Stroke.Dash := TStrokeDash.Dash;
          Canvas.StrokeThickness := 1;
          Canvas.DrawRect(RectF(0, 0, Width, Height), 0, 0, AllCorners, 1);
        end;

        Canvas.Fill.Assign(FBackground);
        Canvas.FillRect(RectF(0, 0, Width, Height), 0, 0, AllCorners, 1);


        {for ICountY := 1 to FTileOptions.TileRows do
        begin
          for ICountX := 1 to FTileOptions.TileColumns do
          begin
            DrawTileOutline(Canvas, ICountX, ICountY);

          end;
        end;}

        RecreateMenu;
        for ICount := 0 to FItems.Count-1 do
        begin
          FItems[ICount].DrawToCanvas(Canvas);
        end;


      finally
        FPainting := False;
      end;
    end;
  end;
end;

procedure TksTileMenu.RecreateMenu;
var
  ICount: integer;

  ACol, ARow: integer;
begin
  if (csDesigning in ComponentState) then
    Exit;

  ACol := 1;
  ARow := 1;

  for ICount := 0 to FItems.Count-1 do
  begin
    with FItems[ICount] do
    begin
      FCol := ACol;
      FRow := ARow;
      Index := ICount;
    end;

    if ACol = FTileOptions.TileColumns then
    begin
      Inc(ARow);
      ACol := 1;
    end
    else
      Inc(ACol);
  end;
end;

procedure TksTileMenu.Resize;
begin
  inherited;
  RecreateMenu;
end;

procedure TksTileMenu.SetBackground(const Value: TBrush);
begin
  FBackground.Assign(Value);
end;

{$IFDEF XE8_OR_NEWER}

procedure TksTileMenu.SetImages(const Value: TImageList);
begin
  FImages := Value;
end;

{$ENDIF}

procedure TksTileMenu.SetTileOptions(const Value: TksTileMenuTileOptions);
begin
  FTileOptions.Assign(Value);
end;

{ TksMainMenuTileOptions }

constructor TksTileMenuTileOptions.Create(AMainMenu: TksTileMenu);
begin
  inherited Create;
  FMenu := AMainMenu;
  FTileColumns := 2;
  FTileRows := 3;
  FTilePadding := 10;
  FShowCaptions := True;

end;

procedure TksTileMenuTileOptions.RecreateMenu;
begin
  FMenu.RecreateMenu;
end;

procedure TksTileMenuTileOptions.SetShowCaptions(const Value: Boolean);
begin
  FShowCaptions := Value;
end;

procedure TksTileMenuTileOptions.SetTileColumns(const Value: integer);
begin
  if FTileColumns <> Value then
  begin
    FTileColumns := Value;
    if FTileColumns < 1 then
      FTileColumns := 1;
    RecreateMenu;
  end;
end;

procedure TksTileMenuTileOptions.SetTilePadding(const Value: integer);
begin
  if FTilePadding <> Value then
  begin
    FTilePadding := Value;
    RecreateMenu;
  end;
end;

procedure TksTileMenuTileOptions.SetTileRows(const Value: integer);
begin
  if FTileRows <> Value then
  begin
    FTileRows := Value;
    if FTileRows < 1 then
      FTileRows := 1;
    RecreateMenu;
  end;
end;

{ TksTileMenuOptionItem }

constructor TksTileMenuOptionItem.Create(ATileMenu: TksTileMenu);
begin
  inherited Create;
  FTileMenu := ATileMenu;
  FBitmap := TBitmap.Create;
  FText := '';
  FId := '';
  FMouseDown := False;
end;

destructor TksTileMenuOptionItem.Destroy;
begin
  FreeAndNil(FBitmap);
  inherited;
end;

procedure TksTileMenuOptionItem.ReplaceOpaqueColor(ABmp: TBitmap; Color : TAlphaColor);
var
  x,y: Integer;
  AMap: TBitmapData;
  PixelColor: TAlphaColor;
  PixelWhiteColor: TAlphaColor;
  C: PAlphaColorRec;
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

procedure TksTileMenuOptionItem.DrawToCanvas(ACanvas: TCanvas);
var
  r1, r2, r3: TRectF;
  AShadow: TRectF;
  ABmp: TBitmap;
begin
  FTileMenu.GetTileRects(FCol, FRow, r1, r2, r3);
  ACanvas.Stroke.Color := claSilver;
  ACanvas.Stroke.Kind := TBrushKind.Solid;
  ACanvas.StrokeDash := TStrokeDash.Solid;
  ACanvas.StrokeThickness := 1;

  if FMouseDown then
  begin
    InflateRect(r1, 2, 2);
    ACanvas.Fill.Color := AlterColor(ACanvas.Fill.Color, 15);
  end;

  ACanvas.Fill.Kind := TBrushKind.Solid;;

  AShadow := r1;
  ACanvas.Fill.Color := claGray;
  OffsetRect(AShadow, 4, 4);
  ACanvas.FillRect(AShadow, 0, 0, AllCorners, 1);

  ACanvas.Fill.Color := FFill;
  ACanvas.FillRect(r1, 0, 0, AllCorners, 1);

  ACanvas.Stroke.Color := AlterColor(ACanvas.Fill.Color, -30);

  ACanvas.DrawRect(r1, 0, 0, AllCorners, 1);

  ABmp := TBitmap.Create;
  try
    ABmp.Assign(FBitmap);
    ReplaceOpaqueColor(ABmp, FTextColor);
    ACanvas.DrawBitmap(ABmp, RectF(0, 0, FBitmap.Width, FBitmap.Height), r2, 1, True);
  finally
    ABmp.Free;
  end;
  ACanvas.Fill.Color := FTextColor;
  ACanvas.Font.Size := 10;
  ACanvas.FillText(r3, FText, False, 1, [], TTextAlign.Center);

end;

function TksTileMenuOptionItem.GetTileRect: TRectF;
var
  r1, r2, r3: TRectF;
begin
  FTileMenu.GetTileRects(FCol, FRow, r1, r2, r3);
  Result := r1;
end;

procedure TksTileMenuOptionItem.MouseDown;
begin
  FMouseDown := True;
  FTileMenu.Repaint;
  Application.ProcessMessages;
end;

procedure TksTileMenuOptionItem.MouseUp;
begin
  Sleep(100);
  FMouseDown := False;
  FTileMenu.Repaint;
  Application.ProcessMessages;
end;

procedure TksTileMenuOptionItem.SetBitmap(const Value: TBitmap);
begin
  FBitmap.Assign(Value);
end;

procedure TksTileMenuOptionItem.SetFill(const Value: TAlphaColor);
begin
  FFill := Value;

end;

procedure TksTileMenuOptionItem.SetText(const Value: string);
begin
  FText := Value;

end;

procedure TksTileMenuOptionItem.SetTextColor(const Value: TAlphaColor);
begin
  FTextColor := Value;
end;

{ TksTileMenuOptionItemList }

procedure TksTileMenuOptionItemList.AddOption(AText, AId: string; AColor, ATextColor: TAlphaColor; AImage: TBitmap);
var
  AItem: TksTileMenuOptionItem;
begin
  AItem := TksTileMenuOptionItem.Create(FMainMenu);
  AItem.Text := AText;
  AItem.Bitmap := AImage;
  AItem.ID := AID;
  AItem.Fill := AColor;
  AItem.TextColor := ATextColor;
  Add(AItem);
  FMainMenu.RecreateMenu;
end;

{$IFDEF XE8_OR_NEWER}

procedure TksTileMenuOptionItemList.AddOption(AText, AId: string; AColor, ATextColor: TAlphaColor; AImageIndex: integer);
var
  ABmp: TCustomBitmapItem;
begin
  ABmp := FMainMenu.Images.Source[AImageIndex].MultiResBitmap.ItemByScale(1, False, False);
  AddOption(AText, AId, AColor, ATextColor, ABmp.Bitmap);
end;

{$ENDIF}

constructor TksTileMenuOptionItemList.Create(AMainMenu: TksTileMenu);
begin
  inherited Create(True);
  FMainMenu := AMainMenu;
end;

function TksTileMenuOptionItemList.TileFromXY(x, y: single): TksTileMenuOptionItem;
var
  ICount: integer;
begin
  Result := nil;
  for ICount := 0 to Count-1 do
  begin
    if PtInRect(Items[ICount].TileRect, PointF(x, y)) then
    begin
      Result := Items[ICount];
      Exit;
    end;
  end;
end;

end.
