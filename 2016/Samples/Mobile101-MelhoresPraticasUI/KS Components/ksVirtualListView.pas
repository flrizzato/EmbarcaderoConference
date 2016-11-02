{ *******************************************************************************
  *                                                                              *
  *  TksVirtualListView                                                          *
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
  ******************************************************************************* }

unit ksVirtualListView;

interface

{$I ksComponents.inc}

uses System.Classes, System.Types, ksTypes, FMX.Graphics, System.UITypes,
  System.Generics.Collections, FMX.Types, FMX.InertialMovement, System.UIConsts,
  FMX.StdCtrls, FMX.Controls, FMX.Platform, FMX.Objects;

const
  C_VLIST_ITEM_DEFAULT_HEIGHT = 44;
  C_VLIST_HEADER_DEFAULT_HEIGHT = 38;

  C_VLIST_CACHE_COUNT = 100;
  C_LONG_TAP_DURATION = 400;

{$IFDEF MSWINDOWS}
  C_VLIST_SCROLLBAR_WIDTH = 16;
{$ELSE}
  C_VLIST_SCROLLBAR_WIDTH = 8;
{$ENDIF}
  C_ACCESSORY_WIDTH = 12;

type
  TksVListItem = class;
  TksVListItemList = class;
  TksVirtualListView = class;
  TksVListActionButtons = class;

  TksSelectionType = (ksSingleSelect, ksMultiSelect);
  TksVListCheckBoxAlign = (ksCbLeftAlign, ksCbRightAlign);
  TksVListActionButtonAlign = (ksAbLeftAlign, ksAbRightAlign);
  TksVListSwipeDirection = (ksSwipeFromLeft, ksSwipeFromRight);
  TksVListItemPurpose = (None, Header);
  TksVListItemState = (Normal, Deleting, Deleted, Sliding);

  TksVListItemClickEvent = procedure(Sender: TObject; AItem: TksVListItem)
    of object;
  TksVListItemLongTapEvent = procedure(Sender: TObject; AItem: TksVListItem)
    of object;
  TksVListItemSwipeEvent = procedure(Sender: TObject; ARow: TksVListItem;
    ASwipeDirection: TksVListSwipeDirection; AButtons: TksVListActionButtons)
    of object;
  TksVListDeletingItemEvent = procedure(Sender: TObject; AItem: TksVListItem;
    var ACanDelete: Boolean) of object;

  TksVksListActionButton = class
  strict private
    FWidth: integer;
    FIcon: TBitmap;
    FTextColor: TAlphaColor;
    FColor: TAlphaColor;
    FText: string;
    FIsDeleteButton: Boolean;
    FAccessory: TksAccessoryType;
  private
    FButtonRect: TRectF;
    procedure SetAccessory(const Value: TksAccessoryType);
  private
    procedure SetTextColor(const Value: TAlphaColor);
  public
    constructor Create(AIsDelete: Boolean);
    destructor Destroy; override;
    procedure DrawToCanvas(ACanvas: TCanvas; ARect: TRectF);
    property Accessory: TksAccessoryType read FAccessory write SetAccessory;
    property Text: string read FText write FText;
    property TextColor: TAlphaColor read FTextColor write SetTextColor default claWhite;
    property Color: TAlphaColor read FColor write FColor;
    property Width: integer read FWidth write FWidth default 80;
    property IsDeleteButton: Boolean read FIsDeleteButton write FIsDeleteButton;
  end;

  TksVListActionButtons = class(TObjectList<TksVksListActionButton>)
  strict private
    //FItem: TksVListItem;
    //FPercentWidth: integer;
    FAlignment: TksVListActionButtonAlign;
  private
    function GetTotalWidth: integer;
  public
    constructor Create(AOwner: TksVListItem);
    procedure DrawToCanvas(ACanvas: TCanvas; ARect: TRectF);
    function AddButton(AText: string; AColor, ATextColor: TAlphaColor;
      const AIcon: TksAccessoryType = atNone; const AWidth: integer = 60)
      : TksVksListActionButton;
    function ButtonAtXY(x, y: single): TksVksListActionButton;
    property Alignment: TksVListActionButtonAlign read FAlignment
      write FAlignment;
    property TotalWidth: integer read GetTotalWidth;
  end;

  TksVListCheckBoxOptions = class(TPersistent)
  private
    [weak]
    FOwner: TksVirtualListView;
    FVisible: Boolean;
    FMode: TksSelectionType;
    FAlignment: TksVListCheckBoxAlign;
    procedure SetAlignment(const Value: TksVListCheckBoxAlign);
    procedure SetMode(const Value: TksSelectionType);
    procedure SetVisible(const Value: Boolean);
    procedure Changed;
  public
    constructor Create(AOwner: TksVirtualListView); virtual;
  published
    property Visible: Boolean read FVisible write SetVisible default False;
    property Mode: TksSelectionType read FMode write SetMode
      default ksSingleSelect;
    property Alignment: TksVListCheckBoxAlign read FAlignment write SetAlignment
      default ksCbRightAlign;
  end;

  TksVListSelectionOptions = class(TPersistent)
  private
    [weak]
    FOwner: TksVirtualListView;
    FKeepSelection: Boolean;
    FSelectionType: TksSelectionType;
    procedure SetKeepSelection(const Value: Boolean);
    procedure SetSelectionType(const Value: TksSelectionType);
    procedure Changed;
  public
    constructor Create(AOwner: TksVirtualListView); virtual;
  published
    property KeepSelection: Boolean read FKeepSelection write SetKeepSelection
      default False;
    property SelectionType: TksSelectionType read FSelectionType
      write SetSelectionType default ksSingleSelect;
  end;

  TksVListItemBaseObject = class(TPersistent)
  private
    [weak]
    FOwner: TksVListItem;
    FVertAlign: TVerticalAlignment;
    FHorzAlign: TAlignment;
    FLeft: single;
    FTop: single;
    FWidth: single;
    FHeight: single;
    FVisible: Boolean;
    FOnChange: TNotifyEvent;
    procedure SetVertAlign(const Value: TVerticalAlignment);
    procedure SetHeight(const Value: single);
    procedure SetLeft(const Value: single);
    procedure SetTop(const Value: single);
    procedure SetWidth(const Value: single);
    procedure SetHorzAlign(const Value: TAlignment);
    procedure SetVisible(const Value: Boolean);
  protected
    function CalcObjectRect(AItemRect: TRectF): TRectF; virtual;
    procedure Changed; virtual;
    procedure DrawToCanvas(ACanvas: TCanvas; AItemRect: TRectF); virtual;
  public
    constructor Create(AItem: TksVListItem); virtual;
    property Left: single read FLeft write SetLeft;
    property Top: single read FTop write SetTop;
    property Width: single read FWidth write SetWidth;
    property Height: single read FHeight write SetHeight;
    property HorzAlign: TAlignment read FHorzAlign write SetHorzAlign;
    property VertAlign: TVerticalAlignment read FVertAlign write SetVertAlign;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  TksVListItemTextObject = class(TksVListItemBaseObject)
  private
    FCached: TBitmap;
    FCachedSize: TRectF;
    FTextSettings: TTextSettings;
    FText: string;
    procedure SetText(const Value: string);
    function GetFont: TFont;
    procedure SetFont(const Value: TFont);
  protected
    procedure Changed; override;
    function CalculateSize: TRectF;
  public
    constructor Create(AItem: TksVListItem); override;
    destructor Destroy; override;
    procedure CacheTextToBmp;
    procedure ClearCache;
    procedure DrawToCanvas(ACanvas: TCanvas; AItemRect: TRectF); override;
    property Text: string read FText write SetText;
    property TextSettings: TTextSettings read FTextSettings;
  published
    property Font: TFont read GetFont write SetFont;
  end;

  TksVListItemImageObject = class(TksVListItemBaseObject)
  private
    FBitmap: TBitmap;
    FOwnsImage: Boolean;
    FBackground: TAlphaColor;
    function GetIsEmpty: Boolean;
    procedure SetBackground(const Value: TAlphaColor);
  protected
    procedure SetBitmap(const Value: TBitmap); virtual;
  public
    constructor Create(AItem: TksVListItem); override;
    destructor Destroy; override;
    procedure DrawToCanvas(ACanvas: TCanvas; AItemRect: TRectF); override;
    procedure SetProperties(ABitmap: TBitmap; AOpaqueColor, ABackgroundColor: TAlphaColor);
    procedure SetOpaqueColor(AColor: TAlphaColor);
    property IsEmpty: Boolean read GetIsEmpty;
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property Background: TAlphaColor read FBackground write SetBackground;
  end;

  TksVListItemAccessoryObject = class(TksVListItemImageObject)
  private
    FAccessoryType: TksAccessoryType;
    procedure SetAccessoryType(const Value: TksAccessoryType);
  protected
    procedure SetBitmap(const Value: TBitmap); override;
  public
    constructor Create(AItem: TksVListItem); override;
    procedure DrawToCanvas(ACanvas: TCanvas; AItemRect: TRectF); override;
    property AccessoryType: TksAccessoryType read FAccessoryType
      write SetAccessoryType default atNone;
  end;

  TksVListItem = class // (TFmxObject)
  private
    [weak]FOwner: TksVListItemList;
    // FCachedRow: TBitmap;
    FBackground: TAlphaColor;
    FCanSelect: Boolean;
    FChecked: Boolean;
    FHeight: integer;
    FSelected: Boolean;
    FItemRect: TRectF;
    FImage: TksVListItemImageObject;
    FTitle: TksVListItemTextObject;
    FSubTitle: TksVListItemTextObject;
    FDetail: TksVListItemTextObject;
    FAccessory: TksVListItemAccessoryObject;
    FActionButtons: TksVListActionButtons;
    FOffset: integer;
    FChanged: Boolean;
    FUpdateCount: integer;
    FAbsoluteIndex: integer;
    FIndex: integer;
    FSwipeCalc: TAniCalculations;
    FDeleteCalc: TAniCalculations;
    FTagInt: integer;
    FPurpose: TksVListItemPurpose;
    FState: TksVListItemState;
    FIconSize: integer;
    // events
    FOnClick: TNotifyEvent;
    // procedure CacheRowToBitmap;
    procedure Changed;
    procedure SetAccessory(const Value: TksVListItemAccessoryObject);
    procedure SetDetail(const Value: TksVListItemTextObject);
    procedure SetImage(const Value: TksVListItemImageObject);
    procedure SetTitle(const Value: TksVListItemTextObject);
    procedure SetHeight(const Value: integer);
    procedure UpdateStandardObjectPositions;
    procedure SetSelected(const Value: Boolean);
    procedure SelectItem(ADeselectAfter: integer);
    procedure SetChecked(const Value: Boolean);
    procedure SetSubTitle(const Value: TksVListItemTextObject);
    procedure SetBackground(const Value: TAlphaColor);
    // procedure SetOffset(const Value: integer);
    procedure DeleteItem;
    procedure SlideOut(ADirection: TksVListSwipeDirection);
    procedure SlideIn;
    procedure SwipeCalcChange(Sender: TObject);
    procedure DeleteCalcChange(Sender: TObject);
    function CreateAniCalc(AOnChange: TNotifyEvent): TAniCalculations;
    procedure DoClicked;
    procedure SetPurpose(const Value: TksVListItemPurpose);
    procedure SetOffset(const Value: integer);
    procedure SetCanSelect(const Value: Boolean);
    procedure SetIconSize(const Value: integer);
  public
    constructor Create(Owner: TksVListItemList); virtual;
    destructor Destroy; override;
    function IsItemVisible(AViewPort: TRectF): Boolean;
    function AddText(x, y: single; AText: string)
      : TksVListItemTextObject; overload;
    function AddText(x, y, AWidth: single; AText: string)
      : TksVListItemTextObject; overload;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure CacheItem;
    procedure ClearCache;
    // procedure ShowActionButtons(AAlign: TksVListActionButtonAlign);
    // procedure HideActionButtons;
    procedure DrawToCanvas(ACanvas: TCanvas; AScrollPos: single;
      ADrawToCache: Boolean);
    property AbsoluteIndex: integer read FAbsoluteIndex;
    property Index: integer read FIndex;
    property Background: TAlphaColor read FBackground write SetBackground
      default claNull;
    property CanSelect: Boolean read FCanSelect write SetCanSelect default True;
    property Checked: Boolean read FChecked write SetChecked default False;
    property Height: integer read FHeight write SetHeight;
    property Image: TksVListItemImageObject read FImage write SetImage;
    property Title: TksVListItemTextObject read FTitle write SetTitle;
    property SubTitle: TksVListItemTextObject read FSubTitle write SetSubTitle;
    property Detail: TksVListItemTextObject read FDetail write SetDetail;
    property Accessory: TksVListItemAccessoryObject read FAccessory
      write SetAccessory;
    property ItemRect: TRectF read FItemRect;
    property Selected: Boolean read FSelected write SetSelected;
    property Purpose: TksVListItemPurpose read FPurpose write SetPurpose
      default None;
    property TagInt: integer read FTagInt write FTagInt default 0;
    property State: TksVListItemState read FState write FState default Normal;
    property Offset: integer read FOffset write SetOffset default 0;
    property IconSize: integer read FIconSize write SetIconSize default 28;
    // events...
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TksVListItemList = class
  private
    [weak]
    FOwner: TksVirtualListView;
    FItems: TObjectList<TksVListItem>;
    procedure UpdateItemRects;
    procedure Changed;
    function GetItem(index: integer): TksVListItem;
    function GetCount: integer;
  public
    constructor Create(AOwner: TksVirtualListView); virtual;
    destructor Destroy; override;

    function Add: TksVListItem; overload;
    function Add(ATitle, ASubTitle, ADetail: string;
      const AAccessory: TksAccessoryType = atNone): TksVListItem; overload;
    function AddHeader(AText: string): TksVListItem;
    function Insert(AIndex: integer; ATitle, ASubTitle, ADetail: string;
      const AAccessory: TksAccessoryType = atNone): TksVListItem;
    function ItemAtPos(x, y: single): TksVListItem;
    procedure ClearCachesBeforeIndex(AIndex: integer);
    procedure ClearCachesAfterIndex(AIndex: integer);
    procedure Clear;
    procedure Delete(AIndex: integer; AAnimate: Boolean);
    property Count: integer read GetCount;
    property Items[index: integer]: TksVListItem read GetItem; default;
  end;

  TksVListPullToRefreshOptions = class(TPersistent)
  private
    FPullText: string;
    FReleaseText: string;
    FEnabled: Boolean;
  public
    constructor Create; virtual;
  published
    property PullText: string read FPullText write FPullText;
    property ReleaseText: string read FReleaseText write FReleaseText;
    property Enabled: Boolean read FEnabled write FEnabled default False;
  end;

  TksVListDeleteButton = class(TPersistent)
  private
    FEnabled: Boolean;
    FText: string;
    FColor: TAlphaColor;
    FTextColor: TAlphaColor;
    FWidth: integer;
    FShowImage: Boolean;
  public
    constructor Create; virtual;
  published
    property Color: TAlphaColor read FColor write FColor default claRed;
    property TextColor: TAlphaColor read FTextColor write FTextColor default claWhite;
    property Enabled: Boolean read FEnabled write FEnabled default False;
    property Text: string read FText write FText;
    property ShowImage: Boolean read FShowImage write FShowImage default True;
    property Width: integer read FWidth write FWidth default 60;
  end;

  TksScrollBar = class(TScrollBar)
  public
    constructor Create(AOwner: TComponent); override;
  end;


  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or
{$IFDEF XE8_OR_NEWER} pidiOSDevice32 or pidiOSDevice64
{$ELSE} pidiOSDevice {$ENDIF} or pidiOSSimulator or pidAndroid)]

  TksVirtualListView = class(TksControl)
  private
    FAniCalc: TksAniCalc;

    FCheckBoxOptions: TksVListCheckBoxOptions;
    FItems: TksVListItemList;
    FScrollPos: integer;
    FScrollBar: TksScrollBar;
    FOnScroll: TNotifyEvent;
    FTotalItemHeight: single;
    FMouseDownPos: TPointF;
    FMaxScrollPos: integer;
    FUpdateCount: integer;
    FMouseDownTime: TDateTime;
    FSelectionOptions: TksVListSelectionOptions;
    FPendingRefresh: Boolean;
    FOnPullRefresh: TNotifyEvent;
    FTimerService: IFMXTimerService;
    FLongTapTimer: TFmxHandle;
    FDeletedItemCleanup: TFmxHandle;
    FMousePt: TPointF;
    FMouseDownItem: TksVListItem;
    FEventService: IFMXApplicationEventService;
    // FActionButtons: TksVListActionButtons;
    FPullToRefresh: TksVListPullToRefreshOptions;
    FDeleteButton: TksVListDeleteButton;
    FItemHeight: integer;

    // events...
    FOnItemClick: TksVListItemClickEvent;
    FOnItemLongTap: TksVListItemLongTapEvent;
    FOnItemSwipe: TksVListItemSwipeEvent;
    FOnItemDeleted: TNotifyEvent;
    FCanDeleteItem: TksVListDeletingItemEvent;
    procedure SetScrollPos(const Value: integer);
    procedure AniCalcChange(Sender: TObject);
    procedure AniCalcStart(Sender: TObject);
    procedure AniCalcStop(Sender: TObject);
    function GetViewport: TRectF;
    procedure CacheItems(AStartIndex, AEndIndex: integer);
    // procedure UpdateOverlayPosition;
    procedure SetCheckBoxOptions(const Value: TksVListCheckBoxOptions);
    procedure ScrollBarChanged(Sender: TObject);
    function CreateTimer(AInterval: integer; AProc: TTimerProc): TFmxHandle;
    procedure DoItemLongTap(AItem: TksVListItem);
    procedure LongTapTimerProc;
    procedure KillTimer(var ATimer: TFmxHandle);
    procedure DoItemClicked(AItem: TksVListItem; ACallClickEvent: Boolean);

    function HandleAppEvent(AAppEvent: TApplicationEvent;
      AContext: TObject): Boolean;
    procedure ResetItemOffsets(AIgnore: TksVListItem);
    procedure SetItemHeight(const Value: integer);
  protected
    procedure Paint; override;
    procedure DrawPullToRefresh;
    procedure Resize; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      x, y: single); override;
    procedure MouseMove(Shift: TShiftState; x, y: single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      x, y: single); override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: integer;
      var Handled: Boolean); override;
    procedure DoMouseLeave; override;
    procedure DoItemDeleted;
    // procedure Tap(const Point:TPointF); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DoCleanupDeletedItems;
    procedure DoItemSwiped(AItem: TksVListItem;
      ASwipeDirection: TksVListSwipeDirection);
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    procedure ClearItems;
    procedure Invalidate;
    procedure DeselectAll;
    procedure ScrollTo(const Value: integer);

    procedure UpdateScrollLimmits;
    procedure UncheckAll;
    procedure SwipeItem(AItem: TksVListItem;
      ASwipeDirection: TksVListSwipeDirection);
    procedure SelectItem(AItem: TksVListItem);
    property Items: TksVListItemList read FItems;
    property ScrollPos: integer read FScrollPos write SetScrollPos;
    property Viewport: TRectF read GetViewport;
  published
    property Align;
    property CheckBoxes: TksVListCheckBoxOptions read FCheckBoxOptions
      write SetCheckBoxOptions;
    property DeleteButton: TksVListDeleteButton read FDeleteButton
      write FDeleteButton;
    property Height;
    property ItemHeight: integer read FItemHeight write SetItemHeight
      default C_VLIST_ITEM_DEFAULT_HEIGHT;
    property Position;
    property PullToRefresh: TksVListPullToRefreshOptions read FPullToRefresh
      write FPullToRefresh;
    property SelectionOptions: TksVListSelectionOptions read FSelectionOptions
      write FSelectionOptions;
    property Size;
    property Width;

    property CanDeleteItem: TksVListDeletingItemEvent read FCanDeleteItem
      write FCanDeleteItem;
    property OnItemLongTap: TksVListItemLongTapEvent read FOnItemLongTap
      write FOnItemLongTap;
    property OnItemClick: TksVListItemClickEvent read FOnItemClick
      write FOnItemClick;
    property OnItemSwipe: TksVListItemSwipeEvent read FOnItemSwipe
      write FOnItemSwipe;
    property OnScroll: TNotifyEvent read FOnScroll write FOnScroll;
    property OnPullRefresh: TNotifyEvent read FOnPullRefresh
      write FOnPullRefresh;
    property OnItemDeleted: TNotifyEvent read FOnItemDeleted
      write FOnItemDeleted;
  end;

  // {$R *.dcr}

