{*******************************************************************************
*                                                                              *
*  TksSlideMenu - Slide Menu Component                                         *
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

unit ksSlideMenu;

interface

{$I ksComponents.inc}

//{$DEFINE ADD_SAMPLE_MENU_ITEMS}


uses System.UITypes, FMX.Controls, FMX.Layouts, FMX.Objects, System.Classes,
  FMX.Types, Generics.Collections, FMX.Graphics, System.UIConsts, FMX.Effects,
  FMX.StdCtrls, System.Types, FMX.Forms, ksTableView, ksTypes
  {$IFDEF XE8_OR_NEWER}
  ,FMX.ImgList
  {$ENDIF}
  ;

const
  C_DEFAULT_MENU_WIDTH = 250;
  C_DEFAULT_MENU_TOOLBAR_HEIGHT = 44;

  C_DEFAULT_MENU_HEADER_HEIGHT = 30;
  C_DEFAULT_MENU_HEADER_FONT_SIZE = 16;
  C_DEFAULT_MENU_HEADER_TEXT_COLOR = claWhite;
  C_DEFAULT_MENU_HEADER_COLOR = $FF323232;

  C_DEFAULT_MENU_ITEM_HEIGHT = 50;
  C_DEFAULT_MENU_FONT_SIZE = 14;
  C_DEFAULT_MENU_TOOLBAR_FONT_SIZE = 14;
  C_DEFAULT_MENU_SLIDE_SPEED = 0.2;

  C_DEFAULT_MENU_SELECTED_COLOR = claWhite;
  C_DEFAULT_MENU_SELECTED_FONT_COLOR = claWhite;
  C_DEFAULT_MENU_FONT_COLOR = claBlack;
  C_DEFAULT_MENU_BACKGROUND_COLOR = claWhite;
  C_DEFAULT_MENU_TOOLBAR_COLOR = claWhite;

type
  TSelectMenuItemEvent = procedure(Sender: TObject; AId: string) of object;

  TksMenuPosition = (mpLeft, mpRight);
  TKsMenuStyle = (msOverlap, msReveal);
  TKsMenuTheme = (mtCustom, mtDarkGray, mtDarkBlue, mtDarkOrange, mtDarkGreen, mtLightGray, mtLightBlue, mtLightOrange, mtLightGreen);

  TksSlideMenu = class;

  TksSlideMenuItem = class
  strict private
    FText: string;
    FId: string;
    FFont: TFont;
    FImage: TBitmap;
    FHeight: integer;
    FIndex: integer;
    FIsHeader: Boolean;
  public
    constructor Create(AIndex: integer); virtual;
    destructor Destroy; override;
    property Height: integer read FHeight write FHeight;
    property Index: integer read FIndex;
    property Font: TFont read FFont write FFont;
    property Image: TBitmap read FImage write FImage;
    property ID: string read FId write FId;
    property Text: string read FText write FText;
    property IsHeader: Boolean read FIsHeader write FIsHeader;
  end;

  TksSlideMenuItems = class(TObjectList<TksSlideMenuItem>)
  private
    function AddMenuItem(AId, AText: string; AImage: TBitmap): TksSlideMenuItem;
    function AddHeaderItem(AText: string): TksSlideMenuItem;
  end;

  TksSlideMenuAppearence = class(TPersistent)
  private
    [weak]FSlideMenu: TksSlideMenu;
    FHeaderColor: TAlphaColor;
    FHeaderFontColor: TAlphaColor;
    FItemColor: TAlphaColor;
    FFontColor: TAlphaColor;
    FSelectedColor: TAlphaColor;
    FSelectedFontColor: TAlphaColor;
    FTheme: TKsMenuTheme;
    FToolBarColor: TAlphaColor;
    FAccessoryColor: TAlphaColor;
    procedure SetHeaderColor(const Value: TAlphaColor);
    procedure SetHeaderFontColor(const Value: TAlphaColor);
    procedure SetItemColor(const Value: TAlphaColor);
    procedure SetFontColor(const Value: TAlphaColor);
    procedure SetSelectedColor(const Value: TAlphaColor);
    procedure SetSelectedFontColor(const Value: TAlphaColor);
    procedure SetTheme(const Value: TKsMenuTheme);
    procedure SetToolBarColor(const Value: TAlphaColor);
    procedure SetAccessoryColor(const Value: TAlphaColor);
  public
    constructor Create(ASlideMenu: TksSlideMenu); virtual;
  published
    property AccessoryColor: TAlphaColor read FAccessoryColor write SetAccessoryColor default claWhite;
    property HeaderColor: TAlphaColor read FHeaderColor write SetHeaderColor default C_DEFAULT_MENU_HEADER_COLOR;
    property HeaderFontColor: TAlphaColor read FHeaderFontColor write SetHeaderFontColor default C_DEFAULT_MENU_HEADER_TEXT_COLOR;
    property ItemColor: TAlphaColor read FItemColor write SetItemColor default $FF222222;
    property FontColor: TAlphaColor read FFontColor write SetFontColor default claWhite;
    property SelectedItemColor: TAlphaColor read FSelectedColor write SetSelectedColor default claRed;
    property SelectedFontColor: TAlphaColor read FSelectedFontColor write SetSelectedFontColor default claWhite;
    property ToolBarColor: TAlphaColor read FToolBarColor write SetToolBarColor default $FF323232;
    property Theme: TKsMenuTheme read FTheme write SetTheme default mtDarkGray;
  end;


  TksSlideMenuToolbar = class(TPersistent)
  private
    [weak]FSlideMenu: TksSlideMenu;
    FHeader: TImage;
    FBitmap: TBitmap;
    FText: string;
    FFont: TFont;
    FVisible: Boolean;
    FHeight: integer;
    procedure SetFont(const Value: TFont);
    procedure SetBitmap(const Value: TBitmap);
    function GetBitmap: TBitmap;
    function GetFont: TFont;
    function GetText: string;
    procedure SetText(const Value: string);

  public
    constructor Create(AOwner: TComponent; ASlideMenu: TksSlideMenu); virtual;
    destructor Destroy; override;
    procedure UpdateToolbar;
    property Height: integer read FHeight default  C_DEFAULT_MENU_TOOLBAR_HEIGHT;
  published
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
    property Visible: Boolean read FVisible write FVisible default True;
    property Text: string read GetText write SetText;
    property Font: TFont read GetFont write SetFont;
  end;


  TksSlideMenuContainer = class(TLayout)
  private
    [weak]FSlideMenu: TksSlideMenu;
    FToolBar: TksSlideMenuToolbar;
    FListView: TksTableView;
    procedure CreateListView;
    function CalculateListViewHeight: single;
    procedure ItemClick(Sender: TObject; x, y: single; AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ListView: TksTableView read FListView;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or
    {$IFDEF XE8_OR_NEWER} pidiOSDevice32 or pidiOSDevice64
    {$ELSE} pidiOSDevice {$ENDIF} or pidiOSSimulator or pidAndroid)]
  TksSlideMenu = class(TksComponent)
  strict private
    FAppearence: TksSlideMenuAppearence;
    FMenu: TksSlideMenuContainer;
    FItems: TksSlideMenuItems;
    {$IFNDEF ANDROID}
    FShadowLeft: TImage;
    FShadowRight: TImage;
    {$ENDIF}
    FBackground: TRectangle;
    FFormImage: TImage;
    FMenuImage: TImage;
    FFont: TFont;
    FHeaderFont: TFont;
    FShowing: Boolean;
    FTopPadding: integer;
    FMenuPosition: TksMenuPosition;
    FMenuStyle: TKsMenuStyle;
    FSlideSpeed: Single;
    FOnSelectMenuItemEvent: TSelectMenuItemEvent;
    FAfterSelectMenuItemEvent: TSelectMenuItemEvent;
    FOnAfterSlideOut: TNotifyEvent;
    FOnBeforeSlideOut: TNotifyEvent;
    {$IFDEF XE8_OR_NEWER}
    FImages: TCustomImageList;
    {$ENDIF}
    FHeaderHeight: integer;
    FItemHeight: integer;
    FToggleButton: TCustomButton;
    FAnimating: Boolean;

    FHeaderTextAlign: TTextAlign;
    FItemTextAlign: TTextAlign;
    FSelectFirstItem: Boolean;

    procedure SetTopPadding(const Value: integer);
    procedure DoBackgroundClick(Sender: TObject);
    //procedure FadeBackground;
    //procedure UnfadeBackground;
    procedure GenerateFormImage(AXpos: single);
    procedure RemoveFormImage;
    {$IFNDEF ANDROID}
    procedure GenerateShadows;
    {$ENDIF}
    procedure HidePickers;
    procedure SetToggleButton(const Value: TCustomButton);
    procedure DoToggleButtonClick(Sender: TObject);
    
  private
    FMenuIndex: integer;
    procedure MenuItemSelected(Sender: TObject; x, y: single; AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
    //procedure SetItemIndex(const Value: integer);
    procedure SwitchMenuToImage;
    procedure SwitchImageToMenu;
    function GetToolbar: TksSlideMenuToolbar;
    function GetToolbarHeight: integer;
    procedure SetToolbar(const Value: TksSlideMenuToolbar);
    procedure SetMenuIndex(const Value: integer);
    function GetMenuItemCount: integer;
    function GetColorOrDefault(AColor, ADefaultIfNull: TAlphaColor): TAlphaColor;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure AddHeader(AText: string);
    function AddMenuItem(AId, AText: string; const AImageIndex: integer = -1): TksSlideMenuItem; overload;
    function AddMenuItem(AId, AText: string; AImage: TBitmap): TksSlideMenuItem; overload;
    procedure ToggleMenu;
    procedure UpdateMenu;
    procedure RefreshMenu;
    property Showing: Boolean read FShowing;
    property MenuIndex: integer read FMenuIndex write SetMenuIndex;
    property MenuItemCount: integer read GetMenuItemCount;
  published
    property Appearence: TksSlideMenuAppearence read FAppearence write FAppearence;
    property Font: TFont read FFont write FFont;
    property HeaderFont: TFont read FHeaderFont write FHeaderFont;
    {$IFDEF XE8_OR_NEWER}
    property Images: TCustomImageList read FImages write FImages;
    {$ENDIF}
    property ItemHeight: integer read FItemHeight write FItemHeight default C_DEFAULT_MENU_ITEM_HEIGHT;
    property HeaderHeight: integer read FHeaderHeight write FHeaderHeight default C_DEFAULT_MENU_HEADER_HEIGHT;
    property TopPadding: integer read FTopPadding write SetTopPadding default 0;
    property MenuPosition: TksMenuPosition read FMenuPosition write FMenuPosition default mpLeft;
    property MenuStyle: TKsMenuStyle read FMenuStyle write FMenuStyle default msReveal;
    property SlideSpeed: Single read FSlideSpeed write FSlideSpeed;
    property OnSelectMenuItemEvent: TSelectMenuItemEvent read FOnSelectMenuItemEvent write FOnSelectMenuItemEvent;
    property AfterSelectItemEvent: TSelectMenuItemEvent read FAfterSelectMenuItemEvent write FAfterSelectMenuItemEvent;
    property Toolbar: TksSlideMenuToolbar read GetToolbar write SetToolbar;
    property ToggleButton: TCustomButton read FToggleButton write SetToggleButton;
    property OnAfterSlideOut: TNotifyEvent read FOnAfterSlideOut write FOnAfterSlideOut;
    property OnBeforeSlideOut: TNotifyEvent read FOnBeforeSlideOut write FOnBeforeSlideOut;
    property HeaderTextAlign: TTextAlign read FHeaderTextAlign write FHeaderTextAlign default TTextAlign.Leading;
    property ItemTextAlign: TTextAlign read FItemTextAlign write FItemTextAlign default TTextAlign.Leading;
    property SelectFirstItem: Boolean read FSelectFirstItem write FSelectFirstItem default True;
  end;

  {$R *.dcr}

  procedure Register;
  procedure ReplaceOpaqueColor(ABmp: TBitmap; Color : TAlphaColor);

var
  SlideMenuAnimating: Boolean;



implementation

uses FMX.Platform, SysUtils, FMX.Ani, FMX.Pickers, Math,
  FMX.ListView.Types, FMX.Utils, ksCommon;


procedure Register;
begin
  RegisterComponents('Kernow Software FMX', [TksSlideMenu]);
end;

procedure ReplaceOpaqueColor(ABmp: TBitmap; Color : TAlphaColor);
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

{ TSlideMenu }

procedure TksSlideMenu.AddHeader(AText: string);
var
  AResult: TksSlideMenuItem;
begin
  AResult := FItems.AddHeaderItem(AText);
  AResult.Font.Assign(FFont);
end;


function TksSlideMenu.AddMenuItem(AId, AText: string; AImage: TBitmap): TksSlideMenuItem;
begin
  Result := FItems.AddMenuItem(AId, AText, AImage);
  Result.Font.Assign(FFont);
  //UpdateMenu;
end;

function TksSlideMenu.AddMenuItem(AId, AText: string; const AImageIndex: integer = -1): TksSlideMenuItem;
var
  AImage: TBitmap;
  ASize: TSizeF;
begin
  AImage := nil;
  ASize.Width := 64;
  ASize.Height := 64;
  {$IFDEF XE8_OR_NEWER}
  if Images <> nil then
    AImage := Images.Bitmap(ASize, AImageIndex);
  {$ENDIF}
  Result := AddMenuItem(AId, AText, AImage);
end;


procedure TksSlideMenu.Clear;
begin
  FItems.Clear;
  UpdateMenu;
end;

constructor TksSlideMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFont := TFont.Create;
  FHeaderFont := TFont.Create;
  FItems := TksSlideMenuItems.Create;
  FAppearence := TksSlideMenuAppearence.Create(Self);
  FMenu := TksSlideMenuContainer.Create(Self);
  FFormImage := TImage.Create(Self);
  FBackground := TRectangle.Create(Self);

  FHeaderTextAlign := TTextAlign.Leading;
  FItemTextAlign := TTextAlign.Leading;

  FShowing := False;
  FTopPadding := 0;
  FFont.Size := C_DEFAULT_MENU_FONT_SIZE;
  FHeaderFont.Size := C_DEFAULT_MENU_HEADER_FONT_SIZE;
  FFormImage.OnClick := DoBackgroundClick;
  FMenuPosition := mpLeft;
  FMenuStyle := msReveal;
  FSlideSpeed := C_DEFAULT_MENU_SLIDE_SPEED;
  FHeaderHeight := C_DEFAULT_MENU_HEADER_HEIGHT;
  FItemHeight := C_DEFAULT_MENU_ITEM_HEIGHT;
  //FItemIndex := -1;

  {$IFNDEF ANDROID}
  FShadowLeft := TImage.Create(Self);
  FShadowRight := TImage.Create(Self);
  GenerateShadows;
  FSelectFirstItem := True;
  {$ENDIF}
  FAnimating := False;
  FMenuIndex := -1;
end;

destructor TksSlideMenu.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FHeaderFont);
  FreeAndNil(FAppearence);
  FreeAndNil(FItems);
  inherited;