procedure Register;

implementation

uses SysUtils, Math, System.Math.Vectors, ksCommon,
  DateUtils, FMX.Forms, FMX.Ani, FMX.Dialogs;

var
  AAccessories: TksTableViewAccessoryImageList;

procedure Register;
begin
  RegisterComponents('Kernow Software FMX', [TksVirtualListView]);
end;

{ TksVListItem }

function TksVListItem.AddText(x, y: single; AText: string)
  : TksVListItemTextObject;
begin
  Result := AddText(x, y, MaxSingle, AText);
end;

function TksVListItem.AddText(x, y, AWidth: single; AText: string)
  : TksVListItemTextObject;
begin
  Result := TksVListItemTextObject.Create(Self);
  Result.FLeft := x;
  Result.FTop := y;
end;

procedure TksVListItem.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TksVListItem.CacheItem;
begin
  UpdateStandardObjectPositions;
  FTitle.CacheTextToBmp;
  FSubTitle.CacheTextToBmp;
  FDetail.CacheTextToBmp;
end;

procedure TksVListItem.ClearCache;
begin
  FTitle.ClearCache;
  FSubTitle.ClearCache;
  FDetail.ClearCache;
end;

procedure TksVListItem.Changed;
begin
  if FState <> Normal then
    Exit;
  FChanged := True;
  FOwner.Changed;