end;


procedure TksSlideMenu.DoBackgroundClick(Sender: TObject);
begin
  ToggleMenu;
end;

procedure TksSlideMenu.DoToggleButtonClick(Sender: TObject);
begin
  ToggleMenu;
end;

procedure TksSlideMenu.GenerateFormImage(AXpos: single);
var
  AScale: single;
  ABmp: TBitmap;
  ABmp2: TBitmap;
  AForm: TForm;
  AOwner : TComponent;
  AWidth : single;
  AHeight: single;
  ATopLeft : TPointF;
  //AFormTopLeft : TPointF;
begin
  AOwner := Owner;
  if (AOwner is TForm) then
  begin
    AWidth   := (AOwner as TForm).Width;
    AHeight  := (AOwner as TForm).Height;
    ATopLeft := PointF(0,0);
  end
  else if (AOwner is TFrame) then
  begin
    AWidth   := (AOwner as TFrame).Width;
    AHeight  := (AOwner as TFrame).Height;
    ATopLeft := PointF(0,0);

    while not (AOwner is TForm) do
    begin
      ATopLeft := ATopLeft + (AOwner as TFrame).LocalToAbsolute(PointF(0,0));
      AOwner   := AOwner.Owner;
    end;

    if not (AOwner is TForm) then
      exit;
  end
  else
    exit;

  AForm := (AOwner as TForm);
  FFormImage.Visible := false;

  FMenu.Visible := False;
  ABmp := TBitmap.Create;
  try
    AScale := GetScreenScale;
    ABmp.BitmapScale := AScale;
    ABmp.Width  := Round((ATopLeft.x + AWidth ) * AScale);
    ABmp.Height := Round((ATopLeft.y + AHeight) * AScale);
    ABmp.Canvas.BeginScene;
    AForm.PaintTo(ABmp.Canvas);
    ABmp.Canvas.EndScene;
    ABmp.Canvas.BeginScene;
    ABmp.Canvas.Stroke.Color := claBlack;
    ABmp.Canvas.StrokeThickness := 1;
    ABmp.Canvas.DrawLine(PointF(0, 0), PointF(0, ABmp.Height), 1);
    {ABmp.Canvas.Fill.Color := claFuchsia;
    ABmp.Canvas.FillEllipse(RectF(0, 0, 100, 100), 1);}
    ABmp.Canvas.EndScene;

    if (ATopLeft.x>0) or (ATopLeft.y>0) then
    begin
      ABmp2 := TBitmap.Create;
      ABmp2.BitmapScale := AScale;
      ABmp2.Width  := Round(AWidth  * AScale);
      ABmp2.Height := Round(AHeight * AScale);
      ABmp2.Canvas.BeginScene;
      ABmp2.Canvas.DrawBitmap(ABmp,
                              RectF(Round(ATopLeft.x * AScale),Round(ATopLeft.y * AScale),ABmp.Width,ABmp.Height),
                              RectF(0,0,AWidth,AHeight),
                              1,true);
      ABmp2.Canvas.EndScene;

      ABmp.Free();
      ABmp := ABmp2;
    end;

    FFormImage.Width := Round(AWidth);
    FFormImage.Height := Round(AHeight);
    FFormImage.Bitmap.Assign(ABmp);
  finally
    FreeAndNil(ABmp);
  end;

  FFormImage.Position.Y := 0;
  FFormImage.Position.X := AXpos;

  {$IFNDEF ANDROID}
  FShadowLeft.Position.Y := 0;
  FShadowLeft.Position.X := 0-FShadowLeft.Width;
  FFormImage.AddObject(FShadowLeft);

  FShadowRight.Position.Y := 0;
  FShadowRight.Position.X := FFormImage.Width;
  FFormImage.AddObject(FShadowRight);

  {$ENDIF}

  TfmxObject(Owner).AddObject(FFormImage);
  FFormImage.Visible := True;
  FMenu.Visible := True;
  Application.ProcessMessages;
end;

procedure TksSlideMenu.RefreshMenu;
var
  AWidth: single;
begin
  if (FAnimating) or (not FShowing) then
    Exit;

  if (Owner is TForm) then
    AWidth := (Owner as TForm).Width
  else
  if (Owner is TFrame) then
    AWidth := (Owner as TFrame).Width
  else
    AWidth := 0;

  HidePickers;

  GenerateFormImage(FFormImage.Position.x);

  if (Owner is TForm) then
    FMenu.Height := (Owner as TForm).ClientHeight
  else
  if (Owner is TFrame) then
    FMenu.Height := (Owner as TFrame).Height
  else
    FMenu.Height := 0;

  case FMenuPosition of
    mpLeft: FMenu.Position.x := 0;
    mpRight:FMenu.Position.x := AWidth - C_DEFAULT_MENU_WIDTH;
  end;

  if FMenu.FListView.Items.Count = 0 then
    UpdateMenu;
end;

procedure TksSlideMenu.RemoveFormImage;
begin
  (Owner as TfmxObject).RemoveObject(FFormImage);
end;

{$IFNDEF ANDROID}

procedure TksSlideMenu.GenerateShadows;
var
  AScale: single;
  ABmp: TBitmap;
  AHeight : Single;
begin
  if (Owner is TForm) then
    AHeight := (Owner as TForm).Height
  else if (Owner is TFrame) then
    AHeight := (Owner as TFrame).Height
  else
    exit;

  ABmp := TBitmap.Create;
  try
    AScale := GetScreenScale;
    ABmp.Width := Round(16 * AScale);
    ABmp.Height := Round(AHeight * AScale);
    ABmp.Canvas.BeginScene;
    ABmp.Canvas.Fill.Kind := TBrushKind.Gradient;
    ABmp.Canvas.Fill.Gradient.Color := claNull;
    ABmp.Canvas.Fill.Gradient.Color1 := $AA000000;
    ABmp.Canvas.Fill.Gradient.StartPosition.X := 0;
    ABmp.Canvas.Fill.Gradient.StartPosition.Y := 1;
    ABmp.Canvas.Fill.Gradient.StopPosition.X := 1;
    ABmp.Canvas.FillRect(RectF(0, 0, ABmp.Width, ABmp.Height), 0, 0, [], 1);
    ABmp.Canvas.EndScene;
    FShadowLeft.Width := 16;
    FShadowLeft.Height := Round(AHeight);
    FShadowLeft.Bitmap.Assign(ABmp);
  finally
    FreeAndNil(ABmp);
  end;

  ABmp := TBitmap.Create;
  try
    AScale := GetScreenScale;
    ABmp.Width := Round(16 * AScale);
    ABmp.Height := Round(AHeight * AScale);
    ABmp.Canvas.BeginScene;
    ABmp.Canvas.Fill.Kind := TBrushKind.Gradient;
    ABmp.Canvas.Fill.Gradient.Color := $AA000000;
    ABmp.Canvas.Fill.Gradient.Color1 := claNull;
    ABmp.Canvas.Fill.Gradient.StartPosition.X := 0;
    ABmp.Canvas.Fill.Gradient.StartPosition.Y := 1;
    ABmp.Canvas.Fill.Gradient.StopPosition.X := 1;
    ABmp.Canvas.FillRect(RectF(0, 0, ABmp.Width, ABmp.Height), 0, 0, [], 1);
    ABmp.Canvas.EndScene;
    FShadowRight.Width := 16;
    FShadowRight.Height := Round(AHeight);
    FShadowRight.Bitmap.Assign(ABmp);
  finally
    FreeAndNil(ABmp);
  end;