end;

constructor TksVListItem.Create(Owner: TksVListItemList);
begin
  inherited Create; // (nil);
  FActionButtons := TksVListActionButtons.Create(Self);
  FOffset := 0;
  FUpdateCount := 0;
  FAbsoluteIndex := 0;
  FIndex := 0;
  FTagInt := 0;
  FIconSize := 28;
  FOwner := Owner;
  FChecked := False;
  FState := Normal;
  FCanSelect := True;
  FBackground := claNull;
  BeginUpdate;
  try
    FHeight := FOwner.FOwner.FItemHeight;

    FImage := TksVListItemImageObject.Create(Self);
    FImage.Width := 32;
    FImage.Height := 32;
    FImage.VertAlign := TVerticalAlignment.taVerticalCenter;

    FTitle := TksVListItemTextObject.Create(Self);
    FTitle.VertAlign := TVerticalAlignment.taVerticalCenter;

    FSubTitle := TksVListItemTextObject.Create(Self);
    FSubTitle.VertAlign := TVerticalAlignment.taVerticalCenter;
    FSubTitle.TextSettings.FontColor := claDimgray;
    FSubTitle.Font.Size := 14;

    FDetail := TksVListItemTextObject.Create(Self);
    FDetail.VertAlign := TVerticalAlignment.taVerticalCenter;
    FDetail.HorzAlign := TAlignment.taRightJustify;
    FDetail.TextSettings.FontColor := claGray;
    FDetail.Font.Size := 14;

    FAccessory := TksVListItemAccessoryObject.Create(Self);
    FAccessory.VertAlign := TVerticalAlignment.taVerticalCenter;
    FAccessory.HorzAlign := TAlignment.taRightJustify;
  finally
    EndUpdate;
  end;
  FChanged := True;
end;

function TksVListItem.CreateAniCalc(AOnChange: TNotifyEvent): TAniCalculations;
begin
  Result := TAniCalculations.Create(nil);
  Result.ViewportPositionF := PointF(FOffset, 0);
  Result.Animation := True;
  Result.Averaging := True;
  Result.Interval := 8;
  Result.OnChanged := AOnChange;
end;

procedure TksVListItem.DeleteItem;
var
  Targets: array of TAniCalculations.TTarget;
begin
  FState := Deleting;
  FreeAndNil(FDeleteCalc);
  FDeleteCalc := CreateAniCalc(DeleteCalcChange);
  FDeleteCalc.ViewportPositionF := PointF(0, FHeight);
  SetLength(Targets, 1);
  Targets[0].TargetType := TAniCalculations.TTargetType.Other;
  Targets[0].Point := TPointD.Create(0, 0);
  FDeleteCalc.SetTargets(Targets);
end;

destructor TksVListItem.Destroy;
begin
  FreeAndNil(FSwipeCalc);
  FreeAndNil(FTitle);
  FreeAndNil(FSubTitle);
  FreeAndNil(FDetail);
  FreeAndNil(FImage);
  FreeAndNil(FAccessory);
  FreeAndNil(FActionButtons);
  inherited;
end;

procedure TksVListItem.DoClicked;
begin
  if Assigned(FOnClick) then
    FOnClick(Self);
end;

procedure TksVListItem.SelectItem(ADeselectAfter: integer);
var
  AStart: TDateTime;
begin
  if (FPurpose <> None) or (FCanSelect = False) then
    Exit;

  Selected := True;
  Application.ProcessMessages;
  if ADeselectAfter > 0 then
  begin
    AStart := Now;
    while MilliSecondsBetween(AStart, Now) < ADeselectAfter do
    begin
      Sleep(10);
      //Application.ProcessMessages;

    end;
    Selected := False;
  end;
end;

procedure TksVListItem.SetAccessory(const Value: TksVListItemAccessoryObject);
begin
  FAccessory.Assign(Value);
  Changed;
end;

procedure TksVListItem.SetBackground(const Value: TAlphaColor);
begin
  if FBackground <> Value then
  begin
    FBackground := Value;
    Changed;
  end;
end;

procedure TksVListItem.SetCanSelect(const Value: Boolean);
begin
  if FCanSelect <> Value then
  begin
    FCanSelect := Value;
    Changed;
  end;
end;

procedure TksVListItem.SetChecked(const Value: Boolean);
begin
  if FChecked <> Value then
  begin
    FChecked := Value;
    Changed;
  end;
end;

procedure TksVListItem.SetDetail(const Value: TksVListItemTextObject);
begin
  FDetail.Assign(Value);
  Changed;
end;