end;

{$ENDIF}

function TksSlideMenu.GetMenuItemCount: integer;
var
  ICount: integer;
  lv: TksTableView;
begin
  Result := 0;
  lv := FMenu.FListView;
  for ICount := 0 to lv.Items.Count-1 do
  begin
    if lv.Items[ICount].Purpose = TksTableViewItemPurpose.None then
      Result := Result + 1;
  end;
end;

function TksSlideMenu.GetToolbar: TksSlideMenuToolbar;
begin
  Result := FMenu.FToolBar;
end;

function TksSlideMenu.GetToolbarHeight: integer;
begin
  Result := 0;
  if Toolbar.Visible then
    Result := C_DEFAULT_MENU_TOOLBAR_HEIGHT;
end;

procedure TksSlideMenu.HidePickers;
var
  PickerService: IFMXPickerService;
begin
  inherited;
  if TPlatformServices.Current.SupportsPlatformService(IFMXPickerService, PickerService) then
    PickerService.CloseAllPickers;
end;
procedure TksSlideMenu.MenuItemSelected(Sender: TObject; x, y: single; AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
begin
  if Assigned(FOnSelectMenuItemEvent) then
    FOnSelectMenuItemEvent(Self, AId);
  GenerateFormImage(FFormImage.Position.X);
  ToggleMenu;
  if Assigned(FAfterSelectMenuItemEvent) then
    FAfterSelectMenuItemEvent(Self, AId);
end;



procedure TksSlideMenu.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent = FToggleButton) and (Operation = TOperation.opRemove) then
    FToggleButton := nil;
end;


function TksSlideMenu.GetColorOrDefault(AColor, ADefaultIfNull: TAlphaColor): TAlphaColor;
begin
  Result := AColor;
  if Result = claNull then
    Result := ADefaultIfNull;
end;

procedure TksSlideMenu.UpdateMenu;
var
  ICount: integer;
  AItem: TksSlideMenuItem;
  ARow: TksTableViewItem;
  lv: TksTableView;
  ASelectedColor: TAlphaColor;
  AFontColor, AHeaderFontColor: TAlphaColor;
begin
  if FMenu.ListView = nil then
    Exit;
  Application.ProcessMessages;
  lv := FMenu.FListView;

  lv.Position.X := 0;
  lv.Repaint;

  //lv.Position.Y := GetToolbarHeight;;

  lv.Width := C_DEFAULT_MENU_WIDTH;

  //FMenu
  FMenu.Width := C_DEFAULT_MENU_WIDTH;
  AFontColor := GetColorOrDefault(FAppearence.FontColor, C_DEFAULT_MENU_FONT_COLOR);
  AHeaderFontColor := GetColorOrDefault(FAppearence.HeaderFontColor, C_DEFAULT_MENU_HEADER_TEXT_COLOR);
  ASelectedColor := GetColorOrDefault(FAppearence.SelectedItemColor, C_DEFAULT_MENU_SELECTED_COLOR);

  lv.Appearence.Background.Color := GetColorOrDefault(FAppearence.ItemColor, C_DEFAULT_MENU_BACKGROUND_COLOR);
  lv.Appearence.ItemBackground.Color := GetColorOrDefault(FAppearence.ItemColor, C_DEFAULT_MENU_BACKGROUND_COLOR);
  lv.Appearence.HeaderColor := GetColorOrDefault(FAppearence.HeaderColor, C_DEFAULT_MENU_HEADER_COLOR);
  lv.Appearence.SeparatorColor := GetColorOrDefault(FAppearence.HeaderColor, C_DEFAULT_MENU_HEADER_COLOR);
  lv.Appearence.SelectedColor := ASelectedColor;

  lv.HeaderOptions.Height := FHeaderHeight;
  lv.ItemHeight := FItemHeight;
  lv.ItemImageSize := 24;
  lv.BeginUpdate;
  try
    lv.Items.Clear;

    {$IFDEF ADD_SAMPLE_MENU_ITEMS}
    if FItems.Count = 0 then
    begin
      // add some sample items...
      AddHeader('SAMPLE HEADER 0');
      AddMenuItem('', 'Menu Item 1');
      AddMenuItem('', 'Menu Item 2');
      AddHeader('SAMPLE HEADER 1');
      AddMenuItem('', 'Menu Item 3');
      AddMenuItem('', 'Menu Item 4');
      AddMenuItem('', 'Menu Item 5');
      AddHeader('SAMPLE HEADER 2');
      AddMenuItem('', 'Menu Item 6');
      AddMenuItem('', 'Menu Item 7');
      AddMenuItem('', 'Menu Item 8');
      AddMenuItem('', 'Menu Item 9');
      AddMenuItem('', 'Menu Item 10');
    end;
    {$ENDIF}

    for ICount := 0 to FItems.Count-1 do
    begin
      AItem := FItems[ICount];
      if AItem.IsHeader then
      begin
        ARow := lv.Items.AddHeader(AItem.Text);
        ARow.Title.Font.Assign(FHeaderFont);
        ARow.Title.TextColor := AHeaderFontColor;
        ARow.Title.TextAlignment:= FHeaderTextAlign;
      end
      else
      begin
        ARow := lv.Items.AddItem(AItem.Text, '', '', atMore);
        ARow.Image.Bitmap := AItem.Image;
        ARow.ID := AItem.ID;
        ARow.Accessory.OwnsBitmap := True;
        ARow.Accessory.Color := FAppearence.AccessoryColor;
        ARow.Title.Font.Assign(FFont);
        ARow.Title.TextColor := AFontColor;
        ARow.Title.TextAlignment:= FItemTextAlign;
      end;
    end;
  finally
    lv.EndUpdate;
  end;
  lv.RecalcAbsoluteNow;

  MenuIndex := FMenuIndex;

  if (lv.ItemIndex = -1) and (FSelectFirstItem) then
  begin
    for ICount := 0 to lv.Items.Count-1 do
    begin
      if lv.Items[ICount].Purpose = TksTableViewItemPurpose.None then
      begin
        lv.ItemIndex := ICount;
        Break;
      end;
    end;
  end;
end;



procedure TksSlideMenu.SetMenuIndex(const Value: integer);
var
  ICount: integer;
  AIndex: integer;
  lv: TksTableView;
begin
  AIndex := -1;
  lv := FMenu.FListView;
  for ICount := 0 to lv.Items.Count-1 do
  begin
    if lv.Items[ICount].Purpose = TksTableViewItemPurpose.None then
    begin
      Inc(AIndex);
      if AIndex = Value then
      begin
        lv.ItemIndex := ICount;
        Exit;
      end;
    end;
  end;
  FMenuIndex := Value;