procedure TksVListItem.SetHeight(const Value: integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    Changed;
    if (FHeight = 0) and (FState = Deleting) then
      FState := Deleted;

  end;
end;

procedure TksVListItem.SetIconSize(const Value: integer);
begin
  if FIconSize <> Value then
  begin
    FIconSize := Value;
    Changed;
  end;
end;

procedure TksVListItem.SetImage(const Value: TksVListItemImageObject);
begin
  FImage.Assign(Value);
  // FImage := Value.CreateThumbnail(Round(32 * GetScreenScale), Round(32 * GetScreenScale));
  Changed;
end;

procedure TksVListItem.SetOffset(const Value: integer);
begin
  if FOffset <> Value then
  begin
    FOffset := Value;
    if (FOffset = FActionButtons.TotalWidth) or (FOffset = 0) then
      FState := Normal;

  end;
end;

procedure TksVListItem.SetPurpose(const Value: TksVListItemPurpose);
begin
  if FPurpose <> Value then
  begin
    FPurpose := Value;
    if FPurpose = Header then
      FHeight := C_VLIST_HEADER_DEFAULT_HEIGHT
    else
      FHeight := C_VLIST_ITEM_DEFAULT_HEIGHT;
    Changed;
  end;
end;

procedure TksVListItem.SetSelected(const Value: Boolean);
begin
  if FSelected <> Value then
  begin
    if FCanSelect = False then
      FSelected := False
    else
      FSelected := Value;
    Changed;
  end;
end;

procedure TksVListItem.SetSubTitle(const Value: TksVListItemTextObject);
begin
  FSubTitle.Assign(Value);
  Changed;
end;

procedure TksVListItem.SetTitle(const Value: TksVListItemTextObject);
begin
  FTitle.Assign(Value);
  Changed;
end;

procedure TksVListItem.SlideOut(ADirection: TksVListSwipeDirection);
var
  Targets: array of TAniCalculations.TTarget;

begin
  FState := Sliding;
  FSelected := False;
  FreeAndNil(FSwipeCalc);
  FSwipeCalc := CreateAniCalc(SwipeCalcChange);
  SetLength(Targets, 1);
  Targets[0].TargetType := TAniCalculations.TTargetType.Other;
  if ADirection = ksSwipeFromLeft then
    Targets[0].Point := TPointD.Create(Min(FOffset + FActionButtons.TotalWidth,
      FActionButtons.TotalWidth), 0)
  else
    Targets[0].Point := TPointD.Create(Max(FOffset - FActionButtons.TotalWidth,
      0 - FActionButtons.TotalWidth), 0);
  FSwipeCalc.SetTargets(Targets);
end;

procedure TksVListItem.SlideIn;
var
  Targets: array of TAniCalculations.TTarget;
begin
  FState := Sliding;
  FreeAndNil(FSwipeCalc);
  FSwipeCalc := CreateAniCalc(SwipeCalcChange);
  SetLength(Targets, 1);
  Targets[0].TargetType := TAniCalculations.TTargetType.Other;
  Targets[0].Point := TPointD.Create(0, 0);
  FSwipeCalc.SetTargets(Targets);
end;

procedure TksVListItem.SwipeCalcChange(Sender: TObject);
begin
  Offset := Round(FSwipeCalc.ViewportPosition.x);
  FOwner.FOwner.Invalidate;
end;

procedure TksVListItem.DeleteCalcChange(Sender: TObject);
begin
  if FOwner <> nil then
  begin
    Height := Round(FDeleteCalc.ViewportPosition.y);
    FOwner.UpdateItemRects;
    FOwner.FOwner.Invalidate;
    // if Height = 0 then
    // FOwner.Delete(FIndex, False);
  end;
end;

{ procedure TksVListItem.ShowActionButtons(AAlign: TksVListActionButtonAlign);
  var
  ICOunt: integer;
  begin
  FActionButtons.Alignment := AAlign;
  CacheRowToBitmap;
  if AAlign = ksAbLeftAlign then
  begin

  //for ICount := 0 to 50 do
  //  Offset := ICount;

  end;

  if AAlign = ksAbRightAlign then
  begin
  //for ICount := 0 downto -50 do
  //  Offset := ICount;
  end;
  end;

  procedure TksVListItem.HideActionButtons;
  var
  ICount: integer;
  begin
  if Offset = 0 then
  Exit;
  if FActionButtons.Alignment = ksAbLeftAlign then
  begin
  for ICount := Offset downto 0 do
  Offset := ICount;
  end;

  if FActionButtons.Alignment = ksAbRightAlign then
  begin
  for ICount := Offset to 0 do
  Offset := ICount;
  end;
  end; }

procedure TksVListItem.UpdateStandardObjectPositions;
begin
  Inc(FUpdateCount);
  try
    FTitle.FLeft := 0;
    FTitle.FTop := 0;
    FTitle.FVertAlign := TVerticalAlignment.taVerticalCenter;

    if (FSubTitle.Visible) and (FSubTitle.Text <> '') then
    begin
      FTitle.FTop := (0 - (16 / 2)) - GetScreenScale;
      FSubTitle.FLeft := 0;
      FSubTitle.FTop := 0;
      if FTitle.Visible then
        FSubTitle.FTop := ((16 / 2)) + GetScreenScale;
      FSubTitle.FVertAlign := TVerticalAlignment.taVerticalCenter;
    end;
    FDetail.FLeft := 0;
    FDetail.FTop := 0;
    FDetail.FVertAlign := TVerticalAlignment.taVerticalCenter;

    FAccessory.FLeft := 0;
    FDetail.FTop := 0;
    FDetail.FVertAlign := TVerticalAlignment.taVerticalCenter;

    if FPurpose = Header then
    begin
      FTitle.VertAlign := TVerticalAlignment.taAlignBottom;
      FTitle.Top := -6;
    end;
  finally
    Dec(FUpdateCount);
  end;
end;

procedure TksVListItem.DrawToCanvas(ACanvas: TCanvas; AScrollPos: single;
  ADrawToCache: Boolean);

  function GetCheckBoxImage(AChecked: Boolean): TksAccessoryType;
  begin
    Result := TksAccessoryType.atCheckBox;
    if AChecked then
      Result := TksAccessoryType.atCheckBoxChecked;
  end;

var
  AState: TCanvasSaveState;
  ARect: TRectF;
  AInternalRect: TRectF;
  ACheckBoxRect: TRectF;
  ACheckBoxes: TksVListCheckBoxOptions;
  //ASeperatorStart: single;
  r: TRectF;
  AButtonRect: TRectF;
begin
  if FChanged then
  begin
    UpdateStandardObjectPositions;
    FChanged := False;
  end;

  ARect := FItemRect;
  r := ARect;

  OffsetRect(ARect, FOffset, 0 - AScrollPos);
  OffsetRect(r, 0, 0 - AScrollPos);

  if ADrawToCache then
    OffsetRect(ARect, 0 - ARect.Left, 0 - ARect.Top);

  AInternalRect := ARect;
  AInternalRect.Left := AInternalRect.Left + 8;
  AInternalRect.Right := (AInternalRect.Right - C_VLIST_SCROLLBAR_WIDTH);

  ACanvas.Stroke.Kind := TBrushKind.Solid;
  ACanvas.Fill.Kind := TBrushKind.Solid;

  if FOffset <> 0 then
  begin
    AButtonRect := r;
    if FOffset < 0 then
      AButtonRect.Left := AButtonRect.Right + FOffset
    else
      AButtonRect.Right := AButtonRect.Left + FOffset;
    FActionButtons.DrawToCanvas(ACanvas, AButtonRect);
  end;

  AState := ACanvas.SaveState;
  try
    ACanvas.IntersectClipRect(r);

    if (not FSelected) then
    begin
      ACanvas.Fill.Color := FBackground;
      if FPurpose = Header then
        ACanvas.Fill.Color := $FFEFEFF4;

      if FBackground = claNull then
        ACanvas.Fill.Color := claWhite;
      ACanvas.FillRect(ARect, 0, 0, AllCorners, 1);
    end;

    if FSelected then
    begin
      ACanvas.Fill.Color := claLightgray;
      ACanvas.Stroke.Color := claLightgray;

      ACanvas.FillRect(ARect, 0, 0, AllCorners, 1);
      ACanvas.DrawRect(ARect, 0, 0, AllCorners, 1);
    end;

    ACheckBoxes := FOwner.FOwner.FCheckBoxOptions;
    if ACheckBoxes.Visible then
    begin
      ACheckBoxRect := AInternalRect;
      if ACheckBoxes.Alignment = ksCbLeftAlign then
      begin
        ACheckBoxRect.Right := ACheckBoxRect.Left + 28;
        AInternalRect.Left := AInternalRect.Left + 28;
      end
      else
      begin
        ACheckBoxRect.Left := ACheckBoxRect.Right - 28;
        AInternalRect.Right := AInternalRect.Right - 28;
      end;

      AAccessories.DrawAccessory(ACanvas, ACheckBoxRect,
        GetCheckBoxImage(FChecked), claDimgray, claNull);
    end;

    AInternalRect.Left := AInternalRect.Left + 4;
    AInternalRect.Right := AInternalRect.Right - 4;

    //ASeperatorStart := AInternalRect.Left;

    if FImage.IsEmpty = False then
    begin
      FImage.DrawToCanvas(ACanvas, AInternalRect);
      AInternalRect.Left := AInternalRect.Left + FImage.Width + 12;
    end;

    if FAccessory.Visible then
    begin
      Accessory.DrawToCanvas(ACanvas, AInternalRect);
      AInternalRect.Right := (AInternalRect.Right - C_ACCESSORY_WIDTH) - 4;
    end;

    Title.DrawToCanvas(ACanvas, AInternalRect);
    SubTitle.DrawToCanvas(ACanvas, AInternalRect);
    FDetail.DrawToCanvas(ACanvas, AInternalRect);

  finally
    ACanvas.RestoreState(AState);
  end;
    ACanvas.StrokeThickness := 1 / GetScreenScale;//0.66;//5 * GetScreenScale;
    ACanvas.Stroke.Color := claDarkgray; //$FFC8C7CC; // claGainsboro;

    if (FIndex = 0) {and (FPurpose = None) and (AScrollPos < 0)} then
      ACanvas.DrawLine(PointF(0, ARect.Top+(ACanvas.StrokeThickness/2)), PointF(ARect.Width, ARect.Top+(ACanvas.StrokeThickness/2)), 1);

    ACanvas.DrawLine(PointF(0, ARect.Bottom-(ACanvas.StrokeThickness/2)), PointF(ARect.Width, ARect.Bottom-(ACanvas.StrokeThickness/2)), 1);
end;

procedure TksVListItem.EndUpdate;
begin
  if FUpdateCount > 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then
      Changed;
  end;
end;

function TksVListItem.IsItemVisible(AViewPort: TRectF): Boolean;
var
  r: TRectF;
begin
  Result := IntersectRectF(r, FItemRect, AViewPort);
end;

{ TksVirtualListView }

procedure TksVirtualListView.CacheItems(AStartIndex, AEndIndex: integer);
var
  ICount: integer;
begin
  for ICount := AStartIndex to AEndIndex do
    Items[ICount].CacheItem;
end;

procedure TksVirtualListView.ClearItems;
begin
  FItems.Clear;
end;

function TksVirtualListView.HandleAppEvent(AAppEvent: TApplicationEvent;
  AContext: TObject): Boolean;
begin
  case AAppEvent of
    TApplicationEvent.LowMemory:
      ;
  end;
  Result := True;
end;

constructor TksVirtualListView.Create(AOwner: TComponent);
begin
  inherited;
  TPlatformServices.Current.SupportsPlatformService(IFMXTimerService,
    FTimerService);
  if TPlatformServices.Current.SupportsPlatformService
    (IFMXApplicationEventService, IInterface(FEventService)) then
    FEventService.SetApplicationEventHandler(HandleAppEvent);

  FDeletedItemCleanup := CreateTimer(500, DoCleanupDeletedItems);

  FScrollPos := 0;
  FUpdateCount := 0;
  FItemHeight := C_VLIST_ITEM_DEFAULT_HEIGHT;
  FCheckBoxOptions := TksVListCheckBoxOptions.Create(Self);
  FSelectionOptions := TksVListSelectionOptions.Create(Self);
  FItems := TksVListItemList.Create(Self);
  FScrollBar := TksScrollBar.Create(Self);
  FScrollBar.Stored := False;

  FPullToRefresh := TksVListPullToRefreshOptions.Create;
  FDeleteButton := TksVListDeleteButton.Create;

  FScrollBar.Width := 8;
  FPendingRefresh := False;

  FAniCalc := TksAniCalc.Create(nil);
  FAniCalc.OnChanged := AniCalcChange;
  FAniCalc.ViewportPositionF := PointF(0, 0);
  FAniCalc.Animation := True;
  FAniCalc.Averaging := True;
  FAniCalc.Interval := 8;
  FAniCalc.BoundsAnimation := True;
  FAniCalc.TouchTracking := [ttVertical];
  FAniCalc.OnChanged := AniCalcChange;
  FAniCalc.OnStart := AniCalcStart;
  FAniCalc.OnStop := AniCalcStop;

  FScrollBar.Orientation := TOrientation.Vertical;
  // FScrollBar.Align := TAlignLayout.Right;
  FScrollBar.OnChange := ScrollBarChanged;
  AddObject(FScrollBar);

  HitTest := True;

  if (csDesigning in ComponentState) then
  begin
    Items.Add('Title 1', 'sub title', 'detail');
    Items.Add('Title 2', 'sub title', 'detail');
    Items.Add('Title 3', 'sub title', 'detail');
  end;
end;

destructor TksVirtualListView.Destroy;
begin
  KillTimer(FDeletedItemCleanup);
  FreeAndNil(FAniCalc);
  FreeAndNil(FItems);
  FreeAndNil(FCheckBoxOptions);
  FreeAndNil(FSelectionOptions);
  // FreeAndNil(FActionButtons);
  FreeAndNil(FPullToRefresh);
  FreeAndNil(FDeleteButton);
{$IFDEF NEXTGEN}
  FScrollBar.DisposeOf;
{$ELSE}
  FScrollBar.Free;
{$ENDIF}
  inherited;
end;

procedure TksVirtualListView.DoCleanupDeletedItems;
var
  ICount: integer;
begin
  for ICount := Items.Count - 1 downto 0 do
  begin
    if Items[ICount].State = Deleted then
      Items.Delete(ICount, False);
  end;
end;

procedure TksVirtualListView.DoItemClicked(AItem: TksVListItem;
  ACallClickEvent: Boolean);
begin
  if AItem = nil then
    Exit;

  if FCheckBoxOptions.Visible then
  begin
    if FCheckBoxOptions.FMode = ksSingleSelect then
      UncheckAll;
    AItem.FChecked := not AItem.Checked;
  end;

  SelectItem(AItem);
  Invalidate;
  Application.ProcessMessages;
  AItem.DoClicked;

  if Assigned(FOnItemClick) then
    FOnItemClick(Self, AItem);
end;

procedure TksVirtualListView.DoItemDeleted;
begin
  if Assigned(FOnItemDeleted) then
    FOnItemDeleted(Self);
end;

procedure TksVirtualListView.DoItemSwiped(AItem: TksVListItem;
  ASwipeDirection: TksVListSwipeDirection);
var
  //Targets: array of TAniCalculations.TTarget;
  //ARect: TRectF;
  //ICount: integer;
  ADeleteIcon: TksAccessoryType;
  ADeleteBtn: TksVksListActionButton;
begin
  if AItem.Purpose <> None then
    Exit;

  if AItem.FOffset <> 0 then
  begin
    AItem.SlideIn;
    Exit;
  end;

  FAniCalc.UpdatePosImmediately;

  AItem.FActionButtons.Clear;
  if Assigned(FOnItemSwipe) then
    FOnItemSwipe(Self, AItem, ASwipeDirection, AItem.FActionButtons);
  if ASwipeDirection = ksSwipeFromRight then
  begin
    if FDeleteButton.Enabled then
    begin
      ADeleteIcon := atNone;
      if FDeleteButton.ShowImage then
        ADeleteIcon := atTrash;
      ADeleteBtn := AItem.FActionButtons.AddButton(FDeleteButton.FText,
        FDeleteButton.Color, FDeleteButton.TextColor, ADeleteIcon, 60);
      ADeleteBtn.IsDeleteButton := True;

    end;
  end;

  AItem.SlideOut(ASwipeDirection);
end;

procedure TksVirtualListView.DoMouseLeave;
begin
  inherited;
  if (FAniCalc <> nil) then
    FAniCalc.MouseLeave;
end;

procedure TksVirtualListView.DrawPullToRefresh;
var
  ARefreshArea: TRectF;
  AText: string;
  AState: TCanvasSaveState;
begin
  if (ScrollPos < 0) and (FPullToRefresh.Enabled) then
  begin
    Canvas.Stroke.Color := claGainsboro;
    Canvas.Stroke.Kind := TBrushKind.Solid;
    Canvas.DrawLine(PointF(0, 0 - FScrollPos),
      PointF(Width, 0 - FScrollPos), 1);

    ARefreshArea := RectF(0, 0, Width, 0 - ScrollPos);
    AState := Canvas.SaveState;
    try
      Canvas.IntersectClipRect(ARefreshArea);
      Canvas.Fill.Color := claDimgray;
      Canvas.Font.Size := 14;
      Canvas.Fill.Kind := TBrushKind.Solid;

      AText := FPullToRefresh.PullText;
      if FPendingRefresh then
        AText := FPullToRefresh.ReleaseText;

      Canvas.FillText(RectF(0, 0, Width, 50), AText, False, 1, [],
        TTextAlign.Center, TTextAlign.Center);
    finally
      Canvas.RestoreState(AState);
    end;
  end;
end;

procedure TksVirtualListView.DoItemLongTap(AItem: TksVListItem);
begin
  if Assigned(FOnItemLongTap) then
    FOnItemLongTap(Self, AItem);
end;

procedure TksVirtualListView.LongTapTimerProc;
var
  AItem: TksVListItem;
begin
  if FLongTapTimer = 0 then
    Exit;
  KillTimer(FLongTapTimer);

  if (FAniCalc.Down) then
  begin
    if (FMousePt.y > FMouseDownPos.y - 4) and (FMousePt.y < FMouseDownPos.y + 4)
    then
    begin
      AItem := FItems.ItemAtPos(FMousePt.x, FMousePt.y);
      DoItemClicked(AItem, False);
      //FAniCalc.MouseLeave;
    end;
  end;
end;

procedure TksVirtualListView.DeselectAll;
var
  ICount: integer;
begin
  for ICount := 0 to Items.Count - 1 do
    Items[ICount].Selected := False;
end;

procedure TksVirtualListView.EndUpdate;
begin
  if FUpdateCount > 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then
    begin
      FItems.UpdateItemRects;
      UpdateScrollLimmits;
      CacheItems(0, Min(C_VLIST_CACHE_COUNT - 1, FItems.Count - 1));
      Invalidate;
    end;
  end;
  inherited EndUpdate;
end;

function TksVirtualListView.GetViewport: TRectF;
begin
  Result := RectF(0, 0, Width, Height);
  OffsetRect(Result, 0, FScrollPos);
end;

procedure TksVirtualListView.Invalidate;
begin
  InvalidateRect(ClipRect);
end;

procedure TksVirtualListView.AniCalcStart(Sender: TObject);
begin
  if Scene <> nil then
    Scene.ChangeScrollingState(Self, True);
end;

procedure TksVirtualListView.AniCalcChange(Sender: TObject);
begin
  ScrollPos := Round(FAniCalc.ViewportPosition.y);
end;

procedure TksVirtualListView.AniCalcStop(Sender: TObject);
begin
  TAnimator.AnimateFloat(FScrollBar, 'Opacity', 0);
  if Scene <> nil then
    Scene.ChangeScrollingState(nil, False);
end;

procedure TksVirtualListView.BeginUpdate;
begin
  inherited;
  Inc(FUpdateCount);
end;

procedure TksVirtualListView.Paint;
var
  ICount: integer;
  AState: TCanvasSaveState;
  AItem: TksVListItem;
  AViewPort: TRectF;
  //ARefreshArea: TRectF;
  //ARefreshLabel: string;
  ATopItem: integer;
  //ARect: TRectF;
  //r: TRectF;
begin
  if FUpdateCount > 0 then
    Exit;
  AViewPort := Viewport;

  if (csDesigning in ComponentState) then
    DrawDesignBorder(claDimgray, claDimgray);

  DrawPullToRefresh;

  AState := Canvas.SaveState;
  try
    Canvas.IntersectClipRect(ClipRect);

    ATopItem := -1;

    for ICount := Items.Count - 1 downto 0 do
      if Items[ICount].FState = Deleted then
        Items.Delete(ICount, False);

    for ICount := 0 to Items.Count - 1 do
    begin
      AItem := Items[ICount];
      if AItem.IsItemVisible(AViewPort) then
      begin
        if ATopItem = -1 then
          ATopItem := ICount;
        AItem.DrawToCanvas(Canvas, Trunc(FScrollPos), False);
      end
      else if ATopItem > -1 then
        Break;
    end;
  finally
    Canvas.RestoreState(AState);
  end;
end;

procedure TksVirtualListView.ResetItemOffsets(AIgnore: TksVListItem);
var
  ICount: integer;
begin
  for ICount := FItems.Count - 1 downto 0 do
  begin
    if FItems[ICount].FOffset <> 0 then
    begin
      if FItems[ICount] <> AIgnore then
        FItems[ICount].SlideIn;
    end;
  end;

end;

procedure TksVirtualListView.Resize;
begin
  inherited;
  FItems.UpdateItemRects;
  UpdateScrollLimmits;
  InvalidateRect(ClipRect);
end;

procedure TksVirtualListView.ScrollBarChanged(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
  ScrollPos := Round(FScrollBar.Value);
  FAniCalc.ViewportPositionF := PointF(0, FScrollPos);
  FAniCalc.UpdatePosImmediately;
{$ENDIF}
end;

procedure TksVirtualListView.ScrollTo(const Value: integer);
var
  ANewValue: integer;
begin
  ANewValue := Value;
  if ANewValue < 0 then
    ANewValue := 0;
  if ANewValue > FMaxScrollPos then
    ANewValue := FMaxScrollPos;
  if ((ANewValue - Height) < FMaxScrollPos) and (ANewValue >= 0) then
  begin
    // FScrollPos := ANewValue;
    ScrollPos := ANewValue;
    UpdateScrollLimmits;
    Invalidate;
  end;
end;

procedure TksVirtualListView.SelectItem(AItem: TksVListItem);
begin
  if FSelectionOptions.SelectionType = ksSingleSelect then
  begin
    DeselectAll;
    if FAniCalc.Down then
      AItem.SelectItem(0)
    else
    begin
      case (FSelectionOptions.KeepSelection) of
        True:
          AItem.SelectItem(0);
        False:
          AItem.SelectItem(100);
      end;
    end
  end
  else
  begin
    AItem.Selected := not AItem.Selected;
  end;
end;

procedure TksVirtualListView.SetCheckBoxOptions(const Value
  : TksVListCheckBoxOptions);
begin
  FCheckBoxOptions := Value;
end;

procedure TksVirtualListView.SetItemHeight(const Value: integer);
var
  ICount: integer;
begin
  if FItemHeight <> Value then
  begin
    FItemHeight := Value;
    for ICount := 0 to Items.Count - 1 do
      Items[ICount].FHeight := Value;
    Items.UpdateItemRects;
    Invalidate;
  end;
end;

procedure TksVirtualListView.SetScrollPos(const Value: integer);
begin
  // if not SameValue(FScrollPos, Value, TEpsilon.Vector) then
  if Value <> FScrollPos then

  begin

    FScrollBar.Visible := True;
    FScrollBar.Opacity := 1;
    FScrollPos := Value;
    InvalidateRect(ClipRect);
    if Assigned(FOnScroll) then
      FOnScroll(Self);
    FScrollBar.OnChange := nil;
    FScrollBar.Value := Value;
    FScrollBar.OnChange := ScrollBarChanged;

  end;
end;

procedure TksVirtualListView.SwipeItem(AItem: TksVListItem;
  ASwipeDirection: TksVListSwipeDirection);
begin
  DoItemSwiped(AItem, ASwipeDirection);
end;

procedure TksVirtualListView.UncheckAll;
var
  ICount: integer;
begin
  for ICount := 0 to Items.Count - 1 do
    Items[ICount].FChecked := False;
end;

procedure TksVirtualListView.UpdateScrollLimmits;
var
  Targets: array of TAniCalculations.TTarget;
begin
  if FAniCalc <> nil then
  begin
    SetLength(Targets, 2);
    Targets[0].TargetType := TAniCalculations.TTargetType.Min;
    Targets[0].Point := TPointD.Create(0, 0);
    Targets[1].TargetType := TAniCalculations.TTargetType.Max;

    FMaxScrollPos := Round(Max((FTotalItemHeight - Height), 0));
    if FMaxScrollPos < FScrollPos then
      FScrollPos := FMaxScrollPos;
    Targets[1].Point := TPointD.Create(100, FMaxScrollPos);
    FAniCalc.SetTargets(Targets);
    FAniCalc.ViewportPosition := PointF(0, FScrollPos);
  end;
  FScrollBar.Max := FTotalItemHeight;
  FScrollBar.ViewportSize := Height;
  FScrollBar.Position.y := 0;
  FScrollBar.Position.x := Width - FScrollBar.Width;
  FScrollBar.Height := Height;
  FScrollBar.Visible := FTotalItemHeight > Height;
end;

function TksVirtualListView.CreateTimer(AInterval: integer; AProc: TTimerProc)
  : TFmxHandle;
begin
  Result := 0;
  if FTimerService <> nil then
    Result := FTimerService.CreateTimer(AInterval, AProc);
end;

procedure TksVirtualListView.KillTimer(var ATimer: TFmxHandle);
begin
  if FTimerService <> nil then
  begin
    if (ATimer <> 0) then
    begin
      FTimerService.DestroyTimer(ATimer);
      ATimer := 0;
    end;

  end;
end;

procedure TksVirtualListView.MouseDown(Button: TMouseButton; Shift: TShiftState;
  x, y: single);
var
  ABtn: TksVksListActionButton;
  ACanDelete: Boolean;
begin
  inherited;
  KillTimer(FLongTapTimer);

  FMouseDownTime := Now;
  FMouseDownPos := PointF(x, y);
  FAniCalc.MouseDown(x, y);
  FMouseDownItem := FItems.ItemAtPos(x, y);

  if (FMouseDownItem <> nil) and (FMouseDownItem.FOffset <> 0) then
  begin
    ABtn := FMouseDownItem.FActionButtons.ButtonAtXY(x, y);
    if ABtn <> nil then
    begin
      FAniCalc.MouseUp(x, y);
      if ABtn.IsDeleteButton then
      begin
        ACanDelete := True;
        if Assigned(FCanDeleteItem) then
          FCanDeleteItem(Self, FMouseDownItem, ACanDelete);
        if ACanDelete then
        begin
          FMouseDownItem.DeleteItem;
          Exit;
        end;
      end;
    end;
    FMouseDownItem.SlideIn;
    Exit;
  end;

  ResetItemOffsets(nil);

  if FMouseDownItem <> nil then
    FLongTapTimer := CreateTimer(C_LONG_TAP_DURATION, LongTapTimerProc)
end;

procedure TksVirtualListView.MouseMove(Shift: TShiftState; x, y: single);
begin
  FMousePt := PointF(x, y);
  FAniCalc.MouseMove(x, y);
  FPendingRefresh := ((ScrollPos <= -50) and (FAniCalc.Down));
  if (FAniCalc.Down) and (FMouseDownPos.y <> y) then
  begin
    if FSelectionOptions.KeepSelection = False then
      DeselectAll;
  end;
end;

procedure TksVirtualListView.MouseUp(Button: TMouseButton; Shift: TShiftState;
  x, y: single);
var
  ATapRect: TRectF;
  ASwipeRect: TRectF;
  ATapDuration: integer;
  AItem: TksVListItem;
  ASwipeDirection: TksVListSwipeDirection;
  ADidSwipe: Boolean;
begin
  inherited;
  if FMouseDownItem <> nil then
  begin
    if (FMouseDownItem.State in [Deleting, Deleted, Sliding]) then
    begin
      Exit;
    end;
  end;

  // check for quick tap (within 300 ms)
  FAniCalc.MouseUp(x, y);

  if (FMouseDownItem <> nil) and (FMouseDownItem.FOffset <> 0) then
  begin
    if (FMouseDownItem.State in [Deleting, Deleted]) then
      Exit;
    // check for action button tap...
    if FMouseDownItem.State = Normal then
    begin
      FMouseDownItem.SlideIn;
      Exit;
    end;
  end;

  ATapRect := RectF(FMouseDownPos.x - 8, FMouseDownPos.y - 8,
    FMouseDownPos.x + 8, FMouseDownPos.y + 8);
  ASwipeRect := RectF(0, FMouseDownPos.y - 32, Width, FMouseDownPos.y + 32);
  ATapDuration := MilliSecondsBetween(FMouseDownTime, Now);

  AItem := FMouseDownItem;
  if AItem <> nil then
  begin
    // swipe...
    ADidSwipe := False;
    if PtInRect(ASwipeRect, PointF(x, y)) then
    begin

      if ATapDuration <= C_LONG_TAP_DURATION then
      begin
        // swipe
        if (x < FMouseDownPos.x - 16) or (x > FMouseDownPos.x + 16) then
        begin
          if x < (FMouseDownPos.x) then
            ASwipeDirection := ksSwipeFromRight
          else
            ASwipeDirection := ksSwipeFromLeft;

          DoItemSwiped(AItem, ASwipeDirection);
          FMouseDownItem := nil;
          Exit;
        end;
      end;
    end;

    // tap and long tap
    if (PtInRect(ATapRect, PointF(x, y))) and (ADidSwipe = False) then
    begin
      if ATapDuration <= C_LONG_TAP_DURATION then
      begin
        // tap
        DoItemClicked(AItem, True);
      end
      else
      begin
        // long tap
        DoItemLongTap(AItem);

      end;
    end;

  end;

  if FPendingRefresh then
  begin
    while Trunc(ScrollPos) <> 0 do
    begin
      Sleep(0);
      Application.ProcessMessages;
    end;
    ScrollPos := 0;
    FAniCalc.ViewportPositionF := PointF(0, 0);
    FAniCalc.UpdatePosImmediately;
    FPendingRefresh := False;
    if Assigned(FOnPullRefresh) then
      FOnPullRefresh(Self);
  end;

  if FSelectionOptions.FKeepSelection = False then
    DeselectAll;
end;

procedure TksVirtualListView.MouseWheel(Shift: TShiftState; WheelDelta: integer;
  var Handled: Boolean);
var
  Offset: single;
  ANewPos: single;
begin
  inherited;
  if (csDesigning in ComponentState) then
    Exit;
  if (not Handled) then
  begin
    if not(ssHorizontal in Shift) then
    begin
      FAniCalc.UpdatePosImmediately;
      Offset := Height / 14;
      Offset := Offset * -1 * (WheelDelta / 120);
      ANewPos := Max(FScrollPos + Offset, 0);
      ANewPos := Min(ANewPos, (Max((FTotalItemHeight - Height), 0)));
      ScrollTo(Floor(ANewPos));
      Handled := True;
    end
  end;
end;

{ TksVListItemList }

function TksVListItemList.Add: TksVListItem;
begin
  Result := TksVListItem.Create(Self);
  FItems.Add(Result);
  Changed;
end;

function TksVListItemList.Add(ATitle, ASubTitle, ADetail: string;
  const AAccessory: TksAccessoryType = atNone): TksVListItem;
begin
  Result := Add;
  Result.Title.Text := ATitle;
  Result.SubTitle.Text := ASubTitle;
  Result.Detail.Text := ADetail;
  Result.Accessory.AccessoryType := AAccessory;
  Changed;
end;

function TksVListItemList.AddHeader(AText: string): TksVListItem;
begin
  Result := Add(AText, '', '');
  Result.BeginUpdate;
  try
    Result.Background := claGainsboro;
    Result.Title.Font.Size := 13;
    Result.Title.TextSettings.FontColor := claDimgray;
    Result.Purpose := Header;
    Result.CanSelect := False;
    Result.Title.VertAlign := TVerticalAlignment.taAlignBottom;
  finally
    Result.EndUpdate;

  end;
end;

function TksVListItemList.Insert(AIndex: integer;
  ATitle, ASubTitle, ADetail: string;
  const AAccessory: TksAccessoryType = atNone): TksVListItem;
begin
  Result := TksVListItem.Create(Self);
  Result.Title.Text := ATitle;
  Result.SubTitle.Text := ASubTitle;
  Result.Detail.Text := ADetail;
  Result.Accessory.AccessoryType := AAccessory;
  FItems.Insert(AIndex, Result);
  Changed;
end;

procedure TksVListItemList.Clear;
begin
  FItems.Clear;
  Changed;
end;

procedure TksVListItemList.ClearCachesAfterIndex(AIndex: integer);
var
  ICount: integer;
begin
  for ICount := AIndex to Count - 1 do
    Items[ICount].ClearCache;
end;

procedure TksVListItemList.ClearCachesBeforeIndex(AIndex: integer);
var
  ICount: integer;
begin
  for ICount := AIndex downto 0 do
    Items[ICount].ClearCache;
end;

constructor TksVListItemList.Create(AOwner: TksVirtualListView);
begin
  inherited Create;
  FItems := TObjectList<TksVListItem>.Create;
  FOwner := AOwner;
end;

procedure TksVListItemList.Delete(AIndex: integer; AAnimate: Boolean);
begin
  if (AIndex < 0) or (AIndex > (Count - 1)) then
    Exit;
  if AAnimate then
    FItems[AIndex].DeleteItem
  else
  begin
    FItems.Delete(AIndex);
    FOwner.UpdateScrollLimmits;
    FOwner.DoItemDeleted;

  end;
end;

destructor TksVListItemList.Destroy;
begin
  ClearCachesAfterIndex(0);
  FreeAndNil(FItems);
  inherited;
end;

function TksVListItemList.GetCount: integer;
begin
  Result := FItems.Count;
end;

function TksVListItemList.GetItem(index: integer): TksVListItem;
begin
  Result := FItems[index];
end;

function TksVListItemList.ItemAtPos(x, y: single): TksVListItem;
var
  ICount: integer;
begin
  Result := nil;
  y := y + FOwner.ScrollPos;

  for ICount := 0 to Count - 1 do
  begin
    if PtInRect(Items[ICount].ItemRect, PointF(x, y)) then
    begin
      Result := Items[ICount];
      Exit;
    end;
  end;
end;

procedure TksVListItemList.Changed;
begin
  if FOwner.FUpdateCount > 0 then
    Exit;
  UpdateItemRects;
  FOwner.UpdateScrollLimmits;
  FOwner.Invalidate;
end;

procedure TksVListItemList.UpdateItemRects;
var
  ICount: integer;
  ARect: TRectF;
  AYPos: integer;
  AItem: TksVListItem;
begin
  AYPos := 0;
  FOwner.FTotalItemHeight := 0;
  for ICount := 0 to Count - 1 do
  begin
    AItem := Items[ICount];
    AItem.FAbsoluteIndex := ICount;
    AItem.FIndex := ICount;
    ARect := RectF(0, AYPos, FOwner.Width, AYPos + AItem.Height);
    AItem.FItemRect := ARect;
    AYPos := AYPos + AItem.Height;
    FOwner.FTotalItemHeight := FOwner.FTotalItemHeight + AItem.Height;
  end;
end;

{ TksVListItemTextObject }

procedure TksVListItemTextObject.CacheTextToBmp;
var
  ASize: TRectF;
  AScale: single;
begin
  inherited;
  AScale := GetScreenScale;

  if FCached = nil then
    FCached := TBitmap.Create;

  if (FCached.IsEmpty) and (FText <> '') and (FVisible) then
  begin
    ASize := CalculateSize;

    if FWidth = 0 then
      FWidth := ASize.Width;
    if FHeight = 0 then
      FHeight := ASize.Height;

    FCached.SetSize(Round(ASize.Width * AScale),
      Round(ASize.Height * AScale));
    FCached.BitmapScale := AScale;
    FCached.Clear(claNull);
    //

    FCached.Canvas.Fill.Kind := TBrushKind.Solid;
    FCached.Canvas.BeginScene;
    try
      FCached.Canvas.Fill.Color := FTextSettings.FontColor;
      FCached.Canvas.Font.Assign(FTextSettings.Font);
      FCached.Canvas.FillText(RectF(0, 0, FCached.Width / AScale,
        FCached.Height / AScale), FText, False, 1, [],
        FTextSettings.HorzAlign, TTextAlign.Center);
    finally
      FCached.Canvas.EndScene;
    end;
  end;
end;

function TksVListItemTextObject.CalculateSize: TRectF;
var
  AMeasure: TBitmap;
begin
  Result := FCachedSize;

  if Result.IsEmpty then
  begin
    AMeasure := TBitmap.Create(1, 1);
    try
      AMeasure.BitmapScale := GetScreenScale;

      Result := RectF(0, 0, FWidth, MaxSingle);
      if Result.Width = 0 then
        Result.Width := MaxSingle;

      AMeasure.Canvas.Font.Assign(FTextSettings.Font);
      AMeasure.Canvas.MeasureText(Result, FText, False, [], FTextSettings.HorzAlign, TTextAlign.Leading);

      FCachedSize := Result;
    finally
      FreeAndNil(AMeasure);
    end;
  end;
end;

procedure TksVListItemTextObject.Changed;
begin
  FCachedSize := FCachedSize.Empty;
  if FCached = nil then
    Exit;
  if FCached.IsEmpty = False then
  begin
    FCached.Clear(claNull);
    FCached.SetSize(0, 0);
    FWidth := 0;
  end;
  inherited;
end;

procedure TksVListItemTextObject.ClearCache;
begin
  FreeAndNil(FCached);
end;

constructor TksVListItemTextObject.Create(AItem: TksVListItem);
begin
  inherited Create(AItem);
  FTextSettings := TTextSettings.Create(nil);
  {$IFDEF IOS}
  FTextSettings.Font.Size := 16;
  FTextSettings.Font.Family := 'Segoe UI Semilight';
  {$ENDIF}
  FText := '';
  FCached := nil;
end;

destructor TksVListItemTextObject.Destroy;
begin
  FreeAndNil(FTextSettings);
  FreeAndNil(FCached);
  inherited;
end;

procedure TksVListItemTextObject.DrawToCanvas(ACanvas: TCanvas;
  AItemRect: TRectF);
var
  ARect: TRectF;
begin
  if FText = '' then
    Exit;
  CacheTextToBmp;
  ARect := CalcObjectRect(AItemRect);
  ACanvas.DrawBitmap(FCached, RectF(0, 0, FCached.Width, FCached.Height),
    ARect, 1, True);
end;

function TksVListItemTextObject.GetFont: TFont;
begin
  Result := FTextSettings.Font;
end;

procedure TksVListItemTextObject.SetFont(const Value: TFont);
begin
  FTextSettings.Font.Assign(Value);
  Changed;
end;

procedure TksVListItemTextObject.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;
end;

{ TksVListItemBaseObject }

function TksVListItemBaseObject.CalcObjectRect(AItemRect: TRectF): TRectF;
begin
  Result := RectF(Left, Top, Left + (FWidth), Top + (FHeight));
  OffsetRect(Result, AItemRect.Left, AItemRect.Top);

  case FVertAlign of
    taVerticalCenter:
      OffsetRect(Result, 0, (AItemRect.Height - FHeight) / 2);
    taAlignBottom:
      OffsetRect(Result, 0, AItemRect.Height - FHeight);
  end;

  case FHorzAlign of
    taCenter:
      OffsetRect(Result, (AItemRect.Width - FWidth) / 2, 0);
    taRightJustify:
      OffsetRect(Result, AItemRect.Width - FWidth, 0);
  end;
end;

procedure TksVListItemBaseObject.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
  if FOwner <> nil then
    FOwner.Changed;
end;

constructor TksVListItemBaseObject.Create(AItem: TksVListItem);
begin
  inherited Create;
  FOwner := AItem;
  FVisible := True;
end;

procedure TksVListItemBaseObject.DrawToCanvas(ACanvas: TCanvas;
  AItemRect: TRectF);
begin
  //
end;

procedure TksVListItemBaseObject.SetHeight(const Value: single);
begin
  FHeight := Value;
  Changed;
end;

procedure TksVListItemBaseObject.SetHorzAlign(const Value: TAlignment);
begin
  if FHorzAlign <> Value then
  begin
    FHorzAlign := Value;
    Changed;
  end;
end;

procedure TksVListItemBaseObject.SetLeft(const Value: single);
begin
  FLeft := Value;
  Changed;
end;

procedure TksVListItemBaseObject.SetTop(const Value: single);
begin
  FTop := Value;
  Changed;
end;

procedure TksVListItemBaseObject.SetVertAlign(const Value: TVerticalAlignment);
begin
  if FVertAlign <> Value then
  begin
    FVertAlign := Value;
    Changed;
  end;
end;

procedure TksVListItemBaseObject.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

procedure TksVListItemBaseObject.SetWidth(const Value: single);
begin
  FWidth := Value;
  Changed;
end;

{ TksVListCheckBoxOptions }

procedure TksVListCheckBoxOptions.Changed;
begin
  FOwner.Invalidate;
end;

constructor TksVListCheckBoxOptions.Create(AOwner: TksVirtualListView);
begin
  inherited Create;
  FOwner := AOwner;
  FVisible := False;
  FMode := ksSingleSelect;
  FAlignment := ksCbRightAlign;
end;

procedure TksVListCheckBoxOptions.SetAlignment(const Value
  : TksVListCheckBoxAlign);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Changed;
  end;
end;

procedure TksVListCheckBoxOptions.SetMode(const Value: TksSelectionType);
begin
  if FMode <> Value then
  begin
    FMode := Value;
    Changed;
  end;
end;

procedure TksVListCheckBoxOptions.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TksVListSelectionOptions }

procedure TksVListSelectionOptions.Changed;
begin
  FOwner.Invalidate;
end;

constructor TksVListSelectionOptions.Create(AOwner: TksVirtualListView);
begin
  inherited Create;
  FOwner := AOwner;
  FSelectionType := ksSingleSelect;
  FKeepSelection := False;
end;

procedure TksVListSelectionOptions.SetKeepSelection(const Value: Boolean);
begin
  if FKeepSelection <> Value then
  begin
    FKeepSelection := Value;
    Changed;
  end;
end;

procedure TksVListSelectionOptions.SetSelectionType
  (const Value: TksSelectionType);
begin
  if Value <> FSelectionType then
  begin
    FSelectionType := Value;
    if FSelectionType = ksMultiSelect then
      FKeepSelection := True;
    Changed;
  end;
end;

{ TksVListItemImageObject }

constructor TksVListItemImageObject.Create(AItem: TksVListItem);
begin
  inherited;
  FBitmap := nil;
  FBackground := claNull;
  FOwnsImage := True;
end;

destructor TksVListItemImageObject.Destroy;
begin
  if FOwnsImage then
    FreeAndNil(FBitmap);
  inherited;
end;

procedure TksVListItemImageObject.DrawToCanvas(ACanvas: TCanvas;
  AItemRect: TRectF);
var
  ARect: TRectF;
begin
  inherited;
  ARect := CalcObjectRect(AItemRect);
  if FBackground <> claNull then
  begin
    ACanvas.Fill.Color := FBackground;
    ACanvas.Fill.Kind := TBrushKind.Solid;
    ACanvas.FillRect(ARect, 6, 6, AllCorners, 1);
    InflateRect(ARect, -4, -4);
  end;
  ACanvas.DrawBitmap(FBitmap, RectF(0, 0, FBitmap.Width, FBitmap.Height),
    ARect, 1, False);
end;

function TksVListItemImageObject.GetIsEmpty: Boolean;
begin
  Result := FBitmap = nil;
  if not Result then
    Result := FBitmap.IsEmpty;
end;

procedure TksVListItemImageObject.SetBackground(const Value: TAlphaColor);
begin
  if FBackground <> Value then
  begin
    if Value = claNull then
      Exit;
    FBackground := Value;
    Changed;
  end;
end;

procedure TksVListItemImageObject.SetBitmap(const Value: TBitmap);
begin
  if FOwnsImage then
  begin
    if FBitmap = nil then
    begin
      FBitmap := TBitmap.Create(Round(FWidth*GetScreenScale), Round(FHeight*GetScreenScale));
      FBitmap.Clear(claNull);
    end;
    FBitmap.Canvas.BeginScene;
    try
      FBitmap.Canvas.DrawBitmap(Value, RectF(0, 0, Value.Width, Value.Height),
        RectF(0, 0, FBitmap.Width, FBitmap.Height), 1, False);
    finally
      FBitmap.Canvas.EndScene;
    end;
  end
  else
    FBitmap := Value;
end;

procedure TksVListItemImageObject.SetOpaqueColor(AColor: TAlphaColor);
begin
  if AColor = claNull then
    Exit;
  ReplaceOpaqueColor(FBitmap, AColor);
  Changed;
end;

procedure TksVListItemImageObject.SetProperties(ABitmap: TBitmap; AOpaqueColor,
  ABackgroundColor: TAlphaColor);
begin
  Bitmap := ABitmap;
  SetOpaqueColor(AOpaqueColor);
  SetBackground(ABackgroundColor);
end;

{ TksVListItemAccessoryObject }

constructor TksVListItemAccessoryObject.Create(AItem: TksVListItem);
begin
  inherited;
  FAccessoryType := atNone;
  FOwnsImage := False;
end;

procedure TksVListItemAccessoryObject.DrawToCanvas(ACanvas: TCanvas;
  AItemRect: TRectF);
begin
  if FAccessoryType <> atNone then
    inherited;
end;

procedure TksVListItemAccessoryObject.SetAccessoryType
  (const Value: TksAccessoryType);
begin
  if FAccessoryType <> Value then
  begin
    FAccessoryType := Value;
    Bitmap := AAccessories.GetAccessoryImage(FAccessoryType);
    if Bitmap.IsEmpty then
    begin
      FWidth := 0;
      FHeight := 0;
    end
    else
    begin
      FWidth := Bitmap.Width / GetScreenScale;
      FHeight := Bitmap.Height / GetScreenScale;
    end;
  end;
end;

procedure TksVListItemAccessoryObject.SetBitmap(const Value: TBitmap);
begin
  inherited;
  FWidth := FWidth / GetScreenScale;
  FHeight := FHeight / GetScreenScale;
end;

{ TksVksListActionButton }

constructor TksVksListActionButton.Create(AIsDelete: Boolean);
begin
  inherited Create;
  FIcon := TBitmap.Create;
  FTextColor := claWhite;
  FWidth := 80;
end;

destructor TksVksListActionButton.Destroy;
begin
  FreeAndNil(FIcon);
  inherited;
end;

procedure TksVksListActionButton.DrawToCanvas(ACanvas: TCanvas; ARect: TRectF);
var
  ATextRect: TRectF;
  AIconRect: TRectF;
begin
  FButtonRect := ARect;
  ACanvas.Fill.Kind := TBrushKind.Solid;
  ACanvas.Fill.Color := FColor;
  ACanvas.FillRect(ARect, 0, 0, AllCorners, 1);
  ACanvas.Fill.Color := FTextColor;
  ACanvas.Font.Size := 14;
  ATextRect := ARect;
  ATextRect.Height := CalculateTextHeight(FText, ACanvas.Font, False,
    TTextTrimming.Character);
  if FText = '' then
    ATextRect.Height := 0;

  if FIcon.IsEmpty = False then
  begin
    AIconRect := RectF(ARect.Left, ARect.Top, ARect.Left + (ARect.Height / 2.5),
      ARect.Top + (ARect.Height / 2.5));
    OffsetRect(AIconRect, (ARect.Width - AIconRect.Width) / 2,
      ((ARect.Height - AIconRect.Height) / 2));
    if FText <> '' then
      OffsetRect(AIconRect, 0, -6);
    OffsetRect(ATextRect, 0, AIconRect.Bottom - ATextRect.Top);
    // OffsetRect(ATextRect, 0, ((ARect.Height - AIconRect.Height) / 2) + ATextRect.Height);
    ACanvas.DrawBitmap(FIcon, RectF(0, 0, FIcon.Width, FIcon.Height),
      AIconRect, 1, True);
  end
  else
    OffsetRect(ATextRect, 0, (ARect.Height - ATextRect.Height) / 2);
  ACanvas.FillText(ATextRect, FText, False, 1, [], TTextAlign.Center,
    TTextAlign.Center);
end;

procedure TksVksListActionButton.SetAccessory(const Value: TksAccessoryType);
begin
  FIcon.Assign(AAccessories.GetAccessoryImage(Value));
  FIcon.ReplaceOpaqueColor(FTextColor);

end;

procedure TksVksListActionButton.SetTextColor(const Value: TAlphaColor);
begin
  FTextColor := Value;
  FIcon.ReplaceOpaqueColor(FTextColor);

end;

{ TksVListActionButtons }

function TksVListActionButtons.AddButton(AText: string;
  AColor, ATextColor: TAlphaColor; const AIcon: TksAccessoryType;
  const AWidth: integer): TksVksListActionButton;
begin
  Result := TksVksListActionButton.Create(False);
  Result.Width := AWidth;
  Result.Text := AText;
  Result.Color := AColor;
  Result.TextColor := ATextColor;
  Result.Accessory := AIcon;
  Add(Result);
end;

function TksVListActionButtons.ButtonAtXY(x, y: single): TksVksListActionButton;
var
  ICount: integer;
begin
  Result := nil;
  for ICount := 0 to Count - 1 do
  begin
    if PtInRect(Items[ICount].FButtonRect, PointF(x, y)) then
    begin
      Result := Items[ICount];
      Exit;
    end;
  end;
end;

constructor TksVListActionButtons.Create(AOwner: TksVListItem);
begin
  inherited Create;
end;

procedure TksVListActionButtons.DrawToCanvas(ACanvas: TCanvas; ARect: TRectF);
var
  ICount: integer;
  AWidth: single;
  AXPos: single;
  ABtnRect: TRectF;
begin
  AXPos := 0;
  AWidth := ARect.Width / Count;
  for ICount := 0 to Count - 1 do
  begin
    ABtnRect := RectF(ARect.Left, ARect.Top, ARect.Left + AWidth, ARect.Bottom);
    OffsetRect(ABtnRect, AXPos, 0);
    Items[ICount].DrawToCanvas(ACanvas, ABtnRect);
    AXPos := AXPos + AWidth;
  end;
end;

function TksVListActionButtons.GetTotalWidth: integer;
var
  ICount: integer;
begin
  Result := 0;
  for ICount := 0 to Count - 1 do
    Result := Result + Items[ICount].Width;
end;

{ TksVListPullToRefreshOptions }

constructor TksVListPullToRefreshOptions.Create;
begin
  inherited Create;
  FPullText := 'Pull to refresh...';
  FReleaseText := 'Release to refresh';
  FEnabled := False;
end;

{ TksVListDeleteButton }

constructor TksVListDeleteButton.Create;
begin
  inherited Create;
  FColor := claRed;
  FTextColor := claWhite;
  FEnabled := False;
  FText := 'Delete';
  FShowImage := True;
  FWidth := 60;
end;

{ TksScrollBar }

constructor TksScrollBar.Create(AOwner: TComponent);
begin
  inherited;
  FDesignInteractive := False;
end;

initialization

AAccessories := TksTableViewAccessoryImageList.Create;
GlobalUseGPUCanvas := True;

finalization

FreeAndNil(AAccessories);

end.