end;

procedure TksSlideMenu.SetToggleButton(const Value: TCustomButton);
begin
  FToggleButton := Value;
  FToggleButton.OnClick := DoToggleButtonClick;
end;

procedure TksSlideMenu.SetToolbar(const Value: TksSlideMenuToolbar);
begin
  FMenu.FToolBar := Value;
end;

procedure TksSlideMenu.SetTopPadding(const Value: integer);
begin
  FTopPadding := Value;
end;

procedure TksSlideMenu.SwitchMenuToImage;
var
  ABmp: TBitmap;
  ABottom: single;
  AWidth: single;
  AClientHeight: single;
begin
  if (Owner is TForm) then
  begin
    AWidth        := (Owner as TForm).Width;
    AClientHeight := (Owner as TForm).ClientHeight;
  end
  else if (Owner is TFrame) then
  begin
    AWidth        := (Owner as TFrame).Width;
    AClientHeight := (Owner as TFrame).Height
  end
  else
    exit;

  ABmp := TBitmap.Create(Round(C_DEFAULT_MENU_WIDTH * GetScreenScale), Round(AClientHeight * GetScreenScale));
  try
     FMenuImage := TImage.Create(Owner);
    FMenuImage.Width := C_DEFAULT_MENU_WIDTH;
    FMenuImage.Height := AClientHeight;
    case FMenuPosition of
      mpLeft: FMenuImage.Position.X := 0;
      mpRight: FMenuImage.Position.X := AWidth - C_DEFAULT_MENU_WIDTH;
    end;
    ABmp.Canvas.BeginScene;
    ABmp.BitmapScale := GetScreenScale;
    FMenu.PaintTo(ABmp.Canvas, RectF(0, 0, ABmp.Width, ABmp.Height));
    ABmp.Canvas.EndScene;

    ABmp.Canvas.BeginScene;

    ABottom := (GetToolbarHeight + FMenu.CalculateListViewHeight)*GetScreenScale;

    ABmp.Canvas.Fill.Color := FAppearence.ItemColor;
    ABmp.Canvas.FillRect(RectF(0, ABottom, C_DEFAULT_MENU_WIDTH*GetScreenScale, ABmp.Height), 0, 0, AllCorners, 1, ABmp.Canvas.Fill);

    ABmp.Canvas.EndScene;
    FMenuImage.Bitmap := ABmp;
  finally
    FreeAndNil(ABmp);
  end;
end;

procedure TksSlideMenu.SwitchImageToMenu;
var
  AObject: TfmxObject;
begin
  AObject := (Owner as TfmxObject);
  AObject.InsertObject(AObject.ChildrenCount-1, FMenu);
  AObject.RemoveObject(FMenuImage);
  FMenu.HitTest := True;
end;

procedure TksSlideMenu.ToggleMenu;
var
  AStartXPos: single;
  ANewXPos: single;
  AObject: TfmxObject;
  AWidth: single;
begin
  if FAnimating then
    Exit;
  if FShowing = False then
  begin
    if Assigned(FOnBeforeSlideOut) then
      FOnBeforeSlideOut(Self);
  end;

  FAnimating := True;
  try
    if (FShowing = False) then
    begin

      FMenu.FToolBar.UpdateToolbar;
     //FMenu.UpdateSelectedItem;
    end;
    FMenu.HitTest := False;

    AObject := (Owner as TfmxObject);

    if (Owner is TForm) then
      AWidth := (Owner as TForm).Width
    else if (Owner is TFrame) then
      AWidth := (Owner as TFrame).Width
    else
      AWidth := 0;

    HidePickers;

    if FShowing = False then
    begin
      AStartXPos := 0;
      ANewXPos := 0;
      case FMenuPosition of
        mpLeft:  ANewXPos := C_DEFAULT_MENU_WIDTH;
        mpRight: ANewXPos := 0-C_DEFAULT_MENU_WIDTH;
      end;


    end
    else
    begin
      AStartXPos := FFormImage.Position.X;
      ANewXPos := 0;
    end;

    GenerateFormImage(AStartXPos);

    if (Owner is TForm) then
      FMenu.Height := (Owner as TForm).ClientHeight
    else if (Owner is TFrame) then
      FMenu.Height := (Owner as TFrame).Height
    else
      FMenu.Height := 0;

    // add the menu just behind the screen image...

    case FMenuPosition of
      mpLeft : FMenu.Position.X := 0;
      mpRight: FMenu.Position.X := AWidth - C_DEFAULT_MENU_WIDTH;
    end;
    AObject.InsertObject(0, FMenu);

    if FMenu.FListView.Items.Count = 0 then
      UpdateMenu;


    SwitchMenuToImage;
    AObject.RemoveObject(FMenu);
    AObject.InsertObject(AObject.ChildrenCount-1, FMenuImage);


    FFormImage.HitTest := False;

    //
    SlideMenuAnimating := True;
    TAnimator.AnimateFloatWait(FFormImage, 'Position.X', ANewXPos, FSlideSpeed);

    SlideMenuAnimating := False;
    FFormImage.HitTest := True;

    FShowing := not FShowing;


    if FShowing = False then
    begin
      AObject.RemoveObject(FMenu);
      RemoveFormImage;
    end
    else
      SwitchImageToMenu;

    AObject.RemoveObject(FMenuImage);
    Application.ProcessMessages;

  finally
    FAnimating := False;
  end;
  if FShowing = False then
  begin
    if Assigned(FOnAfterSlideOut) then
      FOnAfterSlideOut(Self);
  end;
end;

{procedure TksSlideMenu.FadeBackground;
begin
  FBackground.Fill.Color := claBlack;
  FBackground.Align := TAlignLayout.Contents;
  FBackground.OnClick := DoBackgroundClick;
  FBackground.Opacity := 0;
  TForm(Owner).AddObject(FBackground);
  FBackground.BringToFront;
  TAnimator.AnimateFloat(FBackground, 'Opacity', 0.2, FSlideSpeed);
end;

procedure TksSlideMenu.UnfadeBackground;
begin
  TAnimator.AnimateFloat(FBackground, 'Opacity', 0, FSlideSpeed);
  TForm(Owner).RemoveObject(FBackground);
end; }

{ TksSlideMenuItem }

constructor TksSlideMenuItem.Create(AIndex: integer);
begin
  inherited Create;
  FImage := TBitmap.Create;
  FFont := TFont.Create;
  FIndex := AIndex;
  FIsHeader := False;
end;

destructor TksSlideMenuItem.Destroy;
begin
  FreeAndNil(FImage);
  FreeAndNil(FFont);
  inherited;
end;


{ TksSlideMenuItems }

function TksSlideMenuItems.AddHeaderItem(AText: string): TksSlideMenuItem;
begin
  Result := AddMenuItem('', AText, nil);
  Result.IsHeader := True;
end;

function TksSlideMenuItems.AddMenuItem(AId, AText: string; AImage: TBitmap): TksSlideMenuItem;
begin
  Result := TksSlideMenuItem.Create(Count);
  if AImage <> nil then
    Result.Image.Assign(AImage);
  Result.Id := AId;
  Result.Text := AText;
  Add(Result);
end;

{ TksSlideMenuAppearence }

constructor TksSlideMenuAppearence.Create(ASlideMenu: TksSlideMenu);
begin
  FSlideMenu := ASlideMenu;
  FHeaderColor := $FF323232;
  FItemColor := $FF222222;
  FToolBarColor := $FF323232;
  FFontColor := claWhite;
  FSelectedFontColor := claWhite;
  FSelectedColor := claRed;
  FAccessoryColor := claWhite;
  FTheme := mtDarkGray;
end;

procedure TksSlideMenuAppearence.SetAccessoryColor(const Value: TAlphaColor);
begin
  FAccessoryColor := Value;
end;

procedure TksSlideMenuAppearence.SetFontColor(const Value: TAlphaColor);
begin
  FFontColor := Value;
  FTheme := mtCustom;

end;

procedure TksSlideMenuAppearence.SetHeaderColor(const Value: TAlphaColor);
begin
  FHeaderColor := Value;
  FTheme := mtCustom;
end;



procedure TksSlideMenuAppearence.SetHeaderFontColor(const Value: TAlphaColor);
begin
  FHeaderFontColor := Value;
  FTheme := mtCustom;
end;

procedure TksSlideMenuAppearence.SetItemColor(const Value: TAlphaColor);
begin
  FItemColor := Value;
  FTheme := mtCustom;
end;

procedure TksSlideMenuAppearence.SetSelectedColor(const Value: TAlphaColor);
begin
  FSelectedColor := Value;
  FTheme := mtCustom;
end;

procedure TksSlideMenuAppearence.SetSelectedFontColor(const Value: TAlphaColor);
begin
  FSelectedFontColor := Value;
  FTheme := mtCustom;
end;

procedure TksSlideMenuAppearence.SetTheme(const Value: TKsMenuTheme);
begin
   if Value = mtDarkGray then
    begin
      FHeaderColor := $FF424242;
      FToolBarColor := $FF323232;
      FItemColor := $FF222222;
      FFontColor := claWhite;
      FHeaderFontColor := $FFDADADA;
      FSelectedFontColor := claWhite;
      FSelectedColor := claRed;
    end;
  if Value = mtDarkBlue then
    begin
      FHeaderColor := $FF2A7A9D;
      FToolBarColor := $FF323232;
      FItemColor := $FF424242;
      FFontColor := claWhite;
      FHeaderFontColor := $FFC7FFFB;
      FSelectedFontColor := claBlack;
      FSelectedColor := $FF00F6FF;
    end;
  if Value = mtDarkOrange then
    begin
      FHeaderColor := $FFFF9900;
      FToolBarColor := $FF323232;
      FItemColor := $FF222222;
      FFontColor := claWhite;
      FHeaderFontColor := claBlack;
      FSelectedFontColor := claBlack;
      FSelectedColor := $FFFFCC00;
    end;
  if Value = mtDarkGreen then
    begin
      FHeaderColor := $FF76D015;
      FToolBarColor := $FF323232;
      FItemColor := $FF424242;
      FFontColor := claWhite;
      FHeaderFontColor := claBlack;
      FSelectedFontColor := claBlack;
      FSelectedColor := $FFDCFF00;
    end;
  if Value = mtLightGray then
    begin
      FHeaderColor := $FF424242;
      FToolBarColor := $FF323232;
      FItemColor := $FF828282;
      FFontColor := claWhite;
      FHeaderFontColor := $FFDADADA;
      FSelectedFontColor := claWhite;
      FSelectedColor := claRed;
    end;
  if Value = mtLightBlue then
    begin
      FHeaderColor := $FF424242;
      FToolBarColor := $FF323232;
      FItemColor := $FF2A7A9D;
      FFontColor := claWhite;
      FHeaderFontColor := $FFDADADA;
      FSelectedFontColor := claBlack;
      FSelectedColor := $FFC7FFFB;
    end;
  if Value = mtLightOrange then
    begin
      FHeaderColor := $FF424242;
      FToolBarColor := $FF323232;
      FItemColor := $FFFF9900;
      FFontColor := claBlack;
      FHeaderFontColor := $FFDADADA;
      FSelectedFontColor := claBlack;
      FSelectedColor := $FFFFCC00;
    end;
  if Value = mtLightGreen then
    begin
      FHeaderColor := $FF424242;
      FToolBarColor := $FF323232;
      FItemColor := $FF76D015;
      FFontColor := claBlack;
      FHeaderFontColor := $FFDADADA;
      FSelectedFontColor := claBlack;
      FSelectedColor := $FFDCFF00;
    end;
  FTheme := Value;
end;

procedure TksSlideMenuAppearence.SetToolBarColor(const Value: TAlphaColor);
begin
  FToolBarColor := Value;
  FTheme := mtCustom;
end;

{ TksSlideMenuContainer }

function TksSlideMenuContainer.CalculateListViewHeight: single;
var
  ICount: integer;
begin
  Result := 0;
  for ICount := 0 to FListView.Items.Count-1 do
  begin
    Result := Result + FListView.Items[ICount].Height;
  end;
end;

constructor TksSlideMenuContainer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSlideMenu := (AOwner as TksSlideMenu);
  FToolBar := TksSlideMenuToolbar.Create(Self, FSlideMenu);
  CreateListView;
  ClipChildren := True;
  HitTest := True;
end;

procedure TksSlideMenuContainer.CreateListView;
begin
  if FListView <> nil then
    Exit;
  FListView := TksTableView.Create(Self);
  FListView.SelectionOptions.KeepSelection := True;
  FListView.DeleteButton.Enabled := False;
  FListView.PullToRefresh.Enabled := False;
  //FListView.ShowSelection := False;
  FListView.OnItemClick := ItemClick;
  FListView.Align := TAlignLayout.Client;
  FListView.FullWidthSeparator := True;
  FListView.DeleteButton.Enabled := False;
  AddObject(FListView);
end;

destructor TksSlideMenuContainer.Destroy;
begin
  {$IFDEF NEXTGEN}
  FListView.DisposeOf;
  FToolBar.DisposeOf;
  {$ELSE}
  FListView.Free;
  FToolBar.Free;
  {$ENDIF}
  inherited;
end;

procedure TksSlideMenuContainer.ItemClick(Sender: TObject; x, y: single; AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
begin
  if HitTest = False then
    Exit;
  HitTest := False;
  //UpdateSelectedItem;
  Sleep(200);

  FSlideMenu.MenuItemSelected(Self, x, y, AItem, AId, ARowObj);
end;

{ TksSlideMenuToolbar }

constructor TksSlideMenuToolbar.Create(AOwner: TComponent; ASlideMenu: TksSlideMenu);
begin
  inherited Create;
  FSlideMenu := ASlideMenu;
  FBitmap := TBitmap.Create;
  FFont := TFont.Create;
  FFont.Size := C_DEFAULT_MENU_TOOLBAR_FONT_SIZE;
  FHeader := TImage.Create(AOwner);
  FHeader.Position.X := 0;
  FHeader.Position.Y := 0;
  FHeader.Width := C_DEFAULT_MENU_WIDTH;
  FHeader.Height := C_DEFAULT_MENU_TOOLBAR_HEIGHT;
  FHeader.Align := TAlignLayout.Top;
  FHeader.HitTest := False;
  FVisible := True;
  (AOwner as TFmxObject).AddObject(FHeader);
end;

destructor TksSlideMenuToolbar.Destroy;
begin
  FreeAndNil(FBitmap);
  FreeAndNil(FFont);
  FreeAndNil(FHeader);
  inherited;
end;

function TksSlideMenuToolbar.GetBitmap: TBitmap;
begin
  Result := FBitmap;
end;

function TksSlideMenuToolbar.GetFont: TFont;
begin
  Result := FFont;
end;

function TksSlideMenuToolbar.GetText: string;
begin
  Result := FText;
end;

procedure TksSlideMenuToolbar.SetBitmap(const Value: TBitmap);
begin
  FBitmap.Assign(Value);
end;

procedure TksSlideMenuToolbar.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TksSlideMenuToolbar.SetText(const Value: string);
begin
  FText := Value;
end;

procedure TksSlideMenuToolbar.UpdateToolbar;
var
  ABmp: TBitmap;
  AXPos: integer;
begin
  if not Visible then
  begin
    FHeader.Height := 0;
    Exit;
  end;
  ABmp := TBitmap.Create(Round(C_DEFAULT_MENU_WIDTH*GetScreenScale), Round(C_DEFAULT_MENU_TOOLBAR_HEIGHT*GetScreenScale));
  try
    ABmp.BitmapScale := GetScreenScale;
    AXPos := 10;
    ABmp.Clear(FSlideMenu.Appearence.ToolBarColor);
    ABmp.Canvas.BeginScene;

    if FBitmap.IsEmpty = False then
    begin
      ABmp.Canvas.DrawBitmap(FBitmap, RectF(0, 0, FBitmap.Width, FBitmap.Height), RectF(10, 10, 40, 40), 1);
      AXPos := 50;
    end;
    ABmp.Canvas.Fill.Color := FSlideMenu.Appearence.FFontColor;

    ABmp.Canvas.Font.Assign(FFont);
    ABmp.Canvas.FillText(RectF(AXPos, 0, C_DEFAULT_MENU_WIDTH, C_DEFAULT_MENU_TOOLBAR_HEIGHT), FText, False, 1, [], TTextAlign.Leading);
    ABmp.Canvas.EndScene;

    ABmp.Canvas.BeginScene;
    ABmp.Canvas.Fill.Color := FSlideMenu.Appearence.ItemColor;
    //ABmp.Canvas.StrokeThickness := 1;
    ABmp.Canvas.FillRect(RectF(0, C_DEFAULT_MENU_TOOLBAR_HEIGHT-1, C_DEFAULT_MENU_WIDTH, C_DEFAULT_MENU_TOOLBAR_HEIGHT), 0, 0, AllCorners, 1, ABmp.Canvas.Fill);
    //ABmp.Canvas.DrawLine(PointF(0, ABmp.Height-GetScreenScale), PointF(ABmp.Width, ABmp.Height-GetScreenScale), 1, ABmp.Canvas.Stroke);


    ABmp.Canvas.EndScene;

    FHeader.Bitmap := ABmp;
  finally
    FreeAndNil(ABmp);
  end;
end;

initialization

  SlideMenuAnimating := False;

end.


