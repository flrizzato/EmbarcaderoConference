{*******************************************************************************
*                                                                              *
*  TksTableView - High-Performance Mobile Scrolling List Component             *
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


//  Contributors
//  ------------
//
//  Thank you to the following for their contribution to this project:
//
//  Simon Farmer
//  Harry James
//

{ *** HTML SUPPORT - PLEASE READ ***

In order to use the HTML formatting within ksListView, you will need to have the
TMS Pack for FireMonkey installed.

You can get this from the following link...
http://www.tmssoftware.com/site/tmsfmxpack.asp

Once installed, simply uncomment the conditional define in ksComponents.inc }

unit ksTableView;

interface

{$I ksComponents.inc}

uses Classes, FMX.Controls, FMX.Layouts, FMX.Types, System.Types, System.Generics.Collections,
  FMX.Graphics, FMX.Objects, FMX.InertialMovement, System.UITypes, System.TypInfo,
  System.UIConsts, System.Rtti, FMX.DateTimeCtrls, FMX.StdCtrls, FMX.Utils,
  FMX.Styles, FMX.Styles.Objects, FMX.Edit, FMX.SearchBox, FMX.ListBox, FMX.Effects,
  ksTypes;

const
  C_TABLEVIEW_DEFAULT_ITEM_HEIGHT = 44;
  C_TABLEVIEW_DEFAULT_HEADER_HEIGHT = 32;
  C_TABLEVIEW_DEFAULT_WIDTH = 200;
  C_TABLEVIEW_DEFAULT_HEIGHT = 300;

  C_TABLEVIEW_DEFAULT_SELECTED_COLOR = $FFD6EFF9;
  C_TABLEVIEW_DEFAULT_FONT_SIZE = 13;

  C_TABLEVIEW_DEFAULT_HEADER_COLOR = $FFF0F0F0;

  C_TABLEVIEW_DEFAULT_INDICATOR_WIDTH = 6;
  C_TABLEVIEW_DEFAULT_INDICATOR_HEIGHT = 0;

  // default which stretches to row height
  C_TABLEVIEW_DEFAULT_IMAGE_SIZE = 24;
  C_TABLEVIEW_DEFAULT_SELECT_DURATION = 200;
  C_TABlEVIEW_SCROLL_THRESHOLD = 10;

  C_TABLEVIEW_REMOVEITEM_SIZE = 20;

  C_TABLEVIEW_ACCESSORY_KEEPCOLOR = $20000000;


  {$IFDEF MSWINDOWS}
  C_SCROLL_BAR_WIDTH = 8;
  {$ELSE}
  C_SCROLL_BAR_WIDTH = 8;
  {$ENDIF}

  {$IFDEF ANDROID}
  C_TABLEVIEW_PAGE_SIZE = 50;
  {$ELSE}
  C_TABLEVIEW_PAGE_SIZE = 50;
  {$ENDIF}

type
  TksTableViewItem = class;
  TksTableViewItemObject = class;
  TksTableView = class;
  TksTableViewItems = class;
  TksTableViewActionButtons = class;
  TksTableViewActionButton = class;
  TksTableViewItemSwitch = class;
  TksTableViewItemTable = class;
  TksTableViewItemEmbeddedBaseEdit = class;
  TksTableViewItemEmbeddedEdit = class;
  TksTableViewItemButton = class;
  TksTableViewSelectionOptions = class;
  TksTableViewItemEmbeddedDateEdit = class;
 // TksTableViewItemBadge = class;

  TksTableItemAlign = (Leading, Center, Trailing, Fit);
  TksSwipeDirection = (ksSwipeUnknown, ksSwipeLeftToRight, ksSwipeRightToLeft, ksSwipeTopToBottom, ksSwipeBottomToTop);
  TksTableViewShape = (ksRectangle, ksSquare, ksRoundRect, ksEllipse);
  TksTableViewItemPurpose = (None, Header);
  TksTableViewCheckMarks = (cmNone, cmSingleSelect, cmMultiSelect);
  TksTableViewCheckMarkPosition = (cmpLeft, cmpRight);
  TksTableViewChatBubblePosition = (ksCbpLeft, ksCbpRight);
  TksTableViewCheckMarkCheckArea = (caWholeRow, caCheckMarkRect);
  TksTableViewActionButtonAlignment = (abLeftActionButtons, abRightActionButtons);
  TksImageDrawMode = (ksDrawModeStretch, ksDrawModeFit);
  TksTableViewButtonStyle = (ksButtonDefault, ksButtonSegmentLeft, ksButtonSegmentMiddle, ksButtonSegmentRight);
  TksTableViewButtonState = (ksPressed, ksUnpressed);
  TksTableViewItemAppearance = ( iaNormal, iaTile_Image, iaTile_TitleImage, iaTile_ImageTitle, iaTile_TitleImageSubTitle, iaTile_SubTitleImageTitle );
  TksTableItemSelector = (NoSelector, DateSelector, ItemPicker);
  TksTableViewOverlaySelectorPosition = (ksSelectorLeft, ksSelectorRight );
  TksTableViewOverlaySelectorStyle = (ksBlankSpace, ksArrow, ksSemiCircle);
  TksTableViewHeaderButtonType = (hbtNone, hbtJumpToHeader);
  TksEmbeddedEditStyle = (ksEditNormal, ksEditClearing, ksEditCombo, ksEditTransparent);
  TksClearCacheType = (ksClearCacheAll, ksClearCacheNonVisible);
  TksTableViewRowSelectAnimation = (ksRowSelectAniNone, ksRowSelectAniFromLeft, ksRowSelectAniFromRight);
  TksTableViewRowIndicatorAlign = (ksRowIndicatorLeft, ksRowIndicatorRight);

  TksTableBeginRowCacheEvent = procedure(Sender: TObject; ARow:TksTableViewItem) of object;
  TksTableViewRowCacheEvent = procedure(Sender: TObject; ACanvas: TCanvas; ARow: TksTableViewItem; ARect: TRectF) of object;
  TksTableViewDeletingItemEvent = procedure(Sender: TObject; AItem: TksTableViewItem; var ACanDelete: Boolean) of object;
  TksTableViewDeleteItemEvent = procedure(Sender: TObject; AItem: TksTableViewItem) of object;
  TksTableViewItemClickEvent = procedure(Sender: TObject; x, y: single; AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject) of object;
  TksItemSwipeEvent = procedure(Sender: TObject; ARow: TksTableViewItem; ASwipeDirection: TksSwipeDirection; AButtons: TksTableViewActionButtons) of object;
  TksItemActionButtonClickEvent = procedure(Sender: TObject; ARow: TksTableViewItem; AButton: TksTableViewActionButton) of object;
  TksTableViewItemSwitchEvent = procedure(Sender: TObject; AItem: TksTableViewItem; ASwitch: TksTableViewItemSwitch; ARowID: string) of object;
  TksTableViewItemButtonEvent = procedure(Sender: TObject; AItem: TksTableViewItem; AButton: TksTableViewItemButton; ARowID: string) of object;
  TksItemChecMarkChangedEvent = procedure(Sender: TObject; ARow: TksTableViewItem; AChecked: Boolean) of object;
  TksTableViewSelectDateEvent = procedure(Sender: TObject; AItem: TksTableViewItem; ASelectedDate: TDateTime; var AAllow: Boolean) of object;
  TksTableViewSelectPickerItem = procedure(Sender: TObject; AItem: TksTableViewItem; ASelected: string; var AAllow: Boolean) of object;
  TksTableViewSelectPickerItemExt = procedure(Sender: TObject; AItem: TksTableViewItem; ASelected: string; AIndex: integer; var AAllow: Boolean) of object;
  TksTableViewEmbeddedEditChange = procedure(Sender: TObject; ARow: TksTableViewItem; AEdit: TksTableViewItemEmbeddedBaseEdit; AText: string) of object;
  TksTableViewEmbeddedDateEditChange = procedure(Sender: TObject; ARow: TksTableViewItem; ADateEdit: TksTableViewItemEmbeddedDateEdit; ADate: TDateTime) of object;
  TksTableViewScrollChangeEvent = procedure(Sender: TObject; AScrollPos, AMaxScrollLimit: single) of object;
  TksTableViewCanDragItemEvent = procedure(Sender: TObject; ADragRow: TksTableViewItem; var AllowDrag: Boolean) of object;
  TksTableViewCanDropItemEvent = procedure(Sender: TObject; ADragRow, ADropRow: TksTableViewItem; var AllowDrop: Boolean)  of object;
  TksTableViewDropItemEvent    = procedure(Sender: TObject; ADragRow, ADropRow: TksTableViewItem; var AllowMove: Boolean) of object;
  TksTableViewSearchFilterChange = procedure(Sender: TObject; ASearchText: string) of object;
  TksTableViewStickyHeaderChange = procedure(Sender: TObject; AFromStickHeader, AToStickHeader: TksTableViewItem) of object;
  TksTableViewRowIndicatorExpandEvent = procedure(Sender: TObject; AItem: TksTableViewItem; ABackground: TAlphaColor; var AForeground: TAlphaColor) of object;

  //---------------------------------------------------------------------------------------

  // TksTableViewActionButton

  TksTableViewActionButton = class
  strict private
    FWidth: integer;
    FIcon: TBitmap;
    FTextColor: TAlphaColor;
    FColor: TAlphaColor;
    FText: string;
    FIsDeleteButton: Boolean;
    FAccessory: TksAccessoryType;
    procedure SetAccessory(const Value: TksAccessoryType);
  public
    constructor Create(AIsDelete: Boolean);
    destructor Destroy; override;
    procedure Render(ACanvas: TCanvas; ARect: TRectF);
    property Accessory: TksAccessoryType read FAccessory write SetAccessory;
    property Text: string read FText write FText;
    property TextColor: TAlphaColor read FTextColor write FTextColor default claWhite;
    property Color: TAlphaColor read FColor write FColor;
    property Width: integer read FWidth write FWidth default 80;
    property IsDeleteButton: Boolean read FIsDeleteButton write FIsDeleteButton;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewActionButtons

  TksTableViewActionButtons = class(TObjectList<TksTableViewActionButton>)
  strict private
    [weak]FTableItem: TksTableviewItem;
    [weak]FTableView: TksTableView;
    FPercentWidth: integer;
    FAlignment: TksTableViewActionButtonAlignment;
    FAnimating: Boolean;
  private
    procedure SetPercentWidth(const Value: integer);
    function GetVisible: Boolean;
    procedure ShowButtons(AItem: TKsTableViewItem);
    procedure HideButtons;
    function TotalWidth: integer;
    property PercentWidth: integer read FPercentWidth write SetPercentWidth;
    property Visible: Boolean read GetVisible;
    procedure Render(ACanvas: TCanvas; ARect: TRectF);
    function ButtonFromXY(x, y: single): TksTableViewActionButton;
    function AddDeleteButton: TksTableViewActionButton;
  public
    constructor Create(AOwner: TksTableView);
    function AddButton(AText: string; AColor, ATextColor: TAlphaColor;
      const AIcon: TksAccessoryType = atNone; const AWidth: integer = 60): TksTableViewActionButton;
    property TableItem: TKsTableviewItem read FTableItem;
    property Alignment: TksTableViewActionButtonAlignment read FAlignment write FAlignment;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewActionButtons

  TksTableViewItemObject = class
  private
    [weak]FTableItem: TksTableViewItem;
    [weak]FPositionRelativeTo : TksTableViewItemObject;
    FAlign: TksTableItemAlign;
    FVertAlign: TksTableItemAlign;
    FID: string;
    FSelected: Boolean;
    FWidth: single;
    FHeight: single;
    FPlaceOffset: TPointF;
    FHitTest: Boolean;
    FOffsetX: single;
    FOffsetY: single;
    FShowSelection: Boolean;
    FMouseDown: Boolean;
    FMargins: TBounds;
    FHeightPercentange : Single;
    FWidthPercentange : Single;
    FVisible: Boolean;
    FItemRect: TRectF;
    procedure SetHeight(const Value: single);
    procedure SetWidth(const Value: single);
    procedure SetHeightPercentange(const Value: single);
    procedure SetWidthPercentange(const Value: single);
    procedure SetPositionRelativeTo(const Value: TksTableViewItemObject);
    procedure SetHitTest(const Value: Boolean);
    procedure SetOffsetX(const Value: single);
    procedure SetOffsetY(const Value: single);
    procedure SetShowSelection(const Value: Boolean);
    procedure SetSelected(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
  protected
    function ConsumesClick: Boolean; virtual;
    function GetItemRect: TRectF;
    function GetObjectRect: TRectF; virtual;
    procedure Changed;
    procedure Render(AItemRect: TRectF; ACanvas: TCanvas); virtual;
    procedure SetAlign(Value: TksTableItemAlign);
    procedure SetVertAlign(Value: TksTableItemAlign);
    procedure SetID(Value: string);
    property ObjectRect: TRectF read GetObjectRect;
    procedure Deselect;
  public
    constructor Create(ATableItem: TksTableViewItem); virtual;
    destructor Destroy; override;
    procedure MouseDown(x, y: single); virtual;
    procedure MouseUp(x, y: single); virtual;
    property Align: TksTableItemAlign read FAlign write SetAlign;
    property Height: single read FHeight write SetHeight;
    property HitTest: Boolean read FHitTest write SetHitTest default True;
    property ID: string read FID write SetID;
    property Margins: TBounds read FMargins write FMargins;
    property OffsetX: single read FOffsetX write SetOffsetX;
    property OffsetY: single read FOffsetY write SetOffsetY;
    property TableItem: TksTableViewItem read FTableItem;
    property VertAlign: TksTableItemAlign read FVertAlign write SetVertAlign;
    property Width: single read FWidth write SetWidth;
    property ShowSelection: Boolean read FShowSelection write SetShowSelection default False;
    property HeightPercentange: single read FHeightPercentange write SetHeightPercentange;
    property WidthPercentange: single read FWidthPercentange write SetWidthPercentange;
    property PositionRelativeTo: TksTableViewItemObject read FPositionRelativeTo write SetPositionRelativeTo;
    property Selected: Boolean read FSelected write SetSelected default False;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  //---------------------------------------------------------------------------------------

  { TksTableViewItemEmbeddedControl }

  TksTableViewItemEmbeddedControl = class(TksTableViewItemObject)
  private
    FFocused: Boolean;
    FCached: TBitmap;
    procedure DoExitControl(Sender: TObject);
    procedure ApplyStyle(AControl: TFmxObject);

  protected
    FControl: TStyledControl;
    function CanFocus: Boolean; virtual;
    function CreateControl: TStyledControl; virtual; abstract;
    function GetControlBitmap(AForceRecreate: Boolean): TBitmap;
    procedure InitializeControl; virtual;
    procedure FocusControl; virtual;
    procedure HideControl; virtual;
    function ConsumesClick: Boolean; override;
    procedure Render(AItemRect: TRectF; ACanvas: TCanvas); override;
    procedure EnableEvents; virtual; abstract;
    procedure DisableEvents; virtual; abstract;

  public
    constructor Create(ATableItem: TksTableViewItem); override;
    destructor Destroy; override;
    procedure MouseDown(x, y: single); override;

  end;

  //---------------------------------------------------------------------------------------

  { TksTableViewItemEmbeddedBaseEdit }

  TksTableViewItemEmbeddedBaseEdit = class(TksTableViewItemEmbeddedControl)
  private
    FStyle: TksEmbeddedEditStyle;
    function GetCustomEdit: TCustomEdit;
    procedure DoEditChange(Sender: TObject);
    procedure SetStyle(const Value: TksEmbeddedEditStyle);
  protected
    function CanFocus: Boolean; override;
    function GetText: string; virtual; abstract;
    procedure SetText(const Value: string); virtual; abstract;
    property CustomEdit: TCustomEdit read GetCustomEdit;
    procedure FocusControl; override;
    procedure HideControl; override;
    procedure EnableEvents; override;
    procedure DisableEvents; override;
    property Text: string read GetText write SetText;
    property Style: TksEmbeddedEditStyle read FStyle write SetStyle;
  end;

  //---------------------------------------------------------------------------------------

  { TksTableViewItemEmbeddedEdit }

  TksTableViewItemEmbeddedEdit = class(TksTableViewItemEmbeddedBaseEdit)
  private
    function GetEditControl: TEdit;
  protected
    function GetText: string; override;
    procedure SetText(const Value: string); override;
    function CreateControl: TStyledControl; override;
  public
    property Style;
    property Text;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewItemEmbeddedDateEdit

  TksTableViewItemEmbeddedDateEdit = class(TksTableViewItemEmbeddedControl)
  private
    function GetEditControl: TDateEdit;
    procedure DoDateChanged(Sender: TObject);
  protected
    function GetDate: TDateTime;
    procedure SetDate(const Value: TDateTime);
    function CreateControl: TStyledControl; override;
    procedure EnableEvents; override;
    procedure DisableEvents; override;
  public
    property Date: TDateTime read GetDate write SetDate;
  end;

  //---------------------------------------------------------------------------------------

  { TksTableViewItemButton }

  TksTableViewItemButton = class(TksTableViewItemEmbeddedControl)
  private
    function GetButton: TSpeedButton;
    function GetTintColor: TAlphaColor;
    procedure SetTintColor(const Value: TAlphaColor);
    function GetText: string;
    procedure SetText(const Value: string);
    procedure DoButtonClicked(Sender: TObject);
    function GetStyleLookup: string;
    procedure SetStyleLookup(const Value: string);
  protected
    function CreateControl: TStyledControl; override;
    procedure EnableEvents; override;
    procedure DisableEvents; override;
  public
    property TintColor: TAlphaColor read GetTintColor write SetTintColor;
    property Text: string read GetText write SetText;
    property StyleLookup: string read GetStyleLookup write SetStyleLookup;
  end;

  //---------------------------------------------------------------------------------------

  { TksTableViewItemSwitch }

  TksTableViewItemSwitch = class(TksTableViewItemEmbeddedControl)
  private
    FClickDelay: TFmxHandle;
    function GetSwitch: TSwitch;
    function GetChecked: Boolean;
    procedure SetChecked(const Value: Boolean);
    procedure DoSwitchClickedDelayed;
    procedure DoSwitchClicked(Sender: TObject);
  protected
    function CreateControl: TStyledControl; override;
    procedure EnableEvents; override;
    procedure DisableEvents; override;
  public
    property Checked: Boolean read GetChecked write SetChecked;
  end;

  //---------------------------------------------------------------------------------------

  { TksTableViewItemText }

  TksTableViewItemText = class(TksTableViewItemObject)
  private
    FBackground: TAlphaColor;
    FText: string;
    FFont: TFont;
    FTextColor: TAlphaColor;
    FTextAlign: TTextAlign;
    FTextVertAlign: TTextAlign;
    FWordWrap: Boolean;
    FTrimming: TTextTrimming;
    FIsHtmlText: Boolean;
    procedure SetText(const Value: string);
    procedure SetFont(const Value: TFont);
    procedure SetTextColor(const Value: TAlphaColor);
    procedure SetTextAlign(const Value: TTextAlign);
    procedure SetTextVertAlign(const Value: TTextAlign);
    procedure SetWordWrap(const Value: Boolean);
    procedure SetTrimming(const Value: TTextTrimming);
    procedure SetBackground(const Value: TAlphaColor);
    procedure FontChanged(Sender: TObject);
    procedure SetIsHtmlText(const Value: Boolean);
  protected
    procedure Render(AItemRect: TRectF; ACanvas: TCanvas); override;
  public
    constructor Create(ATableItem: TksTableViewItem); override;
    destructor Destroy; override;
    function CalculateSize: TSizeF;
    procedure Assign(ASource: TksTableViewItemText);
    property Background: TAlphaColor read FBackground write SetBackground default claNull;
    property Font: TFont read FFont write SetFont;
    property Text: string read FText write SetText;
    property TextColor: TAlphaColor read FTextColor write SetTextColor default claBlack;
    property TextAlignment: TTextAlign read FTextAlign write SetTextAlign default TTextAlign.Leading;
    property TextVertAlign: TTextAlign read FTextVertAlign write SetTextVertAlign default TTextAlign.Leading;
    property Trimming: TTextTrimming read FTrimming write SetTrimming default TTextTrimming.Character;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
    property IsHtmlText: Boolean read FIsHtmlText write SetIsHtmlText;

  end;

  //---------------------------------------------------------------------------------------

  { TksTableViewShadow }

  TksTableViewShadow = class(TPersistent)
  private
    FColor: TAlphaColor;
    FOffset: integer ;
    FVisible: Boolean;
  public
    constructor Create; virtual;
    procedure Assign(ASource: TPersistent); override;
    procedure SetVisible(const Value: Boolean);
    property Color: TAlphaColor read FColor write FColor default claSilver;
    property Offset: integer read FOffset write FOffset default 2;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  //---------------------------------------------------------------------------------------

  { TksListItemRowTableCell }

  TksListItemRowTableCell = class(TPersistent)
  private
    [weak]FTable: TksTableViewItemTable;
    FRow, FCol: integer;
    FTextSettings: TTextSettings;
    FFill: TBrush;
    FStroke: TStrokeBrush;
    FText: string;
    FWidth: single;
    FHeight: single;
    FPadding: TBounds;
    FVisible: Boolean;
    FSides: TSides;
    procedure SetText(const Value: string);
    procedure SetTextSettings(const Value: TTextSettings);
    procedure SetVisible(const Value: Boolean);
    procedure Changed;
    function GetShadow: TksTableViewShadow;
  public
    constructor Create(ATable: TksTableViewItemTable); virtual;
    destructor Destroy; override;
    function IsFixedCell: Boolean;
    procedure DrawToCanvas(x, y: single; ACanvas: TCanvas; ACol, ARow: integer; AShadow: TksTableViewShadow; AText: Boolean);
    property Fill: TBrush read FFill;
    property Stroke: TStrokeBrush read FStroke;
    property TextSettings: TTextSettings read FTextSettings write SetTextSettings;
    property Text: string read FText write SetText;
    property Width: single read FWidth write FWidth;
    property Height: single read FHeight write FHeight;
    property Padding: TBounds read FPadding write FPadding;
    property Shadow: TksTableViewShadow read GetShadow;
    property Sides: TSides read FSides write FSides;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  TksListItemRowTableRow = array of TksListItemRowTableCell;

  //---------------------------------------------------------------------------------------

  // TksListItemRowTableBanding

  TksListItemRowTableBanding = class(TPersistent)
  private
    FActive: Boolean;
    FColor2: TAlphaColor;
    FColor1: TAlphaColor;
    procedure SetActive(const Value: Boolean);
  public
    constructor Create; virtual;
    procedure Assign(ASource: TPersistent); override;
    property Color1: TAlphaColor read FColor1 write FColor1 default claNull;
    property Color2: TAlphaColor read FColor2 write FColor2 default claNull;
    property Active: Boolean read FActive write SetActive;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewItemTable

  TksTableViewItemTable = class(TksTableViewItemObject)
  private
    FBackground: TAlphaColor;
    FBorderColor: TAlphaColor;
    FRows: array of TksListItemRowTableRow;
    FRowCount: integer;
    FColCount: integer;
    FDefaultRowHeight: single;
    FDefaultColWidth: single;
    FShadow: TksTableViewShadow;
    FFixedCellColor: TAlphaColor;
    FFixedRows: integer;
    FFixedCols: integer;
    FBanding: TksListItemRowTableBanding;
    procedure SetColCount(const Value: integer);
    procedure SetRowCount(const Value: integer);
    procedure SetBackgroundColor(const Value: TAlphaColor);
    procedure SetBorderColor(const Value: TAlphaColor);
    procedure SetDefaultColWidth(const Value: single);
    procedure SetDefaultRowHeight(const Value: single);

    procedure ResizeTable;
    function GetColWidths(ACol: integer): single;
    procedure SetColWidths(ACol: integer; const Value: single);
    function GetCells(ACol, ARow: integer): TksListItemRowTableCell;
    function GetTableSize: TSizeF;
    procedure RenderTableContents(ACanvas: TCanvas; AText: Boolean);
    procedure SetFixedCellColor(const Value: TAlphaColor);
    procedure SetBanding(const Value: TksListItemRowTableBanding);
  protected
    procedure Render(AItemRect: TRectF; ACanvas: TCanvas); override;
  public
    constructor Create(ARow: TKsTableViewItem); override;
    destructor Destroy; override;
    procedure Clear;
    procedure MergeRowCells(x, y, AMergeCount: integer);
    procedure SetRowColor(ARow: integer; AColor: TAlphaColor);
    procedure SetColColor(ACol: integer; AColor: TAlphaColor);
    procedure SetRowFont(ARow: integer; AFontName: TFontName; AColor: TAlphaColor; ASize: integer; AStyle: TFontStyles);
    procedure SetColFont(ACol: integer; AFontName: TFontName; AColor: TAlphaColor; ASize: integer; AStyle: TFontStyles);
    property Background: TAlphaColor read FBackground write SetBackgroundColor default claWhite;
    property Banding: TksListItemRowTableBanding read FBanding write SetBanding;
    property BorderColor: TAlphaColor read FBorderColor write SetBorderColor default claBlack;
    property FixCellColor: TAlphaColor read FFixedCellColor write SetFixedCellColor default claGainsboro;
    property FixedRows: integer read FFixedRows write FFixedRows default 1;
    property FixedCols: integer read FFixedCols write FFixedCols default 1;
    property Cells[ACol, ARow: integer]: TksListItemRowTableCell read GetCells;
    property ColCount: integer read FColCount write SetColCount;
    property RowCount: integer read FRowCount write SetRowCount;
    property DefaultRowHeight: single read FDefaultRowHeight write SetDefaultRowHeight;
    property DefaultColWidth: single read FDefaultColWidth write SetDefaultColWidth;
    property ColWidths[ACol: integer]: single read GetColWidths write SetColWidths;
    property Shadow: TksTableViewShadow read FShadow;
    property TableSize: TSizeF read GetTableSize;
  end;


  //---------------------------------------------------------------------------------------

  // TksTableViewItemBaseImage

  TksTableViewItemBaseImage = class(TksTableViewItemObject)
  strict private
    FBitmap: TBitmap;
    FDrawMode: TksImageDrawMode;
    FShadow: TksTableViewShadow;
    FHighQuality: Boolean;
    FBadgeValue: integer;
    FBadgeColor: TAlphaColor;
    FBadgeTextColor: TAlphaColor;
    [weak]FExternalBitmap: TBitmap;
  private
    FOwnsBitmap: Boolean;
    procedure SetBitmap(const Value: TBitmap);
    function GetBitmap: TBitmap;
    procedure SetOwnsBitmap(const Value: Boolean);
    procedure SetShadow(const Value: TksTableViewShadow);
    procedure SetDrawMode(const Value: TksImageDrawMode);
    procedure SetHighQuality(const Value: Boolean);
    procedure SetBadgeValue(const Value: integer);
    procedure SetBadgeColor(const Value: TAlphaColor);
    procedure SetBadgeTextColor(const Value: TAlphaColor);
  protected
    procedure Render(AItemRect: TRectF; ACanvas: TCanvas); override;
    procedure Clear;
    procedure DoBeforeRenderBitmap(ABmp: TBitmap); virtual;
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
    property Shadow: TksTableViewShadow read FShadow write SetShadow;
    property OwnsBitmap: Boolean read FOwnsBitmap write SetOwnsBitmap default False;
    property DrawMode: TksImageDrawMode read FDrawMode write SetDrawMode default ksDrawModeStretch;
    property HighQuality: Boolean read FHighQuality write SetHighQuality default False;
    property BadgeValue: integer read FBadgeValue write SetBadgeValue;
    property BadgeColor: TAlphaColor read FBadgeColor write SetBadgeColor default claRed;
    property BadgeTextColor: TAlphaColor read FBadgeTextColor write SetBadgeTextColor default claWhite;
  public
    constructor Create(ATableItem: TksTableViewItem); override;
    destructor Destroy; override;
    procedure Assign(ASource: TksTableViewItemBaseImage);
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewItemImage

  TksTableViewItemImage = class(TksTableViewItemBaseImage)
  public
    property Bitmap;
    property Shadow;
    property DrawMode;
    property OwnsBitmap;
    property HighQuality;
    property BadgeValue;
    property BadgeColor;
    property BadgeTextColor;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewItemShape

  TksTableViewBaseItemShape = class(TksTableViewItemObject)
  private
    FStroke: TStrokeBrush;
    FFill: TBrush;
    FShape: TksTableViewShape;
    FCornerRadius: single;
    procedure SetCornerRadius(const Value: single);
    procedure SetFill(const Value: TBrush);
    procedure SetShape(const Value: TksTableViewShape);
    procedure SetStroke(const Value: TStrokeBrush);
  protected
    procedure Render(AItemRect: TRectF; ACanvas: TCanvas); override;
    property Stroke: TStrokeBrush read FStroke write SetStroke;
    property Fill: TBrush read FFill write SetFill;
    property Shape: TksTableViewShape read FShape write SetShape;
    property CornerRadius: single read FCornerRadius write SetCornerRadius;
  public
    constructor Create(ATableItem: TksTableViewItem); override;
    destructor Destroy; override;
  end;

  TksTableViewItemShape = class(TksTableViewBaseItemShape)
  public
    property Stroke;
    property Fill;
    property Shape;
    property CornerRadius;
  end;

  TksTableViewChatBubble = class(TksTableViewItemShape)
  private
    FText: string;
    FFont: TFont;
    FTextColor: TAlphaColor;
    FPosition: TksTableViewChatBubblePosition;
    procedure SetFont(const Value: TFont);
    procedure SetText(const Value: string);
    procedure SetTextColor(const Value: TAlphaColor);
  protected
    procedure RecalculateSize;
    procedure Render(AItemRect: TRectF; ACanvas: TCanvas); override;
  public
    constructor Create(ATableItem: TksTableViewItem); override;
    destructor Destroy; override;
    property Text: string read FText write SetText;
    property Font: TFont read FFont write SetFont;
    property TextColor: TAlphaColor read FTextColor write SetTextColor;
    property Position: TksTableViewChatBubblePosition read FPosition write FPosition;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewItemTileBackground

  TksTableViewItemTileBackground = class(TksTableViewItemShape)
  private
    FPadding: TBounds;
  public
    constructor Create(ATableItem: TksTableViewItem); override;
    destructor Destroy; override;

    procedure Assign(ASource: TksTableViewItemTileBackground);

    property Padding: TBounds read FPadding write FPadding;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewItemAccessory

  TksTableViewItemAccessory = class(TksTableViewItemImage)
  strict private
    FColor: TAlphaColor;
  private
    FAccessory: TksAccessoryType;
    procedure RedrawAccessory;
  protected
    procedure DoBeforeRenderBitmap(ABmp: TBitmap); override;
    procedure SetAccessory(const Value: TksAccessoryType);
    procedure SetColor(const Value: TAlphaColor);
    procedure Render(AItemRect: TRectF; ACanvas: TCanvas); override;
  public
    constructor Create(ATableItem: TksTableViewItem); override;
    property Accessory: TksAccessoryType read FAccessory write SetAccessory;
    property Color: TAlphaColor read FColor write SetColor default claNull;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewItemObjects

  TksTableViewItemObjects = class(TObjectList<TksTableViewItemObject>)
  private
    [weak]FTableView: TksTableView;
    function GetObjectByID(AId: string): TksTableViewItemObject;
    function GetImageByID(AId: string): TksTableViewItemImage;
    function GetTextByID(AId: string): TksTableViewItemText;
  public
    constructor Create(ATableView: TksTableView); virtual;
    property ObjectByID[AId: string]: TksTableViewItemObject read GetObjectByID;
    property ImageByID[AId: string]: TksTableViewItemImage read GetImageByID;
    property TextByID[AId: string]: TksTableViewItemText read GetTextByID;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewItem

  TksTableViewItem = class
  private
    [weak]FTableView: TksTableView;
    [weak]FCheckMarkAccessory: TksTableViewItemAccessory;
    [weak]FTagObject: TObject;
    [weak]FOwner: TksTableViewItems;
    FData: TDictionary<string, TValue>;
    FID: string;
    FAbsoluteIndex: integer;
    FIndicator: TksTableViewItemShape;
    FTileBackground: TksTableViewItemTileBackground;
    FImage: TksTableViewItemImage;
    FTitle: TksTableViewItemText;
    FSubTitle: TksTableViewItemText;
    FDetail: TksTableViewItemText;
    FAccessory: TksTableViewItemAccessory;

    FHeight: single;
    FHeightPercentage: single;
    FHeaderHeight: single;
    FIsStickyHeader: boolean;
    FItemRect: TRectF;
    FCached: Boolean;
    FCaching: Boolean;
    _FBitmap: TBitmap;
    FIndex: integer;
    FSearchIndex: string;
    FSearchFilter: string;
    FChecked: Boolean;
    FUpdating: Boolean;
    FPurpose: TksTableViewItemPurpose;
    FObjects: TksTableViewItemObjects;
    FSelectionValue: Variant;
    FFont: TFont;
    FTextColor: TAlphaColor;
    FCanSelect: Boolean;
    FTagString: string;
    FTagInteger: integer;
    FSelector: TksTableItemSelector;
    FPickerItems: TStrings;
    FColCount: integer;
    FIsFirstCol : Boolean;
    FIsLastCol : Boolean;
    FIsFirstRow : Boolean;
    FIsLastRow : Boolean;
    FIsFixedHeader : Boolean;
    FIsFixedFooter : Boolean;
    FAppearance : TksTableViewItemAppearance;
    FDragging: Boolean;
    FFill : TBrush;
    FCheckmarkAllowed: Boolean;
    FHidden: Boolean;
    FDeleting: Boolean;
    FForegroundColor: TAlphaColor;
    function MatchesSearch(AFilter: string): Boolean;
    function IsVisible(AViewport: TRectF): Boolean;
    function GetInternalRect: TRectF;
    //procedure SetSearchIndex(const Value: string);
    procedure SetItemRect(const Value: TRectF);
    procedure SetIndex(const Value: integer);
    procedure SetAppearance(const Value: TksTableViewItemAppearance);
    procedure SetHidden(const Value: Boolean);
    procedure Changed;
    procedure RealignStandardObjects;
    procedure SetHeight(const Value: single);
    procedure SetHeightPercentage(const Value: single);
    procedure SetCached(const Value: Boolean);
    procedure SetPurpose(const Value: TksTableViewItemPurpose);
    procedure SetColCount(const Value: Integer);
    procedure SetFont(const Value: TFont);
    procedure SetTextColor(const Value: TAlphaColor);
    procedure SetChecked(const Value: Boolean);
    function CheckMarkClicked(x, y: single) : Boolean;
    procedure DoClick(x, y: single);
    function GetIndicatorColor: TAlphaColor;
    procedure SetIndicatorColor(const Value: TAlphaColor);
    procedure DoSwipe(ADirecton: TksSwipeDirection);
    procedure SetPickerItems(const Value: TStrings);
    procedure PickerItemsChanged(Sender: TObject);
    function GetItemData(const AIndex: string): TValue;
    procedure SetItemData(const AIndex: string; const Value: TValue);
    function GetHasData(const AIndex: string): Boolean;
    procedure DeselectObjects;
    procedure SetFill(const Value: TBrush);
    procedure SelectFirstEmbeddedEdit;
    function IsHeader: Boolean;
    procedure Invalidate;
    function GetImageByID(AID: string): TksTableViewItemImage;
    function GetTextByID(AID: string): TksTableViewItemText;
    procedure SetSearchFilter(const Value: string);

  protected
    function Render(ACanvas: TCanvas; AScrollPos: single): TRectF;
    procedure CacheItem(const AForceCache: Boolean = False);
    procedure UpdateSearchIndex;
  public
    constructor Create(ATableView: TksTableView); reintroduce; virtual;
    destructor Destroy; override;
    function TimeToCacheItem: integer;
    function ObjectAtPos(x, y: single): TksTableViewItemObject;
    function IsLastItem: Boolean;
    //procedure RecreateCache;
    procedure ClearCache;
    procedure ExpandIndicatorToWidth;
    // image functions...
    function DrawBitmap(ABmp: TBitmap; ARect: TRectF; const AVertAlign: TksTableItemAlign = Center): TksTableViewItemImage; overload;
    function DrawBitmap(ABmp: TBitmap; x, AWidth, AHeight: single; const AVertAlign: TksTableItemAlign = Center): TksTableViewItemImage; overload;
    function DrawBitmap(ABmp: TBitmap; x, y, AWidth, AHeight: single; const AVertAlign: TksTableItemAlign = Center): TksTableViewItemImage overload;
    // text functions...
    function TextWidth(AText: string; AIsHtml: Boolean): single;
    function TextHeight(AText: string; AWordWrap, AIsHtml: Boolean; ATrimming: TTextTrimming; const AMaxWidth: single): single;
    procedure SetItemFontStyle(AFontStyle: TFontStyles);
    procedure SetItemTextColor(AColor: TAlphaColor);
    function TextOut(AText: string; x: single; const AVertAlign: TksTableItemAlign = TksTableItemAlign.Center; const AWordWrap: Boolean = False): TksTableViewItemText; overload;
    function TextOut(AText: string; x, AWidth: single; const AVertAlign: TksTableItemAlign = TksTableItemAlign.Center; const AWordWrap: Boolean = False): TksTableViewItemText; overload;
    function TextOut(AText: string; x, y, AWidth: single; const AVertAlign: TksTableItemAlign = TksTableItemAlign.Center; const AWordWrap: Boolean = False): TksTableViewItemText; overload;
    function TextBox(AText: string; ARect: TRectF; ATextAlign: TTextAlign; ATextLayout: TTextAlign; const ABackground: TAlphaColor = claNull): TksTableViewItemText; overload;
    function TextBoxHtml(AText: string; ARect: TRectF): TksTableViewItemText;
    function TextOutRight(AText: string; y, AWidth: single; AXOffset: single; const AVertAlign: TksTableItemAlign = TksTableItemAlign.Center): TksTableViewItemText; overload;
    // shape functions...
    function DrawChatBubble(AText: string; APosition: TksTableViewChatBubblePosition; AColor, ATextColor: TAlphaColor): TksTableViewChatBubble;
    function DrawRect(x, y, AWidth, AHeight: single; AStroke, AFill: TAlphaColor; const AVertAlign: TksTableItemAlign = TksTableItemAlign.Center): TksTableViewItemShape; overload;
    function DrawRect(ARect: TRectF; AStroke, AFill: TAlphaColor; const AVertAlign: TksTableItemAlign = TksTableItemAlign.Center): TksTableViewItemShape; overload;
    function AddButton(AWidth: integer; AText: string;
                       const ATintColor: TAlphaColor = claNull;
                       const AVertAlign: TksTableItemAlign = TksTableItemAlign.Center;
                       const AYPos: integer = 0): TksTableViewItemButton; overload;
    function AddButton(AStyle: TksTableViewButtonStyle; const ATintColor: TAlphaColor = claNull): TksTableViewItemButton; overload;
    function AddEdit(AX, AY, AWidth: single; AText: string; const AStyle: TksEmbeddedEditStyle = TksEmbeddedEditStyle.ksEditNormal): TksTableViewItemEmbeddedEdit;
    function AddDateEdit(AX, AY, AWidth: single; ADate: TDateTime): TksTableViewItemEmbeddedDateEdit;
    function AddSwitch(x: single; AIsChecked: Boolean; const AAlign: TksTableItemAlign = TksTableItemAlign.Trailing): TksTableViewItemSwitch;
    function AddTable(AX, AY, AColWidth, ARowHeight: single; AColCount, ARowCount: integer): TksTableViewItemTable;
    property AbsoluteIndex: integer read FAbsoluteIndex;
    property Accessory: TksTableViewItemAccessory read FAccessory;
    property CheckMarkAccessory: TksTableViewItemAccessory read FCheckMarkAccessory;
    property CanSelect: Boolean read FCanSelect write FCanSelect default True;
    property Checked: Boolean read FChecked write SetChecked default False;
    property Data[const AIndex: string]: TValue read GetItemData write SetItemData;
    property Font: TFont read FFont write SetFont;
    property HasData[const AIndex: string]: Boolean read GetHasData;
    property Height: single read FHeight write SetHeight;
    property HeightPercentage: single read FHeightPercentage write SetHeightPercentage;
    property ItemRect: TRectF read FItemRect write SetItemRect;
    property IndicatorColor: TAlphaColor read GetIndicatorColor write SetIndicatorColor;
    property ID: string read FID write FID;
    property TileBackground : TksTableViewItemTileBackground read FTileBackground;
    property Image: TksTableViewItemImage read FImage;
    property Title: TksTableViewItemText read FTitle;
    property SubTitle: TksTableViewItemText read FSubTitle;
    property TextColor: TAlphaColor read FTextColor write SetTextColor default claBlack;
    property Detail: TksTableViewItemText read FDetail;
    property Index: integer read FIndex write SetIndex;
    //property SearchIndex: string read GetSearchIndex;
    property SearchFilter: string read FSearchFilter write SetSearchFilter;
    property Objects: TksTableViewItemObjects read FObjects;
    property ImageByID[AID: string]: TksTableViewItemImage read GetImageByID;
    property TextByID[AID: string]: TksTableViewItemText read GetTextByID;
    property Cached: Boolean read FCached write SetCached default False;
    property PickerItems: TStrings read FPickerItems write SetPickerItems;
    property Purpose: TksTableViewItemPurpose read FPurpose write SetPurpose default None;
    property Selector: TksTableItemSelector read FSelector write FSelector;
    property TableView: TksTableView read FTableView;
    property TagString: string read FTagString write FTagString;
    property TagInteger: integer read FTagInteger write FTagInteger default 0;
    property TagObject: TObject read FTagObject write FTagObject;
    property ColCount: integer read FColCount write SetColCount default 0;
    property IsFirstCol: Boolean read FIsFirstCol;
    property IsLastCol: Boolean read FIsLastCol;
    property IsFirstRow: Boolean read FIsFirstRow;
    property IsLastRow: Boolean read FIsLastRow;
    property Appearance: TksTableViewItemAppearance read FAppearance write SetAppearance default iaNormal;
    property Fill: TBrush read FFill write SetFill;
    property IsStickyHeader: Boolean read FIsStickyHeader;
    property Hidden: Boolean read FHidden write SetHidden default false;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewItems

  TksTableViewItems = class(TObjectList<TksTableViewItem>)
  private
    FCachedCount: integer;
    {$IFNDEF VER310}
    [weak]FTableView: TksTableView;
    procedure UpdateIndexes;
    {$ENDIF}
    function GetLastItem: TksTableViewItem;
    function GetFirstItem: TksTableViewItem;
    function GetItemByID(AID: string): TksTableViewItem;
  protected
    {$IFDEF VER310}
    [weak]FTableView: TksTableView;
    procedure UpdateIndexes;
    {$ENDIF}
    function GetTotalItemHeight: single;
  public
    constructor Create(ATableView: TksTableView; AOwnsObjects: Boolean); virtual;
    procedure Move(CurIndex, NewIndex: Integer); overload;
    function AddHeader(AText: string): TksTableViewItem;
    function AddItem(AText: string; const AAccessory: TksAccessoryType = atNone): TksTableViewItem; overload;
    function AddItem(AText, ADetail: string; const AAccessory: TksAccessoryType = atNone): TksTableViewItem; overload;
    function AddItem(AText, ASubTitle, ADetail: string; const AAccessory: TksAccessoryType = atNone): TksTableViewItem; overload;
    function AddChatBubble(AText: string; APosition: TksTableViewChatBubblePosition; AColor, ATextColor: TAlphaColor; const AUserImage: TBitmap): TksTableViewChatBubble;
    function AddDateSelector(AText: string; ADate: TDateTime): TksTableViewItem;
    function AddItemSelector(AText, ASelected: string; AItems: TStrings): TksTableViewItem; overload;
    function AddItemSelector(AText, ASelected: string; AItems: array of string): TksTableViewItem; overload;
    function AddItemWithSwitch(AText: string; AChecked: Boolean; AID: string): TksTableViewItem;
    property ItemByID[AID: string]: TksTableViewItem read GetItemByID;
    function GetCheckedCount: integer;
    procedure Delete(AIndex: integer; const AAnimate: Boolean = True); reintroduce;
    procedure DeleteItem(AItem: TksTableViewItem; const AAnimate: Boolean = True);
    property FirstItem: TksTableViewItem read GetFirstItem;
    property LastItem: TksTableViewItem read GetLastItem;
    property CachedCount: integer read FCachedCount;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewBackgroundText

  TksTableViewBackgroundText = class(TPersistent)
  private
    FFont: TFont;
    FTextColor: TAlphaColor;
    FText: string;
    FEnabled: Boolean;
    procedure SetFont(const Value: TFont);
    procedure SetText(const Value: string);
    procedure SetTextColor(const Value: TAlphaColor);
    procedure SetEnabled(const Value: Boolean);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
  published
    property Font: TFont read FFont write SetFont;
    property TextColor: TAlphaColor read FTextColor write SetTextColor default claSilver;
    property Text: string read FText write SetText;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewAppearence

  TksTableViewAppearence = class(TPersistent)
  private
    [weak]FListView: TksTableView;
    FBackground: TBrush;
    FItemBackground: TBrush;
    FAlternatingItemBackground: TAlphaColor;
    FSeparatorColor: TAlphaColor;
    FHeaderColor: TAlphaColor;
    FSelectedColor: TAlphaColor;
    procedure SetBackground(const Value: TBrush);
    procedure SetItemBackground(const Value: TBrush);
    procedure SetAlternatingItemBackground(const Value: TAlphaColor);
    procedure SetSeparatorBackground(const Value: TAlphaColor);
    procedure SetHeaderColor(const Value: TAlphaColor);
    procedure SetSelectedColor(const Value: TAlphaColor);
  public
    constructor Create(AListView: TksTableView);
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
  published
    property Background: TBrush read FBackground write SetBackground;
    property HeaderColor: TAlphaColor read FHeaderColor write SetHeaderColor default claNull;
    property SeparatorColor: TAlphaColor read FSeparatorColor write SetSeparatorBackground default $FFF0F0F0;
    property ItemBackground: TBrush read FItemBackground write SetItemBackground;
    property SelectedColor: TAlphaColor read FSelectedColor write SetSelectedColor default C_TABLEVIEW_DEFAULT_SELECTED_COLOR;
    property AlternatingItemBackground: TAlphaColor read FAlternatingItemBackground write SetAlternatingItemBackground default claNull;
  end;

  //---------------------------------------------------------------------------------------

  // TksDeleteButton

  TksDeleteButton = class(TPersistent)
  private
    FEnabled: Boolean;
    FText: string;
    FColor: TAlphaColor;
    FTextColor: TAlphaColor;
    FWidth: integer;
    FShowImage: Boolean;
    FShowText: Boolean;
  public
    constructor Create; virtual;
  published
    property Color: TAlphaColor read FColor write FColor default claRed;
    property TextColor: TAlphaColor read FTextColor write FTextColor default claWhite;
    property Enabled: Boolean read FEnabled write FEnabled default False;
    property Text: string read FText write FText;
    property ShowImage: Boolean read FShowImage write FShowImage default True;
    property ShowText: Boolean read FShowText write FShowText default True;
    property Width: integer read FWidth write FWidth default 60;
  end;

  //---------------------------------------------------------------------------------------

  // TksListViewRowIndicators

  TksListViewRowIndicators = class(TPersistent)
  strict private
    [weak]FTableView: TksTableView;
    FWidth: integer;
    FHeight: integer;
    FVisible: Boolean;
    FOutlined: Boolean;
    FShadow: Boolean;
    FShape: TksTableViewShape;
    FSelectRow: Boolean;
    FAlignment: TksTableViewRowIndicatorAlign;
  private
    procedure Changed;
    procedure SetShadow(const Value: Boolean);
    procedure SetShape(const Value: TksTableViewShape);
    procedure SetAlignment(const Value: TksTableViewRowIndicatorAlign);
    procedure SetSelectRow(const Value: Boolean);
  published
    constructor Create(ATableView: TksTableView); virtual;
    property Width: integer read FWidth write FWidth default C_TABLEVIEW_DEFAULT_INDICATOR_WIDTH;
    property Height: integer read FHeight write FHeight default C_TABLEVIEW_DEFAULT_INDICATOR_HEIGHT;
    property Visible: Boolean read FVisible write FVisible default False;
    property Outlined: Boolean read FOutlined write FOutlined default True;
    property Shadow: Boolean read FShadow write SetShadow default True;
    property Shape: TksTableViewShape read FShape write SetShape default ksRectangle;
    property SelectRow: Boolean read FSelectRow write SetSelectRow default False;
    property Alignment: TksTableViewRowIndicatorAlign read FAlignment write SetAlignment default ksRowIndicatorLeft;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewTextDefault

  TksTableViewTextDefault = class(TPersistent)
  private
    FFont: TFont;
    FTextColor: TAlphaColor;
    procedure SetFont(const Value: TFont);
    procedure SetTextColor(const Value: TAlphaColor);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
  published
    property Font: TFont read FFont write SetFont;
    property TextColor: TAlphaColor read FTextColor write SetTextColor;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewTextDefaults

  TksTableViewTextDefaults = class(TPersistent)
  private
    FTitle: TksTableViewTextDefault;
    FSubtitle: TksTableViewTextDefault;
    FDetail: TksTableViewTextDefault;
    FHeader: TksTableViewTextDefault;
    procedure SetDetail(const Value: TksTableViewTextDefault);
    procedure SetSubTitle(const Value: TksTableViewTextDefault);
    procedure SetTitle(const Value: TksTableViewTextDefault);
    procedure SetHeader(const Value: TksTableViewTextDefault);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Title: TksTableViewTextDefault read FTitle write SetTitle;
    property SubTitle: TksTableViewTextDefault read FSubtitle write SetSubTitle;
    property Detail: TksTableViewTextDefault read FDetail write SetDetail;
    property Header: TksTableViewTextDefault read FHeader write SetHeader;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewPullToRefresh

  TksTableViewPullToRefresh = class(TPersistent)
  private
    [weak]FTableView: TksTableView;
    FEnabled: Boolean;
    FPullText: string;
    FReleaseText: string;
    FFont: TFont;
    FTextColor: TAlphaColor;
    procedure SetEnabled(const Value: Boolean);
    procedure SetFont(const Value: TFont);
  public
    constructor Create(ATableView: TksTableView); virtual;
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Font: TFont read FFont write SetFont;
    property PullText: string read FPullText write FPullText;
    property ReleaseText: string read FReleaseText write FReleaseText;
    property TextColor: TAlphaColor read FTextColor write FTextColor default claSilver;
  end;

  //---------------------------------------------------------------------------------------

  // TksDragImage

  TksDragImage = class(TRectangle)
  private
    FBorder: TRectangle;
    FShadow: TShadowEffect;
    FMouseDownOffset: TPointF;
    procedure SetAllowDropColor(const Value: TStrokeBrush);
    function GetAllowDropColor: TStrokeBrush;
    property MouseDownOffset: TPointF read FMouseDownOffset write FMouseDownOffset;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Shadow: TShadowEffect read FShadow;
    property AllowDropStroke: TStrokeBrush read GetAllowDropColor write SetAllowDropColor;
  end;

  //---------------------------------------------------------------------------------------

  // TksDragHighlightOptions

  TksDragHighlightOptions = class(TPersistent)
  private
    FAllowDropStroke: TStrokeBrush;
    FDisallowDropStroke: TStrokeBrush;
    FEnabled: Boolean;
    procedure SetAllowDropStroke(const Value: TStrokeBrush);
    procedure SetDisallowDropStroke(const Value: TStrokeBrush);
  public
    constructor Create; virtual;
    destructor Destroy; override;
  published
    property AllowDropStroke: TStrokeBrush read FAllowDropStroke write SetAllowDropStroke;
    property DisallowDropStroke: TStrokeBrush read FDisallowDropStroke write SetDisallowDropStroke;
    property Enabled: Boolean read FEnabled write FEnabled default True;
  end;

  //---------------------------------------------------------------------------------------

  // TksDragDropOptions

  TksDragDropOptions = class(TPersistent)
  private
    FEnabled: Boolean;
    FShadow: Boolean;
    FOpacity: single;
    FDragSpaceColor: TAlphaColor;
    FDragHighlightOptions: TksDragHighlightOptions;
    FLiveMoving : Boolean;
    procedure SetOpacity(const Value: single);
    procedure SetShadow(const Value: Boolean);
    procedure SetDragHighlightOptions(const Value: TksDragHighlightOptions);
    procedure SetLiveMoving(const Value: Boolean);
  public
    constructor Create; virtual;
    destructor Destroy; override;
  published
    property DragHighlight: TksDragHighlightOptions read FDragHighlightOptions write SetDragHighlightOptions;
    property DragSpaceColor: TAlphaColor read FDragSpaceColor write FDragSpaceColor default $FFECECEC;
    property Enabled: Boolean read FEnabled write FEnabled default False;
    property Shadow: Boolean read FShadow write SetShadow default True;
    property Opacity: single read FOpacity write SetOpacity;
    property LiveMoving: Boolean read FLiveMoving write SetLiveMoving default True;
  end;


  //---------------------------------------------------------------------------------------

  // TksTableViewSelectionOverlayOptions

  TksTableViewSelectionOverlayOptions = class(TPersistent)
  private
    [weak]FParent: TksTableViewSelectionOptions;
    FPosition: TksTableViewOverlaySelectorPosition;
    FStyle: TksTableViewOverlaySelectorStyle;
    FEnabled: Boolean;
    FStroke: TStrokeBrush;
    FBackgroundColor: TAlphaColor;
    FBitmap: TBitmap;
    FSize: integer;
    FLastStickyHeaderOffset: Single;
    FLastFixedFooterOffset: Single;
    procedure SetPosition(const Value: TksTableViewOverlaySelectorPosition);
    procedure SetEnabled(const Value: Boolean);
    procedure SetStrokeBrush(const Value: TStrokeBrush);
    procedure RecreateIndicator(AWidth,AHeight, AStickyHeaderOffset,AFixedFooterOffset: single);
    procedure SetStyle(const Value: TksTableViewOverlaySelectorStyle);
    procedure SetSize(const Value: integer);
    procedure DoStrokeChanged(Sender: TObject);
  public
    constructor Create(AParent: TksTableViewSelectionOptions);
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
    procedure DrawToCanvas(ACanvas: TCanvas; ARect: TRectF ; AStickyHeaderBottom,FixedFooterStart : Single);
  published
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property BackgroundColor: TAlphaColor read FBackgroundColor write FBackgroundColor default claWhite;
    property Position: TksTableViewOverlaySelectorPosition read FPosition write SetPosition default ksSelectorRight;
    property Stroke: TStrokeBrush read FStroke write SetStrokeBrush;
    property Style: TksTableViewOverlaySelectorStyle read FStyle write SetStyle default ksArrow;
    property Size: integer read FSize write SetSize default 1;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewSelectionOptions

  TksTableViewSelectionOptions = class(TPersistent)
  private
    [weak]FTableView: TksTableView;
    FSelectionOverlay: TksTableViewSelectionOverlayOptions;
    FShowSelection: Boolean;
    FKeepSelection: Boolean;
    FSelectDuration: integer;
    FKeepSelectedInView: Boolean;
    FLongTapSelects: Boolean;
    procedure SetKeepSelection(const Value: Boolean);
    procedure SetShowSelection(const Value: Boolean);
    procedure SetSelectionOverlay(const Value: TksTableViewSelectionOverlayOptions);
    procedure SetKeepSelectedInView(const Value: Boolean);
    procedure SetLongTapSelects(const Value: Boolean);
  public
    constructor Create(ATableView: TKsTableView);
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
  published
    property ShowSelection: Boolean read FShowSelection write SetShowSelection default True;
    property KeepSelection: Boolean read FKeepSelection write SetKeepSelection default False;
    property SelectionOverlay: TksTableViewSelectionOverlayOptions read FSelectionOverlay write SetSelectionOverlay;
    property SelectDuration: integer read FSelectDuration write FSelectDuration default C_TABLEVIEW_DEFAULT_SELECT_DURATION;
    property KeepSelectedInView: Boolean read FKeepSelectedInView write SetKeepSelectedInView default True;
    property LongTapSelects: Boolean read FLongTapSelects write SetLongTapSelects default True;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewJumpToHeaderOptions

  TksTableViewJumpToHeaderOptions = class(TPersistent)
  private
    FHeaderFill: TBrush;
    FHeaderFont: TFont;
    FHeaderTextColor: TAlphaColor;
    FHeaderHeight: Single;
    FHeaderText: String;
    FItemFill: TBrush;
    FItemFont: TFont;
    FItemTextColor: TAlphaColor;
    FItemHeight: Single;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
  published
    property HeaderFill: TBrush read FHeaderFill write FHeaderFill;
    property HeaderFont: TFont read FHeaderFont write FHeaderFont;
    property HeaderTextColor: TAlphaColor read FHeaderTextColor write FHeaderTextColor default claBlack;
    property HeaderHeight : Single read FHeaderHeight write FHeaderHeight;
    property HeaderText: String read FHeaderText write FHeaderText;
    property ItemFill: TBrush read FItemFill write FItemFill;
    property ItemFont: TFont read FItemFont write FItemFont;
    property ItemTextColor: TAlphaColor read FItemTextColor write FItemTextColor default claBlack;
    property ItemHeight : Single read FItemHeight write FItemHeight;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewStickyHeaderButton

  TksTableViewStickyHeaderButton = class(TPersistent)
  private
    [weak]FTableView: TksTableView;
    FVisible: Boolean;
    FHeaderTableViewBackground : TRectangle;
    FHeaderTableView: TksTableView;
    FHeaderTableViewShadowEffect: TShadowEffect;
    FButtonType : TksTableViewHeaderButtonType;
    FJumpToHeaderOptions: TksTableViewJumpToHeaderOptions;
    FSelected: Boolean;
    FRemovePopupTimer : TFmxHandle;
    procedure Changed;
    procedure SetVisible(const Value: Boolean);
    procedure SetButtonType(const Value: TksTableViewHeaderButtonType);
    procedure SetJumpToHeaderOptions(const Value: TksTableViewJumpToHeaderOptions);
  public
    constructor Create(ATableView: TksTableView);
    destructor Destroy; override;

    procedure Assign(ASource: TPersistent); override;
    procedure DoButtonClicked(Sender: TObject ; AItem: TksTableViewItem);
    procedure CancelPopup(Sender: TObject);
    procedure RemovePopup;
    procedure JumpToHeaderClick(Sender: TObject; x, y: Single; AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
  published
    property Visible: Boolean read FVisible write SetVisible default False;
    property ButtonType: TksTableViewHeaderButtonType read FButtonType write SetButtonType default TksTableViewHeaderButtonType.hbtJumpToHeader;
    property JumpToHeaderOptions: TksTableViewJumpToHeaderOptions read FJumpToHeaderOptions write SetJumpToHeaderOptions;
    property Selected: Boolean read FSelected write FSelected default False;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewStickyHeaderOptions

  TksTableViewStickyHeaderOptions = class(TPersistent)
  private
    [weak]FTableView: TksTableView;
    FEnabled: Boolean;
    FStickyHeight: single;
    FButton: TksTableViewStickyHeaderButton;
    FExtendScrollHeight: Boolean;
    procedure Changed;
    procedure SetEnabled(const Value: Boolean);
    procedure SetStickyHeight(const Value: single);
    procedure SetButton(const Value: TksTableViewStickyHeaderButton);
    procedure SetExtendScrollHeight(const Value: Boolean);
  public
    constructor Create(ATableView: TksTableView);
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
  published
    property Button: TksTableViewStickyHeaderButton read FButton write SetButton;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property StickyHeight: single read FStickyHeight write SetStickyHeight;
    property ExtendScrollHeight: Boolean read FExtendScrollHeight write SetExtendScrollHeight default false;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewItemHeaderOptions

  TksTableViewItemHeaderOptions = class(TPersistent)
  private
    [weak]FTableView: TksTableView;
    FHeight: integer;
    FStickyHeaders: TksTableViewStickyHeaderOptions;
    procedure Changed;
    function GetHeaderColor: TAlphaColor;
    procedure SetHeaderColor(const Value: TAlphaColor);
    procedure SetHeaderHeight(const Value: integer);
    procedure SetStickyHeaders(const Value: TksTableViewStickyHeaderOptions);
    procedure LegacyGetStickyHeadersHeight(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(ATableView: TksTableView);
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
  published
    property Color: TAlphaColor read GetHeaderColor write SetHeaderColor;
    property Height: integer read FHeight write SetHeaderHeight default C_TABLEVIEW_DEFAULT_HEADER_HEIGHT;
    property StickyHeaders: TksTableViewStickyHeaderOptions read FStickyHeaders write SetStickyHeaders;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewAccessoryOptions

  TksTableViewAccessoryOptions = class(TPersistent)
  private
    [weak]FTableView: TksTableView;
    FShowAccessory: Boolean;
    FColor: TAlphaColor;
    procedure Changed;
    procedure SetShowAccessory(const Value: Boolean);
    procedure SetColor(const Value: TAlphaColor);
  public
    constructor Create(ATableView: TksTableView);
    procedure Assign(ASource: TPersistent); override;
  published
    property ShowAccessory: Boolean read FShowAccessory write SetShowAccessory default True;
    property Color: TAlphaColor read FColor write SetColor default claNull;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewBorderOptions

  TksTableViewBorderOptions = class(TPersistent)
  private
    [weak]FTableView: TksTableView;
    FVisible: Boolean;
    FSides: TSides;
    FStroke: TStrokeBrush;
    function Showing: Boolean;
    procedure Changed;
    procedure SetVisible(const Value: Boolean);
    function IsSidesStored: Boolean;
    procedure SetSides(const Value: TSides);
    procedure SetStroke(const Value: TStrokeBrush);
  public
    constructor Create(ATableView: TksTableView);
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
  published
    property Sides: TSides read FSides write SetSides stored IsSidesStored;
    property Stroke: TStrokeBrush read FStroke write SetStroke;
    property Visible: Boolean read FVisible write SetVisible default False;

  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewFixedRowsOptions

  TksTableViewFixedRowsOptions = class(TPersistent)
  private
    [weak]FTableView: TksTableView;
    FHeaderCount: Integer;
    FFooterCount: Integer;
    FMinimumWorkHeight: Integer;
    procedure Changed;
    procedure SetHeaderCount(const Value: Integer);
    procedure SetFooterCount(const Value: Integer);
    procedure SetMinimumWorkHeight(const Value: Integer);
  public
    constructor Create(ATableView: TksTableView);
    procedure Assign(ASource: TPersistent); override;
  published
    property HeaderCount: Integer read FHeaderCount write SetHeaderCount default 0;
    property FooterCount: Integer read FFooterCount write SetFooterCount default 0;
    property MinimumWorkHeight: Integer read FMinimumWorkHeight write SetMinimumWorkHeight default 0;
  end;

  //---------------------------------------------------------------------------------------

  // TksTableViewCheckMarkOptions

  TksTableViewCheckMarkOptions = class(TPersistent)
  private
    [weak]FTableView: TksTableView;
    FCheckMarks: TksTableViewCheckMarks;
    FPosition: TksTableViewCheckMarkPosition;
    FShowInHeader: Boolean;
    FCheckArea: TksTableViewCheckMarkCheckArea;
    FCheckSelects: Boolean;
    FHeaderCheckSelectsAll: Boolean;
    FCheckMarkChecked: TksTableViewItemAccessory;
    FCheckMarkUnchecked: TksTableViewItemAccessory;
    procedure Changed;
    procedure SetCheckMarks(const Value: TksTableViewCheckMarks);
    procedure SetPosition(const Value: TksTableViewCheckMarkPosition);
    procedure SetShowInHeader(const Value: Boolean);
    procedure SetCheckArea(const Value: TksTableViewCheckMarkCheckArea);
    procedure SetCheckSelects(const Value: Boolean);
    procedure SetHeaderCheckSelectsAll(const Value: Boolean);
  public
    constructor Create(ATableView: TksTableView);
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
  published
    property CheckMarks: TksTableViewCheckMarks read FCheckMarks write SetCheckMarks default TksTableViewCheckMarks.cmNone;
    property Position: TksTableViewCheckMarkPosition read FPosition write SetPosition default TksTableViewCheckMarkPosition.cmpRight;
    property ShowInHeader: Boolean read FShowInHeader write SetShowInHeader default true;
    property CheckArea: TksTableViewCheckMarkCheckArea read FCheckArea write SetCheckArea default TksTableViewCheckMarkCheckArea.caWholeRow;
    property CheckSelects: Boolean read FCheckSelects write SetCheckSelects default true;
    property HeaderCheckSelectsAll: Boolean read FHeaderCheckSelectsAll write SetHeaderCheckSelectsAll default true;
  end;

  //---------------------------------------------------------------------------------------

  //---------------------------------------------------------------------------------------
  // TksTableView

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or
    {$IFDEF XE8_OR_NEWER} pidiOSDevice32 or pidiOSDevice64
    {$ELSE} pidiOSDevice {$ENDIF} or pidiOSSimulator or pidAndroid)]
  TksTableView = class(TksControl)
  strict private
    FFullWidthSeparator: Boolean;
    FClearCacheTimer: TFmxHandle;
    //procedure DoClearCacheTimer;
  private
    FCombo: TComboBox;
    FDateSelector: TDateEdit;
    FSearchBox: TSearchBox;
    FItems: TksTableViewItems;
    FFilteredItems: TksTableViewItems;
    FTimerService: IFMXTimerService;
    FAniCalc: TksAniCalc;
    FScrollPos: single;
    FPainting: Boolean;
    FScrolling: Boolean;
    FAppearence: TksTableViewAppearence;
    FItemHeight: integer;
    FItemImageSize: integer;
    FSearchVisible: Boolean;
    FItemIndex: integer;
    FMouseDownPoint: TPointF;
    FMouseCurrentPos: TPointF;
    FUpdateCount: integer;
    FSelectTimer: TFmxHandle;
    FDeselectTimer: TFmxHandle;
    FSwipeDirection: TksSwipeDirection;
    FMouseDownItem: TksTableViewItem;
    FMouseDown: Boolean;
    FBackgroundText: TksTableViewBackgroundText;
    FRowIndicators: TksListViewRowIndicators;
    FDeleteButton: TksDeleteButton;
    FTextDefaults: TksTableViewTextDefaults;
    FMouseDownObject: TksTableViewItemObject;
    [weak]FFocusedControl: TksTableViewItemEmbeddedControl;
    FColCount: integer;
    FMaxScrollPos: single;
    FDragDropImage : TksDragImage;
    FDragDropScrollTimer: TFmxHandle;
    FDragging: Boolean;
    FDragOverItem: TksTableViewItem;
    FSelectionOptions: TksTableViewSelectionOptions;
    FAccessoryOptions: TksTableViewAccessoryOptions;
    FHeaderOptions: TksTableViewItemHeaderOptions;
    FBorder: TksTableViewBorderOptions;
    FStickyHeader: TksTableViewItem;
    FStickyButtonRect: TRectF;
    FFixedRowOptions: TksTableViewFixedRowsOptions;
    FCascadeHeaderCheck: Boolean;
    FActionButtons: TksTableViewActionButtons;
    //FCachedCount: integer;

    // events...
    FItemClickEvent: TksTableViewItemClickEvent;
    FOnPullRefresh: TNotifyEvent;
    FPullToRefresh: TksTableViewPullToRefresh;
    FNeedsRefresh: Boolean;
    FCheckMarkOptions: TksTableViewCheckMarkOptions;
    FOnItemSwipe: TksItemSwipeEvent;
    FOnItemActionButtonClick: TksItemActionButtonClickEvent;
    FOnDeleteItem: TksTableViewDeleteItemEvent;
    FOnDeletingItem: TksTableViewDeletingItemEvent;
    FBeforeRowCache: TksTableViewRowCacheEvent;
    FAfterRowCache: TksTableViewRowCacheEvent;
    FOnEmbeddedEditChange: TksTableViewEmbeddedEditChange;
    FOnEmbeddedDateEditChange: TksTableViewEmbeddedDateEditChange;
    FOnItemChecMarkChanged: TksItemChecMarkChangedEvent;
    FOnSelectDate: TksTableViewSelectDateEvent;
    FOnSelectPickerItem: TksTableViewSelectPickerItem;
    FOnSelectPickerItemExt: TksTableViewSelectPickerItemExt;
    FOnSwitchClicked: TksTableViewItemSwitchEvent;
    FOnButtonClicked: TksTableViewItemButtonEvent;
    FOnScrollViewChange: TksTableViewScrollChangeEvent;
    FOnCanDragItem : TksTableViewCanDragItemEvent;
    FOnCanDropItem : TksTableViewCanDropItemEvent;
    FOnDropItem : TksTableViewDropItemEvent;
    FDragDropOptions: TksDragDropOptions;
    FOnSearchFilterChanged: TksTableViewSearchFilterChange;
    FOnStickyHeaderChange: TksTableViewStickyHeaderChange;
    FOnIndicatorExpand: TksTableViewRowIndicatorExpandEvent;
    FOnBeforePaint : TPaintEvent;
    FOnAfterPaint : TPaintEvent;
    FOnBeginRowCacheEvent: TksTableBeginRowCacheEvent;
    FItemObjectMouseUpEvent: TksTableViewItemClickEvent;
    FMouseEventsEnabledCounter: integer;
    FLastCacheClear: TDateTime;
    function GetViewPort: TRectF;
    procedure UpdateStickyHeaders;
    procedure SetScrollViewPos(const Value: single; const AAnimate: Boolean = False);
    procedure AniCalcStart(Sender: TObject);
    procedure AniCalcChange(Sender: TObject);
    procedure AniCalcStop(Sender: TObject);
    //procedure CacheItems(AForceRedraw: Boolean);
    function GetTopItem: TksTableViewItem;
    function GetVisibleItems: TList<TksTableViewItem>;
    procedure SetItemImageSize(const Value: integer);
    procedure SetColCount(const Value: integer);
    procedure SetKsItemHeight(const Value: integer);
    procedure SetSearchVisible(const Value: Boolean);
    procedure SetItemIndex(const Value: integer);
    procedure DoFilterChanged(Sender: TObject);
    procedure DoFilterEnter(Sender: TObject);
    //function GetScrollViewPos: single;
    function GetSearchHeight: single;
    function GetFixedHeaderHeight: single;
    function GetFixedFooterHeight: single;
    function GetStartOffsetY: single;
    function GetSelectedItem: TksTableViewItem;
    //function GetItemIndex: integer;
    procedure DeselectItem(const ADelay: integer = 0);
    procedure DoDeselectItem;
    procedure DoPullToRefresh;
    procedure UpdateFilteredItems;
    procedure DoSelectTimer;
    procedure UpdateDropImage(x, y: single);
    procedure DoDropScroll;
    procedure DoSelectItem;
    procedure SetCheckMarkOptions(const Value: TksTableViewCheckMarkOptions);
    procedure SetTextDefaults(const Value: TksTableViewTextDefaults);
    function CreateTimer(AInterval: integer; AProc: TTimerProc): TFmxHandle;
    procedure KillTimer(var ATimer: TFmxHandle);
    procedure KillAllTimers;
    procedure SetFullWidthSeparator(const Value: Boolean);
    procedure ComboClosePopup(Sender: TObject);
    procedure DoSwitchClicked(AItem: TksTableViewItem; ASwitch: TksTableViewItemSwitch);
    procedure DoButtonClicked(AItem: TksTableViewItem; AButton: TksTableViewItemButton);
    procedure SetPullToRefresh(const Value: TksTableViewPullToRefresh);
    procedure DoEmbeddedEditChange(AItem: TksTableViewItem; AEmbeddedEdit: TksTableViewItemEmbeddedBaseEdit);
    procedure SetSelectionOptions(const Value: TksTableViewSelectionOptions);
    procedure DoEmbeddedDateEditChange(AItem: TksTableViewItem; AEmbeddedDateEdit: TksTableViewItemEmbeddedDateEdit);
    procedure SetAccessoryOptions(const Value: TksTableViewAccessoryOptions);
    procedure SetAppearence(const Value: TksTableViewAppearence);
    procedure SetBackgroundText(const Value: TksTableViewBackgroundText);
    procedure LegacyGetShowAccessory(Reader: TReader);
    procedure LegacyGetStickyHeaders(Reader: TReader);
    procedure SetHeaderOptions(const Value: TksTableViewItemHeaderOptions);
    procedure LegacyGetHeaderHeight(Reader: TReader);
    procedure LegacyGetCheckMarks(Reader: TReader);
    procedure SetBorder(const Value: TksTableViewBorderOptions);
    procedure SetFixedRowOptions(const Value: TksTableViewFixedRowsOptions);
    procedure DoItemsChanged(Sender: TObject; const Item: TksTableViewItem; Action: TCollectionNotification);
    function GetSearchText: string;
    procedure SetSearchText(const Value: string);
    procedure CreateAniCalculator(AUpdateScrollLimit: Boolean);
    function GetCachedCount: integer;
  protected
    function GetTotalItemHeight: single;
    function IsHeader(AItem: TksTableViewItem): Boolean;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Paint; override;
    procedure KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; x, y: single); override;
    procedure MouseMove(Shift: TShiftState; x, y: single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; x, y: single); override;
    procedure DoMouseLeave; override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
    procedure Resize; override;
    {$IFDEF XE10_OR_NEWER}
    procedure VisibleChanged; override;
    {$ENDIF}
    function GetMouseDownBox: TRectF;
    procedure SelectDate(ARow: TksTableViewItem; ASelected: TDateTime; AOnSelectDate: TNotifyEvent);
    procedure SelectItem(ARow: TksTableViewItem; AItems: TStrings; ASelected: string; AOnSelectItem: TNotifyEvent);
    procedure DoSelectDate(Sender: TObject);
    procedure DoSelectPickerItem(Sender: TObject);
    procedure DoItemObjectMouseUp(AObject: TksTableViewItemObject; x, y: single);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetItemFromPos(AXPos,AYPos: single): TksTableViewItem;
    procedure EnableMouseEvents;
    procedure DisableMouseEvents;
    procedure ClearItems;
    procedure HideFocusedControl;
    procedure BeginUpdate; {$IFDEF XE8_OR_NEWER} override; {$ENDIF}
    procedure EndUpdate;   {$IFDEF XE8_OR_NEWER} override; {$ENDIF}
    procedure Invalidate;
    procedure UpdateAll(AUpdateFiltered: Boolean);
    procedure UpdateItemRects(AUpdateFiltered: Boolean);
    procedure UncheckAll;
    procedure UpdateScrollingLimits;
    procedure ResetIndicatorWidths;
    procedure RedrawAllVisibleItems;
    procedure ClearCache(AClearType: TksClearCacheType);
    procedure ScrollTo(const Value: single);
    procedure ScrollToItem(AItem: TksTableViewItem; const AAnimate: Boolean = False); overload;
    procedure ScrollToItem(AItemIndex: integer); overload;
    procedure BringSelectedIntoView;
    procedure CheckChildren(AHeader: TksTableViewItem ; Value : Boolean);
    procedure UncheckHeader(AChild: TksTableViewItem);
    procedure SearchSetFocus;
    property UpdateCount: integer read FUpdateCount;
    property TopItem: TksTableViewItem read GetTopItem;
    property VisibleItems: TList<TksTableViewItem> read GetVisibleItems;
    property ViewPort: TRectF read GetViewPort;
    property ScrollViewPos: single read FScrollPos;
    property Items: TksTableViewItems read FItems;
    property FilteredItems: TksTableViewItems read FFilteredItems;
    property ItemIndex: integer read FItemIndex write SetItemIndex;
    property SelectedItem: TksTableViewItem read GetSelectedItem;
    property SearchText: string read GetSearchText write SetSearchText;
    property TotalItemHeight: single read GetTotalItemHeight;
    property CachedCount: integer read GetCachedCount;
  published
    property AccessoryOptions: TksTableViewAccessoryOptions read FAccessoryOptions write SetAccessoryOptions;
    property Align;
    property Anchors;
    property Appearence: TksTableViewAppearence read FAppearence write SetAppearence;
    property BackgroundText: TksTableViewBackgroundText read FBackgroundText write SetBackgroundText;
    property BorderOptions: TksTableViewBorderOptions read FBorder write SetBorder;
    property CanFocus default True;
    property CanParentFocus;
    property CheckMarkOptions: TksTableViewCheckMarkOptions read FCheckMarkOptions write SetCheckMarkOptions;
    property ClipChildren default True;
    property ClipParent default False;
    property Cursor default crDefault;
    property DeleteButton: TksDeleteButton read FDeleteButton write FDeleteButton;
    property DragDropOptions: TksDragDropOptions read FDragDropOptions write FDragDropOptions;
    property FullWidthSeparator: Boolean read FFullWidthSeparator write SetFullWidthSeparator default True;
    property ColCount: integer read FColCount write SetColCount default 0;
    property FixedRowOptions: TksTableViewFixedRowsOptions read FFixedRowOptions write SetFixedRowOptions;
    property HeaderOptions: TksTableViewItemHeaderOptions read FHeaderOptions write SetHeaderOptions;
    property ItemHeight: integer read FItemHeight write SetKsItemHeight default C_TABLEVIEW_DEFAULT_ITEM_HEIGHT;
    property ItemImageSize: integer read FItemImageSize write SetItemImageSize default C_TABLEVIEW_DEFAULT_IMAGE_SIZE;
    property Locked default False;
    property Height;
    property HitTest default True;
    property Margins;
    property Opacity;
    property Padding;
    property PopupMenu;
    property Position;
    property PullToRefresh: TksTableViewPullToRefresh read FPullToRefresh write SetPullToRefresh;
    property RotationAngle;
    property RotationCenter;
    property RowIndicators: TksListViewRowIndicators read FRowIndicators write FRowIndicators;
    property Scale;
    property SearchVisible: Boolean read FSearchVisible write SetSearchVisible default False;
    property SelectionOptions: TksTableViewSelectionOptions read FSelectionOptions write SetSelectionOptions;
    property Size;

    property TabOrder;
    property TabStop;
    property TextDefaults: TksTableViewTextDefaults read FTextDefaults write SetTextDefaults;
    property Visible default True;
    property Width;

    // events...
    property AfterRowCache: TksTableViewRowCacheEvent read FAfterRowCache write FAfterRowCache;
    property BeforeRowCache: TksTableViewRowCacheEvent read FBeforeRowCache write FBeforeRowCache;
    property OnButtonClick: TksTableViewItemButtonEvent read FOnButtonClicked write FOnButtonClicked;
    property OnDblClick;
    property OnDeletingItem: TKsTableViewDeletingItemEvent read FOnDeletingItem write FOnDeletingItem;
    property OnDeleteItem: TKsTableViewDeleteItemEvent read FOnDeleteItem write FOnDeleteItem;
    property OnEmbeddedEditChange: TksTableViewEmbeddedEditChange read FOnEmbeddedEditChange write FOnEmbeddedEditChange;
    property OnEmbeddedDateEditChange: TksTableViewEmbeddedDateEditChange read FOnEmbeddedDateEditChange write FOnEmbeddedDateEditChange;
    property OnIndicatorExpand: TksTableViewRowIndicatorExpandEvent read FOnIndicatorExpand write FOnIndicatorExpand;
    property OnItemActionButtonClick: TksItemActionButtonClickEvent read FOnItemActionButtonClick write FOnItemActionButtonClick;
    property OnItemCheckmarkChanged: TksItemChecMarkChangedEvent read FOnItemChecMarkChanged write FOnItemChecMarkChanged;
    property OnItemClick: TksTableViewItemClickEvent read FItemClickEvent write FItemClickEvent;
    property OnItemObjectMouseUp: TksTableViewItemClickEvent read FItemObjectMouseUpEvent write FItemObjectMouseUpEvent;
    property OnPainting;
    property OnPaint;
    property OnResize;
    property OnPullRefresh: TNotifyEvent read FOnPullRefresh write FOnPullRefresh;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Keyboard events }
    property OnKeyDown;
    property OnKeyUp;
    { Mouse events }
    property OnCanFocus;

    property OnEnter;
    property OnExit;
    property OnItemSwipe: TksItemSwipeEvent read FOnItemSwipe write FOnItemSwipe;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnBeginRowCache: TksTableBeginRowCacheEvent read FOnBeginRowCacheEvent write FOnBeginRowCacheEvent;
    property OnScrollViewChange: TksTableViewScrollChangeEvent read FOnScrollViewChange write FOnScrollViewChange;
    property OnSelectDate: TksTableViewSelectDateEvent read FOnSelectDate write FOnSelectDate;
    property OnSelectPickerItem: TksTableViewSelectPickerItem read FOnSelectPickerItem write FOnSelectPickerItem;
    property OnSelectPickerItemExt: TksTableViewSelectPickerItemExt read FOnSelectPickerItemExt write FOnSelectPickerItemExt;
    property OnSearchFilterChanged: TksTableViewSearchFilterChange read FOnSearchFilterChanged write FOnSearchFilterChanged;
    property OnSwitchClick: TksTableViewItemSwitchEvent read FOnSwitchClicked write FOnSwitchClicked;
    property OnCanDragItem: TksTableViewCanDragItemEvent read FOnCanDragItem write FOnCanDragItem;
    property OnCanDropItem: TksTableViewCanDropItemEvent read FOnCanDropItem write FOnCanDropItem;
    property OnDropItem: TksTableViewDropItemEvent read FOnDropItem write FOnDropItem;
    property OnBeforePaint: TPaintEvent read FOnBeforePaint write FOnBeforePaint;
    property OnAfterPaint: TPaintEvent read FOnAfterPaint write FOnAfterPaint;
    property OnStickyHeaderChange: TksTableViewStickyHeaderChange read FOnStickyHeaderChange write FOnStickyHeaderChange;
  end;

{$R *.dcr}

procedure Register;

var
  AccessoryImages: TksTableViewAccessoryImageList;

implementation

uses SysUtils, FMX.Platform, Math, FMX.TextLayout, System.Math.Vectors, ksCommon,
  FMX.Ani, FMX.Forms, DateUtils;

var
  AIsSwiping: Boolean;

procedure Register;
begin
  RegisterComponents('Kernow Software FMX', [TksTableView]);
end;


// TksTableViewItemObject

procedure TksTableViewItemObject.Changed;
begin
  if FTableItem = nil then
    Exit;
  FTableItem.Cached := False;
  FTableItem.CacheItem(True);
  FTableItem.FTableView.Invalidate;
end;

constructor TksTableViewItemObject.Create(ATableItem: TksTableViewItem);
begin
  inherited Create;
  FMargins := TBounds.Create(TRectF.Empty);
  FTableItem := ATableItem;
  FHitTest := True;
  FOffsetX := 0;
  FOffsetY := 0;
  FShowSelection := False;
  FMouseDown := False;
  FPositionRelativeTo := nil;
  FSelected := False;
  FVisible := True;
end;

destructor TksTableViewItemObject.Destroy;
begin
  FreeAndNil(FMargins);
  inherited;
end;

procedure TksTableViewItemObject.Deselect;
begin
  if FMouseDown then
  begin
    FMouseDown := False;
    Changed;
  end;
end;

procedure TksTableViewItemObject.MouseDown(x, y: single);
begin
  if (FHitTest) then
  begin

    FMouseDown := True;
    if FShowSelection then
      FSelected := True;
    Changed;
  end;
end;

procedure TksTableViewItemObject.MouseUp(x, y: single);
begin
  FTableItem.TableView.DoItemObjectMouseUp(Self, x, y);
  //if (Assigned(FOnClick)) then
  //  FOnClick(Self);
end;

procedure TksTableViewItemObject.Render(AItemRect: TRectF; ACanvas: TCanvas);
var
  AObjRect: TRectF;
  AState: TCanvasSaveState;
begin
  if FVisible = False then
    Exit;

  FItemRect := AItemRect;

  if (FSelected) and (FShowSelection) then
  begin
    AObjRect := GetObjectRect;
    AObjRect.Inflate(8, 8);
    AState := ACanvas.SaveState;
    try
      ACanvas.IntersectClipRect(AObjRect);
      ACanvas.Fill.Color := FTableItem.FTableView.Appearence.SelectedColor;
      ACanvas.Stroke.Color := claDimgray;
      ACanvas.FillRect(AObjRect, 0, 0, AllCorners, 1);
    finally
      ACanvas.RestoreState(AState);
    end;
  end;
end;

function TksTableViewItemObject.ConsumesClick: Boolean;
begin
  Result := False;
end;

function TksTableViewItemObject.GetItemRect: TRectF;
begin
  if (FPositionRelativeTo <> nil) then
    Result := FPositionRelativeTo.GetObjectRect
  else
    Result := FTableItem.ItemRect;
end;

function TksTableViewItemObject.GetObjectRect: TRectF;
var
  ARowRect: TRectF;
  RelativeOffset : TPointF;
begin
  if (FTableItem.Appearance <> iaNormal) then
  begin
    Result := RectF(FPlaceOffset.X, FPlaceOffset.Y,
                    FPlaceOffset.X +FWidth, FPlaceOffset.Y + FHeight);
    Exit;
  end;
  ARowRect := GetItemRect;
  if (Self <> FTableItem.Accessory) and (Self <> FTableItem.FCheckMarkAccessory) then
  begin
    if (FTableItem.Accessory.Accessory <> atNone) then
      ARowRect.Right := ARowRect.Right - (FTableItem.Accessory.Width+8);
  end;
  RelativeOffset := PointF(0, 0);

  if (FPositionRelativeTo <> nil) then
  begin
    RelativeOffset.X := FPositionRelativeTo.GetObjectRect.Left;
    RelativeOffset.Y := FPositionRelativeTo.GetObjectRect.Top;
  end;

  if (WidthPercentange > 0) then
    FWidth := ARowRect.Width * WidthPercentange / 100;

  if (HeightPercentange > 0) then
    FHeight := ARowRect.Height * HeightPercentange / 100;

  Result := RectF(ARowRect.Left + FMargins.Left, FMargins.Top, FWidth, FHeight);

  Result := RectF(RelativeOffset.X + FMargins.Left, RelativeOffset.Y + FMargins.Top,
                  RelativeOffset.X + FMargins.Left + FWidth, RelativeOffset.Y + FMargins.Top + FHeight);

  case FAlign of
    TksTableItemAlign.Center: OffsetRect(Result, ((ARowRect.Width - Result.Width) / 2), 0);
    TksTableItemAlign.Trailing: OffsetRect(Result, ((ARowRect.Width - Result.Width) - C_SCROLL_BAR_WIDTH) - FMargins.Right, 0);
    TksTableItemAlign.Fit: Result.Width := ARowRect.Width - FMargins.Left - FMargins.Right;
  end;

  case FVertAlign of
    TksTableItemAlign.Center: OffsetRect(Result, 0, (ARowRect.Height - Result.Height) / 2);
    TksTableItemAlign.Trailing: OffsetRect(Result, 0, (ARowRect.Height - Result.Height) - FMargins.Bottom);
    TksTableItemAlign.Fit: Result.Height := ARowRect.Height - FMargins.Top - FMargins.Bottom;
  end;

  OffsetRect(Result,
             FItemRect.Left + FPlaceOffset.x + FOffsetX,
             FItemRect.Top + FPlaceOffset.y + FOffsetY);
end;


procedure TksTableViewItemObject.SetAlign(Value: TksTableItemAlign);
begin
  FAlign := Value;
end;

procedure TksTableViewItemObject.SetHeight(const Value: single);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    Changed;
  end;
end;

procedure TksTableViewItemObject.SetHeightPercentange(const Value: single);
begin
  if FHeightPercentange <> Value then
  begin
    FHeightPercentange := Value;
    Changed;
  end;
end;

procedure TksTableViewItemObject.SetWidthPercentange(const Value: single);
begin
  if FWidthPercentange <> Value then
  begin
    FWidthPercentange := Value;
    Changed;
  end;
end;

procedure TksTableViewItemObject.SetPositionRelativeTo(const Value: TksTableViewItemObject);
begin
  if FPositionRelativeTo <> Value then
  begin
    FPositionRelativeTo := Value;
    Changed;
  end;
end;

procedure TksTableViewItemObject.SetHitTest(const Value: Boolean);
begin
  FHitTest := Value;
end;

procedure TksTableViewItemObject.SetID(Value: string);
begin
  FID := Value;
end;

procedure TksTableViewItemObject.SetOffsetX(const Value: single);
begin
  if FOffsetX <> Value then
  begin
    FOffsetX := Value;
    Changed;
  end;
end;

procedure TksTableViewItemObject.SetOffsetY(const Value: single);
begin
  if FOffsetY <> Value then
  begin
    FOffsetY := Value;
    Changed;
  end;
end;

procedure TksTableViewItemObject.SetSelected(const Value: Boolean);
begin
  if FSelected <> Value then
  begin
    FSelected := Value;
    Changed
  end;
end;

procedure TksTableViewItemObject.SetShowSelection(const Value: Boolean);
begin
  FShowSelection := Value;
end;

procedure TksTableViewItemObject.SetVertAlign(Value: TksTableItemAlign);
begin
  FVertAlign := Value;
end;

procedure TksTableViewItemObject.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

procedure TksTableViewItemObject.SetWidth(const Value: single);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    Changed;
  end;
end;

// ------------------------------------------------------------------------------

{ TksTableViewItemText }

function TksTableViewItemText.CalculateSize: TSizeF;
begin
  Result.cx := CalculateTextWidth(FText, FFont, FWordWrap, FWidth);
  Result.cy := CalculateTextHeight(FText, FFont, FWordWrap, FTrimming, FWidth);
end;

constructor TksTableViewItemText.Create(ATableItem: TksTableViewItem);
begin
  inherited;
  FFont := TFont.Create;
  FFont.Size := C_TABLEVIEW_DEFAULT_FONT_SIZE;
  FFont.OnChanged := FontChanged;
  FText := '';
  FTextColor := claBlack;
  FVertAlign := TksTableItemAlign.Center;
  FTextAlign := TTextAlign.Leading;
  FTextVertAlign := TTextAlign.Leading;
  FWordWrap := False;
  FTrimming := TTextTrimming.Character;
  FBackground := claNull;
  FIsHtmlText := False;
end;

destructor TksTableViewItemText.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

procedure TksTableViewItemText.Assign(ASource: TksTableViewItemText);
begin
  FBackground := ASource.FBackground;
  FText       := ASource.FText;
  FFont.Assign(ASource.FFont);
  FTextColor     := ASource.FTextColor;
  FTextAlign     := ASource.FTextAlign;
  FTextVertAlign := ASource.FTextVertAlign;
  FWordWrap      := ASource.FWordWrap;
  FTrimming      := ASource.FTrimming;
  FIsHtmlText    := ASource.FIsHtmlText;
end;

procedure TksTableViewItemText.FontChanged(Sender: TObject);
begin
  Height := CalculateTextHeight(FText, FFont, FWordWrap, FTrimming, FWidth)
end;

procedure TksTableViewItemText.Render(AItemRect: TRectF; ACanvas: TCanvas);
var
  r: TRectF;
  ATextColor: TAlphaColor;
begin
  inherited Render(AItemRect, ACanvas);
  r := GetObjectRect;
  if FBackground <> claNull then
  begin
    ACanvas.Fill.Color := FBackground;
    ACanvas.FillRect(r, 0, 0, AllCorners, 1);
  end;
  ATextColor := FTextColor;
  if FTableItem.FForegroundColor <> claNull then
    ATextColor := FTableItem.FForegroundColor;
  if FText <> '' then
  begin
    case FIsHtmlText of
      False: RenderText(ACanvas, r.Left, r.Top, r.Width, r.Height, FText, FFont,
                        ATextColor, FWordWrap, FTextAlign, FTextVertAlign, FTrimming);
      True: RenderHhmlText(ACanvas, r.Left, r.Top, r.Width, r.Height, FText, FFont,
                        ATextColor, FWordWrap, FTextAlign, FTextVertAlign, FTrimming);

    end;
  end;
end;

procedure TksTableViewItemText.SetBackground(const Value: TAlphaColor);
begin
  if FBackground <> Value then
  begin
    FBackground := Value;
    Changed;
  end;
end;

procedure TksTableViewItemText.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TksTableViewItemText.SetIsHtmlText(const Value: Boolean);
begin
  FIsHtmlText := Value;
  Changed;
end;

procedure TksTableViewItemText.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;
end;

procedure TksTableViewItemText.SetTextAlign(const Value: TTextAlign);
begin
  if FTextAlign <> Value then
  begin
    FTextAlign := Value;
    Changed;
  end;
end;

procedure TksTableViewItemText.SetTextColor(const Value: TAlphaColor);
begin
  if FTextColor <> Value then
  begin
    FTextColor := Value;
    Changed;
  end;
end;

procedure TksTableViewItemText.SetTextVertAlign(const Value: TTextAlign);
begin
  if FTextVertAlign <> Value then
  begin
    FTextVertAlign := Value;
    Changed;
  end;
end;

procedure TksTableViewItemText.SetTrimming(const Value: TTextTrimming);
begin
  if FTrimming <> Value then
  begin
    FTrimming := Value;
    Changed;
  end;
end;

procedure TksTableViewItemText.SetWordWrap(const Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    Changed;
  end;
end;

// ------------------------------------------------------------------------------

{ TksTableViewItemObjects }

constructor TksTableViewItemObjects.Create(ATableView: TksTableView);
begin
  inherited Create(True);
  FTableView := ATableView;
end;

// ------------------------------------------------------------------------------

function TksTableViewItemObjects.GetImageByID(AId: string): TksTableViewItemImage;
var
  AObj: TksTableViewItemObject;
begin
  Result := nil;
  AObj := ObjectByID[AId];
  if AObj is TksTableViewItemImage then
    Result := (AObj as TksTableViewItemImage);
end;

function TksTableViewItemObjects.GetObjectByID(AId: string): TksTableViewItemObject;
var
  ICount: integer;
begin
  Result := nil;
  for ICount := 0 to Count-1 do
  begin
    if Items[ICount].ID = AId then
    begin
      Result := Items[ICount];
      Exit;
    end;
  end;
end;

function TksTableViewItemObjects.GetTextByID(AId: string): TksTableViewItemText;
var
  AObj: TksTableViewItemObject;
begin
  Result := nil;
  AObj := ObjectByID[AId];
  if AObj is TksTableViewItemText then
    Result := (AObj as TksTableViewItemText);
end;

//---------------------------------------------------------------------------------------

// TksTableViewItemBaseImage

procedure TksTableViewItemBaseImage.Clear;
begin
  FreeAndNil(FBitmap);
end;

constructor TksTableViewItemBaseImage.Create(ATableItem: TksTableViewItem);
begin
  inherited;
  FShadow := TksTableViewShadow.Create;
  FBadgeValue := 0;
  FBadgeColor := claRed;
  FBadgeTextColor := claWhite;
  FShadow.Visible := False;
  FOwnsBitmap := True;
  FHighQuality := False;
  FDrawMode := TksImageDrawMode.ksDrawModeStretch;

end;

destructor TksTableViewItemBaseImage.Destroy;
begin
  FreeAndNil(FShadow);

  if (FBitmap <> nil) and (FOwnsBitmap) then
    FreeAndNil(FBitmap);
  inherited;
end;

procedure TksTableViewItemBaseImage.Assign(ASource: TksTableViewItemBaseImage);
begin
  Bitmap := ASource.Bitmap;
  FDrawMode := ASource.FDrawMode;
  FShadow.Assign(ASource.FShadow);
  FHighQuality := ASource.FHighQuality;
end;

procedure TksTableViewItemBaseImage.DoBeforeRenderBitmap(ABmp: TBitmap);
begin
  // overridden to make changes before painting.
end;

function TksTableViewItemBaseImage.GetBitmap: TBitmap;
begin
  if FOwnsBitmap then
  begin
    if (FBitmap=Nil) then
    begin
      FBitmap := TBitmap.Create;
    end;
    Result := FBitmap
  end
  else
    Result := FExternalBitmap;
end;


procedure TksTableViewItemBaseImage.Render(AItemRect: TRectF; ACanvas: TCanvas);
var
  AShadowRect: TRectF;
  AShadowBmp: TBitmap;
  ARect: TRectF;
  AScaleX, AScaleY: single;
  AOriginalRect: TRectF;
  ABmp: TBitmap;
begin
  inherited;
  if Bitmap <> nil then
  begin
    ARect := GetObjectRect;
    AOriginalRect := ARect;

    if FDrawMode = ksDrawModeFit then
    begin
      ARect := RectF(ARect.Left, ARect.Top, ARect.Left+Bitmap.Width, ARect.Top+Bitmap.Height);
      AScaleX := GetObjectRect.Width / ARect.Width;
      AScaleY := GetObjectRect.Height / ARect.Height;
      ARect.Height := ARect.Height * Min(AScaleX, AScaleY);
      ARect.Width := ARect.Width * Min(AScaleX, AScaleY);
      OffsetRect(ARect, (AOriginalRect.Width - ARect.Width)/2, (AOriginalRect.Height - ARect.Height)/2) ;
    end;

    if FShadow.Visible then
    begin
      AShadowBmp := TBitmap.Create;
      try
        AShadowRect := ARect;
        OffsetRect(AShadowRect, FShadow.Offset, FShadow.Offset);
        AShadowBmp.Assign(Bitmap);
        AShadowBmp.ReplaceOpaqueColor(FShadow.Color);


        ACanvas.DrawBitmap(AShadowBmp, RectF(0, 0, AShadowBmp.Width, AShadowBmp.Height), AShadowRect, 1, True);
      finally
        AShadowBmp.Free;
      end;
    end;
    ABmp := TBitmap.Create;
    try
      ABmp.Assign(Bitmap);
      DoBeforeRenderBitmap(ABmp);
      ACanvas.DrawBitmap(ABmp,
                         RectF(0, 0, ABmp.Width, ABmp.Height),
                         ARect,
                         1,
                         not FHighQuality);
    finally
      ABmp.Free;
    end;
  end;
  if FBadgeValue > 0 then
  begin
    GenerateBadge(ACanvas,
                  PointF(ARect.Right-12, ARect.Top-4),
                  FBadgeValue,
                  FBadgeColor,
                  claWhite,
                  FBadgeTextColor);
  end;
end;


procedure TksTableViewItemBaseImage.SetBadgeColor(const Value: TAlphaColor);
begin
  if FBadgeColor <> Value then
  begin
    FBadgeColor := Value;
    Changed;
  end;
end;

procedure TksTableViewItemBaseImage.SetBadgeTextColor(const Value: TAlphaColor);
begin
  if FBadgeTextColor <> Value then
  begin
    FBadgeTextColor := Value;
    Changed;
  end;
end;

procedure TksTableViewItemBaseImage.SetBadgeValue(const Value: integer);
begin
  if FBadgeValue <> Value then
  begin
    FBadgeValue := Value;
    Changed;
  end;
end;

procedure TksTableViewItemBaseImage.SetBitmap(const Value: TBitmap);
begin
  if FOwnsBitmap then
  begin
    if FBitmap = nil then
      FBitmap := TBitmap.Create;
    FBitmap.Assign(Value);
  end
  else
  begin
    FreeAndNil(FBitmap);
    FExternalBitmap := Value;
  end;
  Changed;
end;

procedure TksTableViewItemBaseImage.SetDrawMode(const Value: TksImageDrawMode);
begin
  if FDrawMode <> Value then
  begin
    FDrawMode := Value;
    Changed;
  end;
end;

procedure TksTableViewItemBaseImage.SetHighQuality(const Value: Boolean);
begin
  if FHighQuality <> Value then
  begin
    FHighQuality := Value;
    Changed;
  end;
end;

procedure TksTableViewItemBaseImage.SetOwnsBitmap(const Value: Boolean);
begin
  if FOwnsBitmap <> Value then
  begin
    FOwnsBitmap := Value;
    if (FOwnsBitmap) and (FExternalBitmap <> nil) then
      Bitmap.Assign(FExternalBitmap)
    else
      FreeAndNil(FBitmap);
  end;
end;

procedure TksTableViewItemBaseImage.SetShadow(const Value: TksTableViewShadow);
begin
  FShadow.Assign(Value);
end;

procedure TksDragDropOptions.SetLiveMoving(const Value: Boolean);
begin
  FLiveMoving := Value;
end;

// ------------------------------------------------------------------------------

{ TksTableViewItemAccessory }

constructor TksTableViewItemAccessory.Create(ATableItem: TksTableViewItem);
begin
  inherited;
  FAccessory := atNone;
  FAlign := TksTableItemAlign.Trailing;
  FVertAlign := TksTableItemAlign.Center;
  FColor := claNull;
end;

procedure TksTableViewItemAccessory.DoBeforeRenderBitmap(ABmp: TBitmap);
begin
  inherited;
  if FTableItem.FForegroundColor <> claNull then
    ReplaceOpaqueColor(ABmp, FTableItem.FForegroundColor);
end;

procedure TksTableViewItemAccessory.RedrawAccessory;
begin
  Bitmap := AccessoryImages.Images[FAccessory];
  if FColor = claNull then
    OwnsBitmap := False;
  FWidth := Bitmap.Width / AccessoryImages.ImageScale;
  FHeight := Bitmap.Height / AccessoryImages.ImageScale;
  Changed;
end;

procedure TksTableViewItemAccessory.Render(AItemRect: TRectF; ACanvas: TCanvas);
begin
  if (Bitmap = nil) and (FAccessory <> atNone) then
    RedrawAccessory;

  if FColor <> C_TABLEVIEW_ACCESSORY_KEEPCOLOR then
  begin
    if FColor <> claNull then
      ReplaceOpaqueColor(Bitmap, FColor)
    else
    begin
      if FTableItem.TableView.AccessoryOptions.Color <> claNull then
        ReplaceOpaqueColor(Bitmap, FTableItem.TableView.AccessoryOptions.Color)
    end;
  end;

  inherited;
end;

procedure TksTableViewItemAccessory.SetAccessory(const Value: TksAccessoryType);
begin
  if FAccessory <> Value then
  begin
    FAccessory := Value;
    Clear;
    RedrawAccessory;
  end;
end;

procedure TksTableViewItemAccessory.SetColor(const Value: TAlphaColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    RedrawAccessory;
  end;
end;

// ------------------------------------------------------------------------------

{ TksTableViewItems }

function TksTableViewItems.AddItem(AText: string;
  const AAccessory: TksAccessoryType = atNone): TksTableViewItem;
begin
  Result := AddItem(AText, '', AAccessory);
end;

function TksTableViewItems.AddItem(AText, ADetail: string;
  const AAccessory: TksAccessoryType): TksTableViewItem;
begin
  Result := AddItem(AText, '', ADetail, AAccessory);
end;

function TksTableViewItems.AddChatBubble(AText: string;
  APosition: TksTableViewChatBubblePosition;
  AColor, ATextColor: TAlphaColor;
  const AUserImage: TBitmap): TksTableViewChatBubble;
var
  //ABubble: TksTableViewChatBubble;
  AItem: TksTableViewItem;
  r: TRectF;
begin
  Result := nil;
  if Trim(AText) = '' then
    Exit;
  AItem := AddItem('');
  Result := AItem.DrawChatBubble(AText, APosition, AColor, ATextColor);
  Result.Position := APosition;
  if AUserImage <> nil then
  begin
    r := RectF(0, 0, 32, 32);

    case APosition of
      ksCbpLeft: Result.OffsetX := 44;
      ksCbpRight: Result.OffsetX := -44;
    end;

    with AItem.DrawBitmap(AUserImage, r) do
    begin
      if APosition = ksCbpLeft then
      begin
        Align := TksTableItemAlign.Leading;
        OffsetX := 4;
      end
      else
      begin
        Align := TksTableItemAlign.Trailing;
        OffsetX := -4;
      end;

      VertAlign := TksTableItemAlign.Trailing;
      OffsetY := -4;
    end;

  end;
  AItem.Height := Result.Height + 16;
end;

function TksTableViewItems.AddDateSelector(AText: string; ADate: TDateTime): TksTableViewItem;
begin
  Result := Additem(AText, '', FormatDateTime('ddd, dd mmmm, yyyy', ADate), atMore);
  Result.Selector := DateSelector;
  Result.FSelectionValue := ADate;
end;

function TksTableViewItems.AddHeader(AText: string): TksTableViewItem;
begin
  Result := TksTableViewItem.Create(FTableView);
  Result.Title.Text := AText;
  Result.Title.Font.Assign(FTableView.TextDefaults.Header.Font);
  Result.Title.TextColor := FTableView.TextDefaults.Header.TextColor;
  //Result.FSearchIndex := '';
  Result.Height := FTableView.HeaderOptions.Height;
  Result.Purpose := TksTableViewItemPurpose.Header;
  Add(Result);
  //UpdateIndexes;
  FTableView.UpdateAll(True);
end;

function TksTableViewItems.AddItem(AText, ASubTitle, ADetail: string;
  const AAccessory: TksAccessoryType): TksTableViewItem;
begin
  Result := TksTableViewItem.Create(FTableView);
  Result.Title.Text := AText;
  Result.SubTitle.Text := ASubTitle;
  Result.Detail.Text := ADetail;
  Result.Accessory.Accessory := AAccessory;
  Result.Accessory.OwnsBitmap := True;
  Result.Height := FTableView.ItemHeight;
  Add(Result);
  UpdateIndexes;
  Result.UpdateSearchIndex;
  FTableView.UpdateAll(True);
end;

function TksTableViewItems.AddItemSelector(AText, ASelected: string; AItems: TStrings): TksTableViewItem;
begin
  Result := AddItem(AText, '', ASelected, atMore);
  Result.Selector := ItemPicker;
  Result.PickerItems.Assign(AItems);
  Result.FSelectionValue := ASelected;
end;

function TksTableViewItems.AddItemWithSwitch(AText: string; AChecked: Boolean; AID: string): TksTableViewItem;
var
  ASwitch: TksTableViewItemSwitch;
begin
  Result := AddItem(AText);
  Result.CanSelect := False;
  ASwitch := Result.AddSwitch(0, AChecked, TksTableItemAlign.Trailing);
  ASwitch.ID := AID;
  Result.CanSelect := False;
end;

function TksTableViewItems.AddItemSelector(AText, ASelected: string; AItems: array of string): TksTableViewItem;
var
  AStrings: TStrings;
  ICount: integer;
begin
  AStrings := TStringList.Create;
  try
    for ICount := Low(AItems) to High(AItems) do
      AStrings.Add(AItems[ICount]);
    Result := AddItemSelector(AText, ASelected, AStrings);
  finally
    FreeAndNil(AStrings);
  end;
end;

constructor TksTableViewItems.Create(ATableView: TksTableView;
  AOwnsObjects: Boolean);
begin
  inherited Create(AOwnsObjects);
  FTableView := ATableView;
  FCachedCount := 0;
end;

procedure TksTableViewItems.Delete(AIndex: integer; const AAnimate: Boolean = True);
begin
  DeleteItem(Items[AIndex], AAnimate);
end;

procedure TksTableViewItems.DeleteItem(AItem: TksTableViewItem; const AAnimate: Boolean = True);
var
  ICount: integer;
  ACanDelete: Boolean;
  AIndex: integer;
begin
  ACanDelete := True;
  if Assigned(FTableView.OnDeletingItem) then
  begin
    ACanDelete := False;
    FTableView.OnDeletingItem(FTableView, AItem, ACanDelete);
    if ACanDelete = False then
      Exit;
  end;

  AIndex := IndexOf(AItem);
  if AIndex = -1 then
    Exit;

  AItem.FDeleting := True;

  if FTableView.UpdateCount > 0 then
  begin
    inherited Delete(AIndex);
    FTableView.UpdateItemRects(False);
    if Assigned(FTableView.OnDeleteItem) then
      FTableView.OnDeleteItem(FTableView, AItem);
    Exit;
  end;

  FTableView.DisableMouseEvents;
  try
    if AAnimate then
    begin
      for ICount := Trunc(AItem.Height) downto 0 do
      begin
        AItem.Height := ICount;
        //FTableView.Repaint;
        {$IFDEF NEXTGEN}
        if ICount mod 5 = 0 then
          ProcessMessages;
        {$ELSE}
        ProcessMessages;
        {$ENDIF}
      end;
    end;

    inherited Delete(AIndex);
    FTableView.UpdateItemRects(False);
    //FTableView.UpdateAll(True);
    FTableView.Invalidate;

    if Assigned(FTableView.OnDeleteItem) then
      FTableView.OnDeleteItem(FTableView, AItem);

  finally
    FTableView.EnableMouseEvents;
  end;
end;

function TksTableViewItems.GetCheckedCount: integer;
var
  ICount: integer;
begin
  Result := 0;
  for ICount := 0 to Count-1 do
  begin
    if Items[ICount].Checked then
      Result := Result + 1;
  end;
end;

function TksTableViewItems.GetFirstItem: TksTableViewItem;
begin
  Result := nil;
  if Count > 0  then
    Result := Items[0];
end;

function TksTableViewItems.GetItemByID(AID: string): TksTableViewItem;
var
  ICount: integer;
begin
  Result := nil;
  for ICount := 0 to Count-1 do
  begin
    if Items[ICount].ID = AID then
    begin
      Result := Items[ICount];
      Exit;
    end;
  end;
end;

function TksTableViewItems.GetLastItem: TksTableViewItem;
begin
  Result := nil;
  if Count > 0 then
    Result := Items[Count - 1];
end;

function TksTableViewItems.GetTotalItemHeight: single;
var
  ICount: integer;
  AItem: TksTableViewItem;
  ALastHeaderItem: TksTableViewItem;
begin
  Result := 0;
  ALastHeaderItem := nil;
  for ICount := 0 to Count - 1 do
  begin
    AItem := Items[ICount];

    if (AItem.FIsFirstCol) then
    begin
      if (AItem.Purpose=TksTableViewItemPurpose.Header) then
        ALastHeaderItem := AItem;

      if (AItem.FHeaderHeight>0) then
        Result := Result + AItem.FHeaderHeight
      else
        Result := Result + AItem.Height;
    end;
  end;

  if (FTableView.FHeaderOptions.FStickyHeaders.Enabled) and
     (FTableView.FHeaderOptions.FStickyHeaders.FExtendScrollHeight) and
     (ALastHeaderItem<>Nil) then
    Result := ALastHeaderItem.ItemRect.Top + FTableView.Height - FTableView.GetStartOffsetY - FTableView.GetFixedFooterHeight;
end;

procedure TksTableViewItems.Move(CurIndex, NewIndex: Integer);
begin
  inherited;
  Items[CurIndex].CacheItem(True);
  Items[NewIndex].CacheItem(True);
  //FTableView.UpdateAll(True);
  FTableView.UpdateItemRects(True);
  FTableView.Invalidate;
end;

procedure TksTableViewItems.UpdateIndexes;
var
  ICount: integer;
begin
  for ICount := 0 to Count - 1 do
    Items[ICount].FAbsoluteIndex := ICount;
end;

// ------------------------------------------------------------------------------

{ TksTableItem }

function TksTableViewItem.AddButton(AWidth: integer; AText: string;
                                    const ATintColor: TAlphaColor = claNull;
                                    const AVertAlign: TksTableItemAlign = TksTableItemAlign.Center;
                                    const AYPos: integer = 0): TksTableViewItemButton;
begin
  Result := TksTableViewItemButton.Create(Self);
  Result.Width := AWidth;
  Result.FPlaceOffset := PointF(0, AYPos);
  Result.VertAlign := TksTableItemAlign.Center;
  Result.Align := TksTableItemAlign.Trailing;
  Result.TintColor := ATintColor;
  Result.Text := AText;
  FObjects.Add(Result);
  Changed;
end;

function TksTableViewItem.AddButton(AStyle: TksTableViewButtonStyle; const ATintColor: TAlphaColor): TksTableViewItemButton;
begin
  Result := AddButton(44, '', ATintColor);
  Result.Width := 44;
  Result.Height := 44;
  Changed;
end;

function TksTableViewItem.AddDateEdit(AX, AY, AWidth: single;
  ADate: TDateTime): TksTableViewItemEmbeddedDateEdit;
begin
  Result := TksTableViewItemEmbeddedDateEdit.Create(Self);
  Result.Width := AWidth;
  Result.FPlaceOffset := PointF(AX, AY);
  Result.VertAlign := TksTableItemAlign.Center;
  Result.Date := ADate;
  FObjects.Add(Result);
  Changed;
end;

function TksTableViewItem.AddEdit(AX, AY, AWidth: single; AText: string; const AStyle: TksEmbeddedEditStyle = TksEmbeddedEditStyle.ksEditNormal): TksTableViewItemEmbeddedEdit;
begin
  Result := TksTableViewItemEmbeddedEdit.Create(Self);
  Result.Width := AWidth;
  Result.FPlaceOffset := PointF(AX, AY);
  Result.VertAlign := TksTableItemAlign.Center;
  Result.Style := AStyle;
  Result.Text := AText;
  FObjects.Add(Result);
  Changed;
end;

function TksTableViewItem.AddSwitch(x: single; AIsChecked: Boolean;
  const AAlign: TksTableItemAlign = TksTableItemAlign.Trailing): TksTableViewItemSwitch;
begin
  Result := TksTableViewItemSwitch.Create(Self);
  Result.FPlaceOffset := PointF(x, 0);
  Result.Checked := AIsChecked;
  Result.Align := AAlign;
  Result.VertAlign := TksTableItemAlign.Center;
  FObjects.Add(Result);
  Changed;
end;

function TksTableViewItem.AddTable(AX, AY, AColWidth, ARowHeight: single; AColCount, ARowCount: integer): TksTableViewItemTable;
begin
  Result := TksTableViewItemTable.Create(Self);
  Result.DefaultRowHeight := ARowHeight;
  Result.DefaultColWidth := AColWidth;
  Result.ColCount := AColCount;
  Result.RowCount := ARowCount;
  Result.FPlaceOffset := PointF(AX, AY);
  Result.ResizeTable;
  FObjects.Add(Result);
  Changed;
end;

procedure TksTableViewItem.CacheItem(const AForceCache: Boolean = False);
var
  ARect: TRectF;
  ICount: integer;
  ColumnOffset : Single;
  w,h: integer;
  AScreenScale: Single;
begin
  if (FUpdating) or (FTableView.UpdateCount > 0) then
    Exit;
  if (FItemRect.Height = 0) or (FItemRect.Width = 0) then
    Exit;

  if AForceCache then
    ClearCache;

  if (FCached = True) or (FCaching) then
    Exit;

  FCaching := True;

  if Assigned(FTableView.OnBeginRowCache) then
    FTableView.OnBeginRowCache(FTableView, Self);

  ColumnOffset := ItemRect.Left;

  OffsetRect(FItemRect,-ColumnOffset,0);

  RealignStandardObjects;

  AScreenScale := GetScreenScale;

  w := Round(FItemRect.Width * AScreenScale);
  h := Round(FItemRect.Height * AScreenScale);

  Inc(FOwner.FCachedCount);
  _FBitmap.SetSize(w, h);


  ARect := RectF(0, 0, _FBitmap.Width, _FBitmap.Height);

  _FBitmap.Canvas.BeginScene;
  try
    if (Purpose=None) and
       ((FTableView.FSelectionOptions.ShowSelection) and (FCanSelect)) and
       ((FIndex = FTableView.ItemIndex) or ((Checked) and (FTableView.FCheckMarkOptions.FCheckSelects))) then
    begin
      _FBitmap.Canvas.Fill.Kind  := TBrushKind.Solid;

      if FTableView.FSelectionOptions.FSelectionOverlay.Enabled then
      begin
        if (FTableView.FSelectionOptions.FSelectionOverlay.FStyle=ksBlankSpace) then
          _FBitmap.Canvas.Fill.Color := GetColorOrDefault(FTableView.FSelectionOptions.FSelectionOverlay.BackgroundColor,C_TABLEVIEW_DEFAULT_SELECTED_COLOR)
      end
      else
        _FBitmap.Canvas.Fill.Color := GetColorOrDefault(FTableView.Appearence.SelectedColor,C_TABLEVIEW_DEFAULT_SELECTED_COLOR);
    end
    else if (FFill.Kind<>TBrushKind.None) then
      _FBitmap.Canvas.Fill.Assign(FFill)
    else if (FPurpose<>None) then
    begin
      _FBitmap.Canvas.Fill.Kind  := TBrushKind.Solid;
      _FBitmap.Canvas.Fill.Color := GetColorOrDefault(FTableView.Appearence.HeaderColor,
                                   C_TABLEVIEW_DEFAULT_HEADER_COLOR)
    end
    else if (FTableView.Appearence.AlternatingItemBackground <> claNull) and (FIndex mod 2 = 0) then
    begin
      _FBitmap.Canvas.Fill.Kind  := TBrushKind.Solid;
      _FBitmap.Canvas.Fill.Color := FTableView.Appearence.AlternatingItemBackground;
    end
    else
      _FBitmap.Canvas.Fill.Assign(FTableView.Appearence.ItemBackground);

    _FBitmap.Canvas.FillRect(ARect, 0, 0, AllCorners, 1);


    if Assigned(FTableView.BeforeRowCache) then
      FTableView.BeforeRowCache(FTableView, _FBitmap.Canvas, Self, ARect);

    // indicator...
    if FTableView.RowIndicators.Visible then
    begin
      case FTableView.RowIndicators.Outlined of
        False: FIndicator.Stroke.Kind := TBrushKind.None;
        True: FIndicator.Stroke.Kind := TBrushKind.Solid;
      end;
      if FIndicator.Width = 0 then
        FIndicator.Width := FTableView.RowIndicators.Width;
      if Trunc(FTableView.RowIndicators.Height) <> 0 then
        FIndicator.Height := FTableView.RowIndicators.Height
      else
        FIndicator.Height := Height;

      FIndicator.Shape := FTableView.RowIndicators.Shape;
      FIndicator.Render(RectF(0, 0, 0, 0), _FBitmap.Canvas);
    end;


    FTileBackground.Render(RectF(0, 0, 0, 0), _FBitmap.Canvas);
    FImage.Render(RectF(0, 0, 0, 0), _FBitmap.Canvas);
    FTitle.Render(RectF(0, 0, 0, 0), _FBitmap.Canvas);
    FSubTitle.Render(RectF(0, 0, 0, 0), _FBitmap.Canvas);
    FDetail.Render(RectF(0, 0, 0, 0), _FBitmap.Canvas);

    if FTableView.AccessoryOptions.ShowAccessory then
      FAccessory.Render(RectF(0, 0, 0, 0), _FBitmap.Canvas);

    if FTableView.FCheckMarkOptions.FCheckMarks <> TksTableViewCheckMarks.cmNone then
    begin
      if (FCheckmarkAllowed) then
      begin
        FCheckMarkAccessory.FTableItem := Self;
        FCheckMarkAccessory.Render(RectF(0, 0, 0, 0), _FBitmap.Canvas);
      end;
    end;

    for ICount := 0 to FObjects.Count - 1 do
    begin
      if FObjects[ICount].Visible then
      begin
        FObjects[ICount].Render(RectF(0, 0, 0, 0), _FBitmap.Canvas);
      end;
    end;


    if Assigned(FTableView.AfterRowCache) then
      FTableView.AfterRowCache(FTableView, _FBitmap.Canvas, Self, ARect);

  finally
    _FBitmap.Canvas.EndScene;
    FCached := True;
  end;
  OffsetRect(FItemRect,ColumnOffset,0);
  FCaching := False;
  //Inc(FOwner.FCachedCount);
end;

procedure TksTableViewItem.Changed;
begin
  FCached := False;
  if FUpdating then
    Exit;
  if (FTableView.FUpdateCount = 0) then
    FTableView.Invalidate;
  UpdateSearchIndex;
end;

procedure TksTableViewItem.PickerItemsChanged(Sender: TObject);
begin
  FSelector := TksTableItemSelector.NoSelector;
  if FPickerItems.Count > 0 then
    FSelector := TksTableItemSelector.ItemPicker;
end;

constructor TksTableViewItem.Create(ATableView: TksTableView);
begin
  inherited Create;
  FUpdating := True;
  try
    FTableView := ATableView;
    FOwner := ATableView.Items;
    _FBitmap := TBitmap.Create;
    _FBitmap.BitmapScale := GetScreenScale;
    FObjects := TksTableViewItemObjects.Create(FTableView);
    FFont := TFont.Create;
    FFont.Size := C_TABLEVIEW_DEFAULT_FONT_SIZE;
    FFill := TBrush.Create(TBrushKind.None, claNull);
    FIndicator := TksTableViewItemShape.Create(Self);
    FIndicator.VertAlign := TksTableItemAlign.Center;

    FTileBackground := TksTableViewItemTileBackground.Create(Self);

    FPickerItems := TStringList.Create;
    (FPickerItems as TStringList).OnChange := PickerItemsChanged;

    FImage := TksTableViewItemImage.Create(Self);
    FImage.VertAlign := TksTableItemAlign.Center;

    FAccessory := TksTableViewItemAccessory.Create(Self);
    FAccessory.OwnsBitmap := False;

    FCheckMarkAccessory := TableView.CheckMarkOptions.FCheckMarkUnchecked;

    FTitle := TksTableViewItemText.Create(Self);
    FTitle.Font.Assign(FTableView.TextDefaults.Title.Font);
    FTitle.TextColor := FTableView.TextDefaults.Title.TextColor;

    FSubTitle := TksTableViewItemText.Create(Self);
    FSubTitle.Font.Assign(FTableView.TextDefaults.SubTitle.Font);
    FSubTitle.TextColor := FTableView.TextDefaults.SubTitle.TextColor;

    FDetail := TksTableViewItemText.Create(Self);
    FDetail.TextAlignment := TTextAlign.Trailing;
    FDetail.Font.Assign(FTableView.TextDefaults.Detail.Font);
    FDetail.TextColor := FTableView.TextDefaults.Detail.TextColor;

    FPurpose := None;
    FTextColor := claBlack;
    FChecked := False;
    Height := C_TABLEVIEW_DEFAULT_ITEM_HEIGHT;
    FHeightPercentage := 0;
    FCaching := False;
    FUpdating := False;
    FCanSelect := True;
    FTagString := '';
    FTagInteger := 0;
    FColCount := 0;
    FSearchIndex := '';
    FAppearance := iaNormal;
    FDragging := False;
    FDeleting := False;
    FForegroundColor := claNull;
  finally
    FUpdating := False;
  end;
end;

procedure TksTableViewItem.DeselectObjects;
var
  ICount: integer;
begin
  for ICount := 0 to FObjects.Count-1 do
  begin
    FObjects[ICount].Deselect;
  end;
end;

destructor TksTableViewItem.Destroy;
begin
  FreeAndNil(FTitle);
  FreeAndNil(FSubTitle);
  FreeAndNil(FDetail);
  FreeAndNil(FIndicator);
  FreeAndNil(FTileBackground);
  FreeAndNil(FAccessory);
  FreeAndNil(FObjects);
  FreeAndNil(_FBitmap);
  FreeAndNil(FFont);
  FreeAndNil(FImage);
  FreeAndNil(FPickerItems);
  FreeAndNil(FFill);
  FreeAndNil(FData);
  inherited;
end;

function TksTableViewItem.CheckMarkClicked(x, y: single) : Boolean;
var
  ACheckMarkRect: TRectF;
begin
  if (FCheckmarkAllowed) then
  begin
    if (FTableView.FCheckMarkOptions.FCheckArea=TksTableViewCheckMarkCheckArea.caCheckMarkRect) then
    begin
      ACheckMarkRect.Left   := FCheckMarkAccessory.FPlaceOffset.X;
      ACheckMarkRect.Top    := FCheckMarkAccessory.FPlaceOffset.Y + (FCheckMarkAccessory.Height / 2);
      ACheckMarkRect.Width  := FCheckMarkAccessory.Width;
      ACheckMarkRect.Height := FCheckMarkAccessory.Height;

      InflateRect(ACheckMarkRect,8,8);

      Result := PtInRect(ACheckMarkRect, PointF(x,y));
    end
    else
      Result := true;
  end
  else
    Result := false;
end;

procedure TksTableViewItem.DoClick(x, y: single);
var
  ABtn: TksTableViewActionButton;
  AObj: TksTableViewItemObject;
  AActBtns: TksTableViewActionButtons;
begin
  DeselectObjects;
  try
    AActBtns := TableView.FActionButtons;

    if (AActBtns.Visible) and (AActBtns.TableItem = Self) then
    begin
      // check for actionbutton click...
      ABtn := TableView.FActionButtons.ButtonFromXY(x, y);

      if ABtn <> nil then
      begin
        if ABtn.IsDeleteButton then
        begin
          FTableView.Items.DeleteItem(Self);
           Exit;
        end;
        // custom button...
        FTableView.FActionButtons.HideButtons;
        if Assigned(FTableView.OnItemActionButtonClick) then
          FTableView.OnItemActionButtonClick(FTableView, Self, ABtn);
      end;
    end;

    AObj := ObjectAtPos(x, y + ItemRect.Top);
    if AObj <> nil then
    begin

      if AObj.HitTest then
        AObj.MouseDown(x-AObj.ObjectRect.Left, y-AObj.ObjectRect.Top);
      if AObj.ConsumesClick then
        Exit;
    end;

    if FSelector = DateSelector then
    begin
      FTableView.SelectDate(Self, FSelectionValue, FTableView.DoSelectDate);
      Exit;
    end;

    if FSelector = ItemPicker then
    begin
      FTableView.SelectItem(Self, FPickerItems, FSelectionValue, FTableView.DoSelectPickerItem);
      Exit;
    end;

    if (FTableView.FCheckMarkOptions.FCheckMarks <> cmNone) and (CheckMarkClicked(x,y)) then
      Checked := not Checked;
  finally
    TableView.FActionButtons.HideButtons;
  end;
end;

procedure TksTableViewItem.DoSwipe(ADirecton: TksSwipeDirection);
begin
  if AIsSwiping then
    Exit;

  if FTableView.FActionButtons.Visible  then
  begin
    FTableView.FActionButtons.HideButtons;
    Exit;
  end;

  AIsSwiping := True;
  try
    if TableView.FActionButtons.Visible then
    begin
      if (TableView.FActionButtons.Alignment = abLeftActionButtons) and (ADirecton = ksSwipeRightToLeft) then TableView.fActionButtons.HideButtons;
      if (TableView.FActionButtons.Alignment = abRightActionButtons) and (ADirecton = ksSwipeLeftToRight) then TableView.fActionButtons.HideButtons;
      Exit;
    end;

    FTableView.FActionButtons.HideButtons;

    TableView.FActionButtons.Clear;
    if Assigned(FTableView.FOnItemSwipe) then
      FTableView.FOnItemSwipe(FTableView, Self, ADirecton, TableView.fActionButtons);

    if (ADirecton = TksSwipeDirection.ksSwipeRightToLeft) then TableView.FActionButtons.AddDeleteButton;

    if TableView.FActionButtons.Count = 0 then
      Exit;

    if ADirecton = ksSwipeRightToLeft then TableView.FActionButtons.Alignment := TksTableViewActionButtonAlignment.abRightActionButtons;
    if ADirecton = ksSwipeLeftToRight then TableView.FActionButtons.Alignment := TksTableViewActionButtonAlignment.abLeftActionButtons;
      TableView.fActionButtons.ShowButtons(Self);
  finally
    AIsSwiping := False;
  end;
end;

function TksTableViewItem.DrawBitmap(ABmp: TBitmap; ARect: TRectF;
  const AVertAlign: TksTableItemAlign = Center): TksTableViewItemImage;
begin
  Result := DrawBitmap(ABmp, ARect.Left, ARect.Top, ARect.Width, ARect.Height, AVertAlign);
end;

function TksTableViewItem.DrawBitmap(ABmp: TBitmap; x, AWidth, AHeight: single;
  const AVertAlign: TksTableItemAlign = Center): TksTableViewItemImage;
begin
  Result := DrawBitmap(ABmp, x, 0, AWidth, AHeight, AVertAlign);
end;

function TksTableViewItem.DrawBitmap(ABmp: TBitmap;
                                     x, y,
                                     AWidth,
                                     AHeight:
                                     single;
                                     const AVertAlign: TksTableItemAlign = Center): TksTableViewItemImage;
begin
  Result := TksTableViewItemImage.Create(Self);
  Result.Width := AWidth;
  Result.Height := AHeight;
  Result.FPlaceOffset := PointF(x, y);
  Result.VertAlign := AVertAlign;
  Result.Bitmap := ABmp;
  FObjects.Add(Result);
  Changed;
end;

function TksTableViewItem.DrawChatBubble(AText: string;
  APosition: TksTableViewChatBubblePosition; AColor,
  ATextColor: TAlphaColor): TksTableViewChatBubble;
begin
  FUpdating := True;
  try
    Result := TksTableViewChatBubble.Create(Self);
    Result.FText := AText;
    case APosition  of
      ksCbpLeft: Result.Align := TksTableItemAlign.Leading;
      ksCbpRight: Result.Align := TksTableItemAlign.Trailing;
    end;
    Result.OffsetX := 16;
    if APosition = ksCbpRight then
      Result.OffsetX := -16;
    Result.RecalculateSize;
    Result.CornerRadius := 16;
    Result.Fill.Color := AColor;
    Result.FTextColor := ATextColor;
    CanSelect := False;
    Objects.Add(Result);
  finally
    FUpdating := False;
  end;
  Changed;
end;

function TksTableViewItem.DrawRect(x, y, AWidth, AHeight: single;
  AStroke, AFill: TAlphaColor;
  const AVertAlign: TksTableItemAlign = TksTableItemAlign.Center): TksTableViewItemShape;
begin
  Result := TksTableViewItemShape.Create(Self);
  Result.Width := AWidth;
  Result.Height := AHeight;
  Result.FPlaceOffset := PointF(x, y);
  Result.Stroke.Color := AStroke;
  Result.Fill.Color := AFill;
  Result.VertAlign := AVertAlign;
  FObjects.Add(Result);
  Changed;
end;

function TksTableViewItem.DrawRect(ARect: TRectF; AStroke, AFill: TAlphaColor;
  const AVertAlign: TksTableItemAlign = TksTableItemAlign.Center): TksTableViewItemShape;
begin
  Result := DrawRect(ARect.Left, ARect.Top, ARect.Width, ARect.Height, AStroke, AFill, AVertAlign);
end;


function TksTableViewItem.GetItemData(const AIndex: string): TValue;
begin
  if (FData <> nil) and not FData.TryGetValue(AIndex, Result) then
    Result := TValue.Empty;
end;



function TksTableViewItem.GetTextByID(AID: string): TksTableViewItemText;
begin
  Result := Objects.TextByID[AId];
end;

function TksTableViewItem.GetHasData(const AIndex: string): Boolean;
begin
  Result := (FData <> nil) and FData.ContainsKey(AIndex);
end;

function TksTableViewItem.GetImageByID(AID: string): TksTableViewItemImage;
begin
  Result := Objects.ImageByID[AId];
end;

function TksTableViewItem.GetIndicatorColor: TAlphaColor;
begin
  Result := FIndicator.Fill.Color;
end;

function TksTableViewItem.GetInternalRect: TRectF;
begin
  Result := FItemRect;

  Result.Left := Result.Left + 8;
  Result.Right := Result.Right - C_SCROLL_BAR_WIDTH;

end;


procedure TksTableViewItem.Invalidate;
begin
  TableView.Invalidate;
end;

function TksTableViewItem.IsHeader: Boolean;
begin
  Result := FPurpose = TksTableViewItemPurpose.Header;
end;

function TksTableViewItem.IsLastItem: Boolean;
begin
  Result := Self = FTableView.FilteredItems.LastItem;
end;

function TksTableViewItem.IsVisible(AViewport: TRectF): Boolean;
begin
  Result := (FItemRect.Bottom >= (AViewport.Top)) and
    (FItemRect.Top <= (AViewport.Bottom));
end;

function TksTableViewItem.MatchesSearch(AFilter: string): Boolean;
begin
  Result := True;
  if AFilter <> '' then
    Result := Pos(LowerCase(AFilter), LowerCase(FSearchIndex)) > 0;
end;

function TksTableViewItem.ObjectAtPos(x, y: single): TksTableViewItemObject;
var
  ICount: integer;
  AObj: TksTableViewItemObject;
begin
  Result := nil;
  for ICount := FObjects.Count-1 downto 0 do
  begin
    AObj := FObjects[ICount];
    if PtInRect(AObj.ObjectRect, PointF(x, (y-ItemRect.Top))) then
    begin
      Result := AObj;
      Exit;
    end;
  end;
end;

procedure TksTableViewItem.RealignStandardObjects;
var
  ARect: TRectF;
  TileImageOffsetT : Single;
  TileImageOffsetB : Single;
  Margins          : TRectF;
  ARightOffset     : Single;
begin
  FUpdating := True;
  try
    if (FAppearance=TksTableViewItemAppearance.iaNormal) then
    begin
      ARect := GetInternalRect;

      if (FTableView.SelectionOptions.FSelectionOverlay.FEnabled) then
      begin
        ARightOffset := Round(FTableView.SelectionOptions.FSelectionOverlay.Stroke.Thickness/2);
        ARect.Right  := ARect.Right - ARightOffset;
      end
      else
        ARightOffset := 0;

      if (FTableView.FCheckMarkOptions.FCheckMarks <> cmNone) and (FCheckmarkAllowed) then
      begin
        if FCheckMarkAccessory.Bitmap = nil then
          FCheckMarkAccessory.RedrawAccessory;

        if (FTableView.FCheckMarkOptions.FPosition = cmpLeft) then
        begin
          FCheckMarkAccessory.FPlaceOffset := PointF(ARect.Left, 0);
          ARect.Left  := ARect.Left  + (8 + FCheckMarkAccessory.Width);
          ARect.Right := ARect.Right - (8 + FCheckMarkAccessory.Width);
        end
        else
        begin
          ARightOffset := ARightOffset + (8 + FCheckMarkAccessory.Width);
          ARect.Right  := ARect.Right  - (8 + FCheckMarkAccessory.Width);

          FCheckMarkAccessory.FPlaceOffset := PointF(ARect.Right + 8, 0);
        end;
      end;

      if (FAccessory.Accessory<>atNone) then
      begin
        if (FAccessory.Align=TksTableItemAlign.Leading) then
        begin
          FAccessory.FPlaceOffset := PointF(0, 0);
          ARect.Left  := ARect.Left  + 24;
          ARect.Right := ARect.Right - 24;
        end
        else
        begin
          ARect.Right := ARect.Right - 24;

          FAccessory.FPlaceOffset := PointF(-((24-FAccessory.Width)/2)-ARightOffset, 0);
        end;
      end;

      if (FPurpose = None) and (FTableView.RowIndicators.Visible) then
      begin
        if (Trunc(FIndicator.Height) <> 0) and (Trunc(FIndicator.Height) <> Height) then

        FIndicator.FPlaceOffset := PointF(ARect.Left, 0);
        if FIndicator.Width = 0 then
          FIndicator.Width := FTableView.RowIndicators.Width;
        FIndicator.Height := FTableView.RowIndicators.Height;
        if FIndicator.Height = 0 then
          FIndicator.Height := ItemRect.Height - 16;
        ARect.Left := ARect.Left + FTableView.RowIndicators.Width+4;

        FIndicator.OffsetX := 0;
        case FTableView.RowIndicators.Alignment of
          ksRowIndicatorLeft: FIndicator.Align := TksTableItemAlign.Leading;
          ksRowIndicatorRight:
          begin
            //FIndicator.Align := TksTableItemAlign.Trailing;
            FIndicator.OffsetX := ItemRect.Right - FIndicator.Width;;
          end;
        end;


      end;
      FTileBackground.Width:=0;
      FTileBackground.Height:=0;
      if FImage.Bitmap <> nil then
      begin
        if FImage.Bitmap.Width > 0 then
        begin
          FImage.Width := FTableView.ItemImageSize;
          FImage.Height := FTableView.ItemImageSize;
          FImage.FPlaceOffset := PointF(ARect.Left, 0);
          ARect.Left := ARect.Left + FTableView.ItemImageSize + 4;
        end;
      end;

      FTitle.FPlaceOffset := PointF(ARect.Left, 0);
      FTitle.Width := ARect.Width;

      FTitle.Height := CalculateTextHeight(FTitle.Text, FTitle.Font,  FTitle.WordWrap, FTitle.FTrimming, FTitle.Width);

      FSubTitle.FPlaceOffset := PointF(ARect.Left, 0);
      FSubTitle.Width := ARect.Width;
      FSubTitle.Height := CalculateTextHeight(FSubTitle.Text, FSubTitle.Font, FSubTitle.WordWrap, FSubTitle.FTrimming, FSubTitle.Width);
      if FSubTitle.Text <> '' then
      begin
        FTitle.FPlaceOffset := PointF(FTitle.FPlaceOffset.x, -9);
        FSubTitle.FPlaceOffset := PointF(FSubTitle.FPlaceOffset.x, 9);
      end;
      FDetail.Width := ARect.Width;
      FDetail.FPlaceOffset := PointF(ARect.Right-(FDetail.Width), 0);
      FDetail.Height := CalculateTextHeight(FDetail.Text, FDetail.Font, FDetail.WordWrap, FDetail.FTrimming);
    end
    else if (FAppearance>=iaTile_Image) and (FAppearance<=iaTile_SubTitleImageTitle) then
    begin
      FIndicator.Width          := 0;
      FTitle.Width              := 0;
      FSubTitle.Width           := 0;
      FDetail.Width             := 0;
      FAccessory.Width          := 0;
      FCheckMarkAccessory.Width := 0;
      TileImageOffsetT          := 0;
      TileImageOffsetB          := 0;

      Margins.Left   := FTileBackground.Margins.Left;
      Margins.Top    := FTileBackground.Margins.Top;
      Margins.Right  := FTileBackground.Margins.Right;
      Margins.Bottom := FTileBackground.Margins.Bottom;

      if (not FIsFirstCol) then Margins.Left   := Round(Margins.Left   / 2);
      if (not FIsFirstRow) then Margins.Top    := Round(Margins.Top    / 2);
      if (not FIsLastCol ) then Margins.Right  := Round(Margins.Right  / 2);
      if (not FIsLastRow ) then Margins.Bottom := Round(Margins.Bottom / 2);

      ARect.Left   := FItemRect.Left   + Margins.Left;
      ARect.Top    := Margins.Top;
      ARect.Width  := FItemRect.Width  - Margins.Left - Margins.Right;
      ARect.Height := FItemRect.Height - Margins.Top  - Margins.Bottom;

      FTileBackground.FPlaceOffset := PointF(ARect.Left, ARect.Top);
      FTileBackground.Width        := ARect.Width;
      FTileBackground.Height       := ARect.Height;

      ARect.Left   := ARect.Left   + FTileBackground.Padding.Left;
      ARect.Top    := ARect.Top    + FTileBackground.Padding.Top;
      ARect.Right  := ARect.Right  - FTileBackground.Padding.Right;
      ARect.Bottom := ARect.Bottom - FTileBackground.Padding.Bottom;

      if (FAppearance=iaTile_TitleImage) or (FAppearance=iaTile_TitleImageSubTitle) then
      begin
        FTitle.Width        := CalculateTextWidth(FTitle.Text, FTitle.Font, False);
        FTitle.Height       := CalculateTextHeight(FTitle.Text, FTitle.Font,  FTitle.WordWrap, FTitle.FTrimming, FTitle.Width);
        FTitle.FPlaceOffset := PointF(ARect.Left + ((ARect.Width - FTitle.Width) / 2), ARect.Top);

        TileImageOffsetT := FTitle.Height;
      end
      else if (FAppearance=iaTile_SubTitleImageTitle) then
      begin
        FSubTitle.Width        := CalculateTextWidth(FSubTitle.Text, FSubTitle.Font, False);
        FSubTitle.Height       := CalculateTextHeight(FSubTitle.Text, FSubTitle.Font, FSubTitle.WordWrap, FSubTitle.FTrimming, FSubTitle.Width);
        FSubTitle.FPlaceOffset := PointF(ARect.Left + ((ARect.Width - FSubTitle.Width) / 2), ARect.Top);

        TileImageOffsetT := FSubTitle.Height;
      end;

      if (FAppearance=iaTile_ImageTitle) or (FAppearance=iaTile_SubTitleImageTitle) then
      begin
        FTitle.Width        := CalculateTextWidth(FTitle.Text, FTitle.Font, False);
        FTitle.Height       := CalculateTextHeight(FTitle.Text, FTitle.Font,  FTitle.WordWrap, FTitle.FTrimming, FTitle.Width);
        FTitle.FPlaceOffset := PointF(ARect.Left + ((ARect.Width - FTitle.Width) / 2), ARect.Bottom - FTitle.Height);

        TileImageOffsetB := FTitle.Height;
      end
      else if (FAppearance=iaTile_TitleImageSubTitle) then
      begin
        FSubTitle.Width        := CalculateTextWidth(FSubTitle.Text, FSubTitle.Font, False);
        FSubTitle.Height       := CalculateTextHeight(FSubTitle.Text, FSubTitle.Font, FSubTitle.WordWrap, FSubTitle.FTrimming, FSubTitle.Width);
        FSubTitle.FPlaceOffset := PointF(ARect.Left + ((ARect.Width - FSubTitle.Width) / 2), ARect.Bottom - FSubTitle.Height);

        TileImageOffsetB := FSubTitle.Height;
      end;

      if FImage.Bitmap <> nil then
      begin
        FImage.Width := ARect.Width;
        FImage.Height := ARect.Height - TileImageOffsetT - TileImageOffsetB;
        FImage.FPlaceOffset := PointF(ARect.Left, ARect.Top + TileImageOffsetT);
        ARect.Left := ARect.Left + FTableView.ItemImageSize + 4;
      end;
    end;

  finally
    FUpdating := False;
  end;
end;


{procedure TksTableViewItem.RecreateCache;
begin
  CacheItem(True);
end;}

procedure TksTableViewItem.ClearCache;
begin
  if FCached then
  begin
    FCached := false;
    _FBitmap.SetSize(0,0);
    Dec(FOwner.FCachedCount);
  end;
end;

function TksTableViewItem.Render(ACanvas: TCanvas; AScrollPos: single): TRectF;
var
  ARect: TRectF;
  AButtonRect: TRectF;
  AWidth: single;
  ASeperatorMargin: single;
  ASrcRect: TRectF;
begin
  if _FBitmap = nil then
    Exit;

  ARect := FItemRect;

  OffsetRect(ARect, 0, (0 - AScrollPos) + FTableView.GetStartOffsetY);

  if (FDragging) and (FTableView.DragDropOptions.DragSpaceColor <> claNull) then
  begin
    ACanvas.Fill.Color := FTableView.DragDropOptions.DragSpaceColor;
    ACanvas.FillRect(ARect, 0, 0, AllCorners, 1);
    Exit;
  end;

  CacheItem;



  if (TableView.FActionButtons.Visible = False) or (TableView.FActionButtons.TableItem <> Self) then
  begin
    ACanvas.DrawBitmap(_FBitmap, RectF(0, 0, _FBitmap.Width, _FBitmap.Height),
                       ARect, 1, True);

  end
  else
  begin
    AWidth   := (TableView.FActionButtons.TotalWidth / 100) * TableView.FActionButtons.PercentWidth;
    ASrcRect := RectF(0, 0, _FBitmap.Width, _FBitmap.Height);

    case TableView.FActionButtons.Alignment of
      abLeftActionButtons:
      begin
        ARect.Left  := ARect.Left + AWidth;
        ASrcRect.Right := ASrcRect.Right - (AWidth * GetScreenScale);
        AButtonRect := RectF(FItemRect.Left, ARect.Top, ARect.Left, ARect.Bottom);
        TableView.FActionButtons.Render(ACanvas, AButtonRect);
      end;
      abRightActionButtons:
      begin
        ARect.Right   := ARect.Right - AWidth;
        ASrcRect.Left := ASrcRect.Left + (AWidth * GetScreenScale);
        AButtonRect := RectF(ARect.Right, ARect.Top, FItemRect.Right, ARect.Bottom);
        TableView.FActionButtons.Render(ACanvas, AButtonRect);
      end;

    end;
    ACanvas.DrawBitmap(_FBitmap, ASrcRect, ARect, 1, True);
  end;

  if (FPurpose = TksTableViewItemPurpose.Header) or (FAppearance=iaNormal) then
  begin
    // seperator...
    ACanvas.Stroke.Color := FTableView.Appearence.SeparatorColor;
    ACanvas.StrokeThickness := 1;
    ACanvas.Stroke.Kind := TBrushKind.Solid;
    ACanvas.Stroke.Dash := TStrokeDash.Solid;
    if FPurpose = Header then
    begin
      ACanvas.Stroke.Color := $FFD2D2D2;
      ACanvas.StrokeThickness := 0.5;
    end;
    ASeperatorMargin := 0;
    if (FTableView.FullWidthSeparator = False) and (FPurpose = TksTableViewItemPurpose.None) then
      ASeperatorMargin := FTitle.FPlaceOffset.X;


    if (ARect.Left = 0) or (FColCount < 2) then
    begin
      ACanvas.DrawLine(PointF(ARect.Left + ASeperatorMargin, Round(ARect.Top) - 0.5),
                       PointF(FTableView.Width             , Round(ARect.Top) - 0.5), 1);

      if (IsLastItem) or (FPurpose = TksTableViewItemPurpose.Header) then
        ACanvas.DrawLine(PointF(0               , Round(ARect.Bottom) - 0.5),
                         PointF(FTableView.Width, Round(ARect.Bottom) - 0.5), 1);
    end;

    if (FPurpose <> Header) and not (FIsLastCol) then
      ACanvas.DrawLine(PointF(Round(ARect.Right) - 0.5, ARect.Top),
                       PointF(Round(ARect.Right) - 0.5, ARect.Bottom), 1);


    Result := ARect;
  end;

  {finally
    ACanvas.EndScene;
  //  ACanvas.RestoreState(AState);
  end;   }

  end;

procedure TksTableViewItem.SetCached(const Value: Boolean);
begin
  FCached := Value;
end;

procedure TksTableViewItem.SetChecked(const Value: Boolean);
begin
  if FChecked <> Value then
  begin
    FChecked := Value;
    case FChecked of
      True: FCheckMarkAccessory := TableView.CheckMarkOptions.FCheckMarkChecked;
      False: FCheckMarkAccessory := TableView.CheckMarkOptions.FCheckMarkUnchecked;
    end;
    Changed;
    if Assigned(FTableView.OnItemCheckmarkChanged) then
      FTableView.OnItemCheckmarkChanged(Self, Self, FChecked);

    if (Purpose=Header) and
       (FTableView.CheckMarkOptions.FHeaderCheckSelectsAll) and
       (FTableView.FCascadeHeaderCheck) then
      FTableView.CheckChildren(Self,Value);


    if (Purpose <> Header) and (FTableView.CheckMarkOptions.FHeaderCheckSelectsAll) and (Value = False) then
    begin
      FTableView.FCascadeHeaderCheck := False;
      FTableView.UncheckHeader(Self);
      FTableView.FCascadeHeaderCheck := True;
    end;

  end;
end;

procedure TksTableViewItem.SetItemData(const AIndex: string; const Value: TValue);
begin
  if FData = nil then
    FData := TDictionary<string, TValue>.Create;
  FData.AddOrSetValue(AIndex, Value);
end;

procedure TksTableViewItem.SetFill(const Value: TBrush);
begin
  if Value <> nil then
    FFill.Assign(Value)
end;

procedure TksTableViewItem.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TksTableViewItem.SetHeight(const Value: single);
begin
  if Value <> FHeight then
  begin
    FHeight := Value;
    FTableView.UpdateItemRects(True);
    //FTableView.UpdateAll(False);
    if not FDeleting then
      CacheItem(True);
  end;
end;

procedure TksTableViewItem.SetHeightPercentage(const Value: single);
begin
  if Value <> FHeight then
  begin
    FHeightPercentage := Value;
    FTableView.UpdateAll(False);
    Invalidate;
  end;
end;

procedure TksTableViewItem.SetIndex(const Value: integer);
begin
  FIndex := Value;
end;

procedure TksTableViewItem.SelectFirstEmbeddedEdit;
var
  ICount: integer;
begin
  for ICount := 0 to FObjects.Count-1 do
  begin
    if (FObjects[ICount] is TksTableViewItemEmbeddedBaseEdit) then
    begin
      (FObjects[ICount] as TksTableViewItemEmbeddedBaseEdit).FocusControl;
      Exit;
    end;
  end;
end;

procedure TksTableViewItem.SetAppearance(const Value: TksTableViewItemAppearance);
begin
  if (FAppearance<>Value) then
  begin
    FAppearance := Value;
    FCached := False;
    Invalidate;
  end;
end;

procedure TksTableViewItem.SetHidden(const Value: Boolean);
begin
  if (FHidden<>Value) then
  begin
    FHidden := Value;
    FTableView.ClearCache(ksClearCacheAll);
    FTableView.UpdateAll(true);
    Invalidate;
  end;
end;

procedure TksTableViewItem.SetIndicatorColor(const Value: TAlphaColor);
begin
  FIndicator.Fill.Color := Value;
  FCached := False;
  Invalidate;
end;

procedure TksTableViewItem.SetItemFontStyle(AFontStyle: TFontStyles);
var
  ICount: integer;
begin
  FFont.Style := AFontStyle;
  for ICount := 0 to FObjects.Count - 1 do
  begin
    if (FObjects[ICount] is TksTableViewItemText) then
      (FObjects[ICount] as TksTableViewItemText).Font.Style := AFontStyle;
  end;
  FTitle.Font.Style := AFontStyle;
  FSubTitle.Font.Style := AFontStyle;
  FDetail.Font.Style := AFontStyle;
end;

procedure TksTableViewItem.SetItemRect(const Value: TRectF);
var
  ALastHeight: single;
begin
  ALastHeight := FItemRect.Height;
  FItemRect := Value;
  if FItemRect.Height <> ALastHeight then
    Changed;
end;

procedure TksTableViewItem.SetItemTextColor(AColor: TAlphaColor);
var
  ICount: integer;
begin
  FTextColor := AColor;
  for ICount := 0 to FObjects.Count - 1 do
  begin
    if (FObjects[ICount] is TksTableViewItemText) then
      (FObjects[ICount] as TksTableViewItemText).TextColor := AColor;
  end;
  FTitle.TextColor := AColor;
  FSubTitle.TextColor := AColor;
  FDetail.TextColor := AColor;
  Changed;
end;

procedure TksTableViewItem.SetPickerItems(const Value: TStrings);
begin
  FPickerItems.Assign(Value);
end;

procedure TksTableViewItem.SetPurpose(const Value: TksTableViewItemPurpose);
begin
  if FPurpose <> Value then
  begin
    FPurpose := Value;
    Changed;
  end;
end;

procedure TksTableViewItem.ExpandIndicatorToWidth;
var
  ICount: integer;
  ACurrentlyExpanded: TksTableViewItem;
  ASteps: integer;
  AStepValue: single;
begin
  ACurrentlyExpanded := nil;
  FTableView.DisableMouseEvents;
  try
    if Trunc(FIndicator.Width) = (ItemRect.Right) then
      Exit;
    for ICount := 0 to FTableView.Items.Count-1 do
    begin
      if FTableView.Items[ICount].FIndicator.Width > FTableView.RowIndicators.Width then
      begin
        ACurrentlyExpanded := FTableView.Items[ICount];
        ACurrentlyExpanded.FForegroundColor := claNull;
        Break;
      end;
    end;

    FForegroundColor := claNull;
    if Assigned(FTableView.OnIndicatorExpand) then
      FTableView.OnIndicatorExpand(Self, Self, FIndicator.Fill.Color, FForegroundColor);

    ASteps := 10;

    AStepValue := (ItemRect.Width / ASteps);

    for ICount := 1 to ASteps do
    begin
      if ACurrentlyExpanded
      <> nil then
        ACurrentlyExpanded.FIndicator.Width := (ItemRect.Right - (ICount * AStepValue));
      FIndicator.Width := (ICount * AStepValue);
      ProcessMessages;
      {$IFDEF MSWINDOWS}
      Sleep(10);
      {$ENDIF}
    end;
  finally
    FTableView.EnableMouseEvents;
  end;
end;

procedure TksTableViewItem.SetColCount(const Value: Integer);
begin
  if FColCount <> Value then
  begin
    FColCount := Value;
    FTableView.ClearCache(ksClearCacheAll);
    FTableView.UpdateAll(True);
    Changed;
  end;
end;

procedure TksTableViewItem.SetSearchFilter(const Value: string);
begin
  FSearchFilter := Value;
  UpdateSearchIndex;
end;
 {
procedure TksTableViewItem.SetSearchIndex(const Value: string);
begin
  FSearchIndex := Value;
end;
       }
procedure TksTableViewItem.SetTextColor(const Value: TAlphaColor);
begin
  FTextColor := Value;
end;

function TksTableViewItem.TextBox(AText: string; ARect: TRectF;
  ATextAlign, ATextLayout: TTextAlign; const ABackground: TAlphaColor)
  : TksTableViewItemText;
begin
  FUpdating := True;
  try
    Result := TextOut(AText, ARect.Left, ARect.Top, ARect.Width,
      TksTableItemAlign.Leading, True);
    Result.Background := ABackground;
    Result.Height := ARect.Height;
    Result.TextAlignment := ATextAlign;
    Result.TextVertAlign := ATextLayout;
  finally
    FUpdating := False;
  end;
  Changed;
end;

function TksTableViewItem.TextBoxHtml(AText: string; ARect: TRectF)
  : TksTableViewItemText;
begin
  FUpdating := True;
  try
    Result := TextOut(AText, ARect.Left, ARect.Top, ARect.Width,
      TksTableItemAlign.Leading, True);
    Result.FIsHtmlText := True;
    Result.Height := ARect.Height;
  finally
    FUpdating := False;
  end;
  Changed;
end;

function TksTableViewItem.TextHeight(AText: string; AWordWrap, AIsHtml: Boolean; ATrimming: TTextTrimming;
  const AMaxWidth: single): single;
begin
  if AIsHtml then
    Result := GetTextSizeHtml(AText, FFont, AMaxWidth).y
  else
    Result := CalculateTextHeight(AText, FFont, AWordWrap, ATrimming, AMaxWidth);
end;

function TksTableViewItem.TextOut(AText: string; x: single;
  const AVertAlign: TksTableItemAlign; const AWordWrap: Boolean)
  : TksTableViewItemText;
var
  AWidth: single;
begin
  AWidth := TextWidth(AText, False);
  Result := TextOut(AText, x, AWidth, AVertAlign, AWordWrap);
end;

function TksTableViewItem.TextOut(AText: string; x, y, AWidth: single;
  const AVertAlign: TksTableItemAlign; const AWordWrap: Boolean)
  : TksTableViewItemText;
var
  AHeight: single;
begin
  Result := TksTableViewItemText.Create(Self);

  Result.Font.Assign(Font);
  Result.FPlaceOffset := PointF(x, y);

  AHeight := CalculateTextHeight(AText, FFont, AWordWrap, Result.Trimming, AWidth);
  if AWidth = 0 then
    AWidth := CalculateTextWidth(AText, Font, AWordWrap);

  Result.Width := AWidth;
  Result.Height := AHeight;

  Result.VertAlign := AVertAlign;
  Result.TextAlignment := TTextAlign.Leading;
  Result.TextColor := FTextColor;
  Result.Text := AText;
  Result.WordWrap := AWordWrap;
  //if SearchIndex = '' then
  //  SearchIndex := AText;
  UpdateSearchIndex;
  FObjects.Add(Result);
  Changed;
end;

function TksTableViewItem.TextOut(AText: string; x, AWidth: single;
  const AVertAlign: TksTableItemAlign; const AWordWrap: Boolean)
  : TksTableViewItemText;
begin
  Result := TextOut(AText, x, 0, AWidth, AVertAlign, AWordWrap);
end;

function TksTableViewItem.TextOutRight(AText: string;
  y, AWidth, AXOffset: single; const AVertAlign: TksTableItemAlign)
  : TksTableViewItemText;
begin
  FUpdating := True;
  try
    Result := TextOut(AText, AXOffset, y, AWidth, AVertAlign);
    Result.Align := TksTableItemAlign.Trailing;
    Result.TextAlignment := TTextAlign.Trailing;
  finally
    FUpdating := False;
  end;
  Changed;
end;

function TksTableViewItem.TextWidth(AText: string; AIsHtml: Boolean): single;
begin
  if AIsHtml then
    Result := GetTextSizeHtml(AText, FFont, 0).x
  else
    Result := CalculateTextWidth(AText, FFont, False);
end;

function TksTableViewItem.TimeToCacheItem: integer;
var
  AStart: TDateTime;
begin
  AStart := Now;
  CacheItem(True);
  Invalidate;
  ProcessMessages;
  Result := MilliSecondsBetween(Now, AStart);
end;

procedure TksTableViewItem.UpdateSearchIndex;
var
  ICount: integer;
begin
  FSearchIndex := '';
  FSearchIndex := FTitle.Text+'|'+FSubTitle.Text+'|'+FDetail.Text+'|';
  for ICount := 0 to FObjects.Count-1 do
  begin
    if FObjects[ICount] is TksTableViewItemText then
      FSearchIndex := FSearchIndex + LowerCase((FObjects[ICount] as TksTableViewItemText).Text)+#13;
  end;
  FSearchIndex := Trim(FSearchIndex);
  if FSearchFilter <> '' then
    FSearchIndex := FSearchIndex + '|'+FSearchFilter;
end;

// ------------------------------------------------------------------------------

{ TksTableViewAppearence }

constructor TksTableViewAppearence.Create(AListView: TksTableView);
begin
  inherited Create;
  FListView := AListView;
  FItemBackground := TBrush.Create(TBrushKind.Solid, claWhite);
  FBackground := TBrush.Create(TBrushKind.Solid, claWhite);
  FSeparatorColor := $FFF0F0F0;
  FSelectedColor := C_TABLEVIEW_DEFAULT_SELECTED_COLOR;
  FAlternatingItemBackground := claNull;
end;

destructor TksTableViewAppearence.Destroy;
begin
  FreeAndNil(FItemBackground);
  FreeAndNil(FBackground);
  inherited;
end;

procedure TksTableViewAppearence.Assign(ASource: TPersistent);
var
  Src : TksTableViewAppearence;
begin
  if (ASource is TksTableViewAppearence) then
  begin
    Src := TksTableViewAppearence(ASource);

    FBackground.Assign(Src.FBackground);
    FItemBackground.Assign(Src.FItemBackground);
    FAlternatingItemBackground := Src.FAlternatingItemBackground;
    FSeparatorColor            := Src.FSeparatorColor;
    FHeaderColor               := Src.FHeaderColor;
    FSelectedColor             := Src.FSelectedColor;
  end
  else
    inherited;
end;

procedure TksTableViewAppearence.SetAlternatingItemBackground
  (const Value: TAlphaColor);
begin
  FAlternatingItemBackground := Value;
end;

procedure TksTableViewAppearence.SetBackground(const Value: TBrush);
begin
  if Value <> nil then
    FBackground.Assign(Value);
end;

procedure TksTableViewAppearence.SetHeaderColor(const Value: TAlphaColor);
begin
  FHeaderColor := Value;
end;

procedure TksTableViewAppearence.SetItemBackground(const Value: TBrush);
begin
  if Value <> nil then
    FItemBackground.Assign(Value);
end;

procedure TksTableViewAppearence.SetSelectedColor(const Value: TAlphaColor);
begin
  FSelectedColor := Value;
end;

procedure TksTableViewAppearence.SetSeparatorBackground
  (const Value: TAlphaColor);
begin
  FSeparatorColor := Value;
end;

// ------------------------------------------------------------------------------

{ TksTableView }

procedure TksTableView.BeginUpdate;
begin
  KillAllTimers;
  FUpdateCount := FUpdateCount + 1;
end;

procedure TksTableView.AniCalcStart(Sender: TObject);
begin
  if Scene <> nil then
    Scene.ChangeScrollingState(Self, True);

  //FScrolling := True;
end;

procedure TksTableView.UpdateAll(AUpdateFiltered: Boolean);
begin
  if FUpdateCount > 0 then
    Exit;

  FItems.UpdateIndexes; // <- here
  UpdateItemRects(AUpdateFiltered);
  UpdateStickyHeaders;
  UpdateScrollingLimits;


  {if (FItems.Count > 0) and (TopItem <> nil) then
  begin
    AStartIndex := Max(TopItem.Index - (C_TABLEVIEW_PAGE_SIZE div 2), 0);
    AEndIndex := Min(FItems.Count-1, AStartIndex + C_TABLEVIEW_PAGE_SIZE);
    for ICount := AStartIndex to AEndIndex do
      FItems[ICount].CacheItem(False);
  end;}
end;

procedure TksTableView.UpdateItemRects(AUpdateFiltered: Boolean);
var
  ICount: integer;
  AYPos: single;
  AXPos: single;
  ANoCols: integer;
  ACol: Integer;
  ARow: Integer;
  AHeight: single;
  AClientHeight: single;
  AWidth: single;
  AItem: TksTableViewItem;
  AIsLastRow: Boolean;
  AFixedHeaderEnd : Integer;
  AFixedFooterStart : Integer;
  AFixedHeaderHeight: Single;
  AFixedFooterHeight: Single;
  ASearchHeight: Single;
begin
  if FUpdateCount > 0 then
    Exit;

  if AUpdateFiltered then
    UpdateFilteredItems;

  AClientHeight := Height;

  if (FFixedRowOptions.FHeaderCount>0) or (FFixedRowOptions.FFooterCount>0) then
  begin
    AFixedHeaderEnd    := Min(FFixedRowOptions.FHeaderCount,Items.Count)-1;
    AFixedFooterStart  := Max(0,Items.Count-FFixedRowOptions.FFooterCount);
    AFixedHeaderHeight := 0;
    AFixedFooterHeight := 0;
    ASearchHeight      := GetSearchHeight;

    AYPos := ASearchHeight;
    for ICount := 0 to AFixedHeaderEnd do
    begin
      AItem := Items[ICount];

      if (AItem.HeightPercentage>0) then
         AItem.FHeight := AClientHeight * AItem.HeightPercentage / 100.0;

      AItem.ItemRect     := RectF(0, AYPos, Width, AYPos + AItem.Height);
      AYPos              := AYPos + AItem.Height;
      AFixedHeaderHeight := AFixedHeaderHeight + AItem.Height;

      AItem.FCheckmarkAllowed := false;
      AItem.FIsFixedHeader    := true;
    end;

    AYPos := Height;
    for ICount := AFixedFooterStart to Items.Count-1 do
      AYPos := AYPos - Items[ICount].Height;

    for ICount := AFixedFooterStart to Items.Count-1 do
    begin
      AItem := Items[ICount];

      if (AItem.HeightPercentage>0) then
         AItem.FHeight := AClientHeight * AItem.HeightPercentage / 100.0;

      AItem.ItemRect     := RectF(0, AYPos, Width, AYPos + AItem.Height);
      AYPos              := AYPos + AItem.Height;
      AFixedFooterHeight := AFixedFooterHeight + AItem.Height;

      AItem.FCheckmarkAllowed := false;
      AItem.FIsFixedFooter    := true;
    end;

    AHeight := Height - ASearchHeight - AFixedHeaderHeight - AFixedFooterHeight;

    if (AHeight<FFixedRowOptions.FMinimumWorkHeight) then
    begin
      AYPos   := Min(AFixedFooterHeight,FFixedRowOptions.FMinimumWorkHeight-AHeight);
      AHeight := AHeight + AYPos;

      for ICount := AFixedFooterStart to Items.Count-1 do
        OffsetRect(Items[ICount].FItemRect,0,AYPos);
    end;

    if (AHeight<FFixedRowOptions.FMinimumWorkHeight) then
    begin
      AYPos := Min(AFixedHeaderHeight,FFixedRowOptions.FMinimumWorkHeight-AHeight);

      for ICount := 0 to AFixedHeaderEnd do
        OffsetRect(Items[ICount].FItemRect,0,-AYPos);
    end;
  end;

  AHeight       := 0;
  ANoCols       := Max(1,ColCount);
  AWidth        := Width / ANoCols;
  AXPos         := 0;
  AYPos         := 0;
  ACol          := 0;
  ARow          := 0;
  AClientHeight := Height - GetStartOffsetY;

  for ICount := 0 to FFilteredItems.Count - 1 do
  begin
    AItem := FFilteredItems[ICount];

    if (AItem.HeightPercentage>0) then
       AItem.FHeight := AClientHeight * AItem.HeightPercentage / 100;

    if (AItem.Purpose=TksTableViewItemPurpose.Header) then
    begin
      ARow := 0;
      if (ACol>0) then
      begin
        ACol  := 0;
        AYPos := AYPos + AHeight;
      end;

      if (AItem.FHeaderHeight>0) then
        AHeight := AItem.FHeaderHeight
      else
        AHeight := AItem.Height;

      AItem.ItemRect := RectF(0, AYPos, Width, AYPos + AHeight);

      if (AItem.ColCount>0) then
        ANoCols := AItem.ColCount
      else
        ANoCols := Max(1,AItem.ColCount);

      AWidth := Width / ANoCols;

      AItem.FCheckmarkAllowed := FCheckMarkOptions.ShowInHeader;
    end
    else
    begin
      AItem.ItemRect := RectF(AXPos, AYPos, AXPos + AWidth, AYPos + AItem.Height);

      // First column item sets row height
      if (ACol=0) then
        AHeight := AItem.Height;

      AItem.FCheckmarkAllowed := true;
    end;

    AItem.FIsFirstCol    := (ACol=0);
    AItem.FIsLastCol     := (ACol=ANoCols-1);
    AItem.FIsFirstRow    := (ARow=0);
    AItem.FIsLastRow     := false;
    AItem.FIsFixedHeader := false;
    AItem.FIsFixedFooter := false;
    AItem.Index          := ICount;

    if (AItem.Purpose<>TksTableViewItemPurpose.Header) and (ACol<ANoCols-1) then
    begin
      Inc(ACol);
      AXPos := AXPos + AWidth;
    end
    else
    begin
      AYPos := AYPos + AHeight;
      ACol  := 0;
      AXPos := 0;
      if (AItem.Purpose<>TksTableViewItemPurpose.Header) then
        Inc(ARow);
    end;
  end;
  AIsLastRow := true;
  for ICount := FFilteredItems.Count - 1 downto 0 do
  begin
    AItem := FFilteredItems[ICount];

    if (FFilteredItems[ICount].Purpose=TksTableViewItemPurpose.Header) then
      AIsLastRow := true
    else
    begin
      AItem.FIsLastRow  := AIsLastRow;
      if (AItem.FIsFirstCol) then
        AIsLastRow := false;
    end;
  end;
end;

procedure TksTableView.UpdateScrollingLimits;
var
  Targets: array of TAniCalculations.TTarget;
begin
  if FUpdateCount > 0 then
    Exit;
  if FAniCalc <> nil then
  begin
    SetLength(Targets, 2);
    Targets[0].TargetType := TAniCalculations.TTargetType.Min;
    Targets[0].Point := TPointD.Create(0, 0);
    Targets[1].TargetType := TAniCalculations.TTargetType.Max;
    FMaxScrollPos := Max((GetTotalItemHeight - Height) + GetStartOffsetY + GetFixedFooterHeight, 0);
    if FMaxScrollPos < FScrollPos then
      FScrollPos := FMaxScrollPos;
    Targets[1].Point := TPointD.Create(0,FMaxScrollPos);
    FAniCalc.SetTargets(Targets);
    FAniCalc.ViewportPosition := PointF(0, FScrollPos);
  end;
end;

procedure TksTableView.AniCalcStop(Sender: TObject);
begin
  FScrolling := False;
  FSwipeDirection := ksSwipeUnknown;
  //ClearCache(ksClearCacheNonVisible);

  if Scene <> nil then
    Scene.ChangeScrollingState(nil, False);
end;

procedure TksTableView.AniCalcChange(Sender: TObject);
var
  NewViewPos: single;
begin
  {$IFDEF MSWINDOWS}
  NewViewPos := Trunc(FAniCalc.ViewportPosition.y);
  {$ELSE}
  NewViewPos := FAniCalc.ViewportPosition.y;
  {$ENDIF}
  if FScrolling then
  begin
    SetScrollViewPos(NewViewPos);
  end;
end;
 (*
procedure TksTableView.CacheItems(AForceRedraw: Boolean);
var
  ICount: integer;
  ATopItem: TksTableViewItem;
  AItems: TksTableViewItems;
  AStartPos: integer;
begin
  {ATopItem := TopItem;
  if ATopItem = nil then
    Exit;
  AItems := FFilteredItems;

  AStartPos := Max(ATopItem.Index, 0);
  if Items.Count < C_TABLEVIEW_PAGE_SIZE then
    AStartPos := 0;
  for ICount := AStartPos to (AStartPos + C_TABLEVIEW_PAGE_SIZE) do
  begin
    if ICount > AItems.Count - 1 then
      Exit;
    AItems[ICount].CacheItem(AForceRedraw);
  end;   }
end;    *)

procedure TksTableView.ClearItems;
begin
  FItemIndex := -1;
  FScrollPos := 0;
  FFilteredItems.Clear;
  FItems.Clear;
  if FUpdateCount = 0 then
    Invalidate;
end;

procedure TksTableView.ComboClosePopup(Sender: TObject);
begin
  (Sender as TStyledControl).Width := 0;
  (Sender as TStyledControl).Visible := False;
end;

constructor TksTableView.Create(AOwner: TComponent);
begin
  inherited;
  AUnitTesting := AOwner = nil;
  TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, FTimerService);

  FItems := TksTableViewItems.Create(Self, True);
  FFilteredItems := TksTableViewItems.Create(Self, False);
  FBackgroundText := TksTableViewBackgroundText.Create;
  FRowIndicators := TksListViewRowIndicators.Create(Self);
  FDeleteButton := TksDeleteButton.Create;
  FAppearence := TksTableViewAppearence.Create(Self);
  FDragDropOptions := TksDragDropOptions.Create;
  FSelectionOptions := TksTableViewSelectionOptions.Create(Self);
  FAccessoryOptions := TksTableViewAccessoryOptions.Create(Self);
  FHeaderOptions := TksTableViewItemHeaderOptions.Create(Self);
  FBorder := TksTableViewBorderOptions.Create(Self);
  FFixedRowOptions := TksTableViewFixedRowsOptions.Create(Self);
  FCheckMarkOptions:= TksTableViewCheckMarkOptions.Create(Self);
  FActionButtons := TksTableViewActionButtons.Create(Self);

  FSearchBox := TSearchBox.Create(Self);
  FSearchBox.Stored := False;
  FSearchBox.Locked := True;
  FSearchBox.Visible := False;
  FSearchBox.Align := TAlignLayout.Top;
  FSearchBox.OnTyping := DoFilterChanged;
  FSearchBox.OnChange := DoFilterChanged;
  FSearchBox.OnEnter := DoFilterEnter;
  FSearchBox.Parent := Self;

  FTextDefaults := TksTableViewTextDefaults.Create;
  FPullToRefresh := TksTableViewPullToRefresh.Create(Self);
  Size.Width := C_TABLEVIEW_DEFAULT_WIDTH;
  Size.Height := C_TABLEVIEW_DEFAULT_HEIGHT;
  ClipChildren := True;

  FAniCalc := nil;
  CreateAniCalculator(True);
  FSearchVisible := False;
  FItemIndex := -1;
  FItemHeight := C_TABLEVIEW_DEFAULT_ITEM_HEIGHT;
  FItemImageSize := C_TABLEVIEW_DEFAULT_IMAGE_SIZE;

  FNeedsRefresh := False;
  FMouseDown := False;

  FFullWidthSeparator := True;
  FStickyHeader := Nil;
  FLastCacheClear := Now;

  FUpdateCount := 0;
  FDragging := False;
  AddObject(FSearchBox);
  SetAcceptsControls(False);
  FItems.OnNotify := DoItemsChanged;
  FCascadeHeaderCheck := True;
  CanFocus := True;
  AutoCapture := True;
  FMouseEventsEnabledCounter := 0;
  //FClearCacheTimer := CreateTimer(1000, DoClearCacheTimer)
end;

procedure TksTableView.CreateAniCalculator(AUpdateScrollLimit: Boolean);
begin
  if FAniCalc <> nil then
    FreeAndNil(FAniCalc);
  FAniCalc := TksAniCalc.Create(nil);
  FAniCalc.Animation := True;
  FAniCalc.Averaging := True;
  FAniCalc.Interval := 8;
  FAniCalc.BoundsAnimation := True;
  FAniCalc.TouchTracking := [ttVertical];
  if AUpdateScrollLimit then
    UpdateScrollingLimits;
  // set events...
  FAniCalc.OnChanged := AniCalcChange;
  FAniCalc.OnStart := AniCalcStart;
  FAniCalc.OnStop := AniCalcStop;
end;

destructor TksTableView.Destroy;
begin
  KillTimer(FClearCacheTimer);
  if FSearchBox <> nil then
  begin
    FSearchBox.Parent := nil;
    FreeAndNil(FSearchBox);
  end;
  FreeAndNil(FCheckMarkOptions);
  FreeAndNil(FFixedRowOptions);
  FreeAndNil(FBorder);
  FreeAndNil(FHeaderOptions);
  FreeAndNil(FAccessoryOptions);
  FreeAndNil(FRowIndicators);
  FreeAndNil(FBackgroundText);
  FreeAndNil(FFilteredItems);
  FreeAndNil(FItems);
  FreeAndNil(FAniCalc);
  FreeAndNil(FAppearence);
  FreeAndNil(FDragDropOptions);
  FreeAndNil(FDeleteButton);
  FreeAndNil(FTextDefaults);
  FreeAndNil(FPullToRefresh);
  FreeAndNil(FSelectionOptions);
  FreeAndNil(FActionButtons);
  inherited;
end;

procedure TksTableView.DisableMouseEvents;
begin
  Inc(FMouseEventsEnabledCounter);
end;

function TksTableView.CreateTimer(AInterval: integer; AProc: TTimerProc): TFmxHandle;
begin
  Result := 0;
  if FTimerService <> nil then
    Result := FTimerService.CreateTimer(AInterval, AProc);
end;

procedure TksTableView.DoButtonClicked(AItem: TksTableViewItem; AButton: TksTableViewItemButton);
begin
  if Assigned(FOnButtonClicked) then
    FOnButtonClicked(Self, AItem, AButton, AItem.ID);
end;

{
procedure TksTableView.DoClearCacheTimer;
var
  AViewPort: TRectF;
  ICount: integer;
  AItem: TksTableViewItem;
begin
  if MilliSecondsBetween(FLastCacheClear, Now) > 1000 then
  begin
    FLastCacheClear := Now;
    AViewport := ViewPort;
    AViewPort.Top := AViewPort.Top - 1000;
    AViewPort.Bottom := AViewPort.Bottom + 1000;
    for ICount := 0 to FItems.Count-1 do
    begin
      AItem := FItems[ICount];
      if (AItem.Cached) and (AItem.IsVisible(AViewPort) = False) then
        AItem.ClearCache;
    end;
  end;
end;    }

procedure TksTableView.DoDeselectItem;
var
  ASelected: TksTableViewItem;
begin
  if FTimerService = nil then
    Exit;
  KillTimer(FDeselectTimer);
  ASelected := SelectedItem;
  if ASelected <> nil then
  begin
    ASelected.DeselectObjects;
    FItemIndex := -1;
    ASelected.CacheItem(True);
    Invalidate;
    if FFocusedControl <> nil then
      FFocusedControl.FocusControl;
  end
end;

procedure TksTableView.DoEmbeddedEditChange(AItem: TksTableViewItem; AEmbeddedEdit: TksTableViewItemEmbeddedBaseEdit);
begin
  if Assigned(FOnEmbeddedEditChange) then
    FOnEmbeddedEditChange(Self, AItem, AEmbeddedEdit, AEmbeddedEdit.Text);
end;

procedure TksTableView.DoEmbeddedDateEditChange(AItem: TksTableViewItem; AEmbeddedDateEdit: TksTableViewItemEmbeddedDateEdit);
begin
  if Assigned(FOnEmbeddedDateEditChange) then
    FOnEmbeddedDateEditChange(Self, AItem, AEmbeddedDateEdit, AEmbeddedDateEdit.Date);
end;

procedure TksTableView.LegacyGetShowAccessory(Reader: TReader);
begin
  FAccessoryOptions.ShowAccessory := Reader.ReadBoolean;
end;

procedure TksTableView.LegacyGetStickyHeaders(Reader: TReader);
begin
  FHeaderOptions.StickyHeaders.Enabled := Reader.ReadBoolean;
end;

procedure TksTableView.LegacyGetHeaderHeight(Reader: TReader);
begin
  FHeaderOptions.Height := Reader.ReadInteger;
end;

procedure TksTableView.LegacyGetCheckMarks(Reader: TReader);
begin
  FCheckMarkOptions.CheckMarks := TksTableViewCheckMarks(GetEnumValue(TypeInfo(TksTableViewCheckMarks),Reader.ReadIdent));
end;

procedure TksTableView.DefineProperties(Filer: TFiler);
begin
  inherited;
  // deleted properties...
  Filer.DefineProperty('ShowAccessory', LegacyGetShowAccessory, nil, False);
  Filer.DefineProperty('StickyHeaders', LegacyGetStickyHeaders, nil, False);
  Filer.DefineProperty('HeaderHeight', LegacyGetHeaderHeight, nil, False);
  Filer.DefineProperty('CheckMarks', LegacyGetCheckMarks, nil, False);
end;

//------------------------------------------------------------------------------

procedure TksTableView.DeselectItem(const ADelay: integer);
begin
  if ADelay > 0 then
  begin
    KillTimer(FDeselectTimer);
    FDeselectTimer := CreateTimer(ADelay, DoDeselectItem)
  end
  else
    DoDeselectItem;
end;

procedure TksTableView.DoFilterChanged(Sender: TObject);
begin
  SetScrollViewPos(0);
  UpdateAll(True);
  Repaint;
  if Assigned(FOnSearchFilterChanged) then
    FOnSearchFilterChanged(Self, FSearchBox.Text);
end;

procedure TksTableView.DoFilterEnter(Sender: TObject);
begin
  HideFocusedControl;
end;

procedure TksTableView.DoItemObjectMouseUp(AObject: TksTableViewItemObject; x, y: single);
begin
  if Assigned(FItemObjectMouseUpEvent) then
    FItemObjectMouseUpEvent(Self, x, y, AObject.TableItem, AObject.ID, AObject);
end;

procedure TksTableView.DoItemsChanged(Sender: TObject;
  const Item: TksTableViewItem; Action: TCollectionNotification);
begin
  if (FUpdateCount > 0) then
    Exit;
  UpdateFilteredItems;
end;

procedure TksTableView.DoMouseLeave;
begin
  inherited;
  if (FAniCalc <> nil) then
    FAniCalc.MouseLeave;
  FMouseDown := False;
end;

procedure TksTableView.DoPullToRefresh;
begin
  if Assigned(FOnPullRefresh) then
  begin
    KillAllTimers;
    DisableMouseEvents;
    FOnPullRefresh(Self);
    EnableMouseEvents;
  end;
end;

procedure TksTableView.DoSelectDate(Sender: TObject);
var
  AAllow: Boolean;
  ARow: TksTableViewItem;
begin
  AAllow := True;
  ARow := TksTableViewItem(FDateSelector.TagObject);
  if AAllow then
  begin
    ARow.FSelectionValue := FDateSelector.Date;
    ARow.Detail.Text := FormatDateTime('ddd, dd mmmm, yyyy', FDateSelector.Date);
    ARow.Cached := False;
  end;
  if Assigned(FOnSelectDate) then
    FOnSelectDate(Self, ARow, FDateSelector.Date, AAllow);
end;

procedure TksTableView.DoSelectItem;
begin
  KillTimer(FSelectTimer);
  if FMouseDownItem = nil then
    Exit;
  if FMouseDownItem.TableView.FActionButtons.Visible then
  begin
    FMouseDownItem.DoClick(FMouseDownPoint.x, (FMouseDownPoint.y - FMouseDownItem.ItemRect.Top) + ScrollViewPos);
    Exit;
  end;

  if (CheckMarkOptions.FCheckMarks <> TksTableViewCheckMarks.cmMultiSelect) and (FActionButtons.Visible = False) then
  begin
    UncheckAll;
    ItemIndex := FMouseDownItem.Index;
  end;

  FMouseDownItem.DoClick(FMouseDownPoint.x, (FMouseDownPoint.y - FMouseDownItem.ItemRect.Top) + ScrollViewPos);

  // select the first embedded edit if no OnClick event handler exists for the table item
  FMouseDownItem.SelectFirstEmbeddedEdit;


  if FRowIndicators.SelectRow then
  //begin
    FMouseDownItem.ExpandIndicatorToWidth;
  //end;

  if Assigned(FItemClickEvent) then
    FItemClickEvent(Self, FMouseDownPoint.x, FMouseDownPoint.y, FMouseDownItem, FMouseDownItem.ID, FMouseDownObject);

  FActionButtons.HideButtons;

end;

procedure TksTableView.DoSelectPickerItem(Sender: TObject);
var
  AAllow: Boolean;
  ASelected: string;
  AItem: TksTableViewItem;
begin
  ASelected := '';
  AItem := TksTableViewItem(FCombo.TagObject);
  if FCombo.ItemIndex > -1 then
    ASelected := FCombo.Items[FCombo.ItemIndex];
  AAllow := True;

  if Assigned(FOnSelectPickerItem) then
    FOnSelectPickerItem(Self, AItem, ASelected, AAllow);

  if Assigned(FOnSelectPickerItemExt) then
    FOnSelectPickerItemExt(Self, AItem, ASelected, FCombo.Items.IndexOf(ASelected), AAllow);

  if AAllow then
  begin
    AItem.FSelectionValue := ASelected;
    AItem.Detail.Text := ASelected;
    AItem.CacheItem(True);
  end;
end;

procedure TksTableView.DoSwitchClicked(AItem: TksTableViewItem; ASwitch: TksTableViewItemSwitch);
begin
  if Assigned(FOnSwitchClicked) then
    FOnSwitchClicked(Self, AItem, ASwitch, AItem.ID);
end;

procedure TksTableView.EnableMouseEvents;
begin
  // process any pending mouse events before re-enabling...
  ProcessMessages;
  Dec(FMouseEventsEnabledCounter);
end;

procedure TksTableView.EndUpdate;
begin
  if FUpdateCount = 0 then
    Exit;
  FUpdateCount := FUpdateCount - 1;
  if FUpdateCount = 0 then
  begin
    ClearCache(ksClearCacheAll);
    UpdateAll(True);
    Invalidate;
  end;
end;

procedure TksTableView.UncheckAll;
var
  ICount: integer;
begin
  for ICount := 0 to FItems.Count - 1 do
  begin
    Items[ICount].Checked := False;
  end;
end;

procedure TksTableView.UpdateFilteredItems;
var
  ICount: integer;
  ASearchText: string;
  ALastSelected: TksTableViewItem;
  AItem: TksTableViewItem;
begin
  if (FFilteredItems = nil) then
    Exit;
  ALastSelected := SelectedItem;

  FFilteredItems.Clear;
  ASearchText := Trim(FSearchBox.Text);

  for ICount := FFixedRowOptions.FHeaderCount to (FItems.Count-FFixedRowOptions.FFooterCount-1) do
  begin
    AItem := FItems[ICount];
    if (AItem.MatchesSearch(ASearchText)) and not (AItem.Hidden) then
    begin
      AItem.Index := FFilteredItems.Count;
      FFilteredItems.Add(AItem);
    end;
  end;
  FItemIndex := FFilteredItems.IndexOf(ALastSelected);
end;


procedure TksTableView.DoSelectTimer;
var
  Form : TCustomForm;
  AAllowDrag: Boolean;
begin
  if FMouseDownItem = nil then
    Exit;

  AAllowDrag := (FDragDropOptions.Enabled);
  if (AAllowDrag) and (Assigned(FOnCanDragItem)) then
    FOnCanDragItem(Self, FMouseDownItem, AAllowDrag);

  if (AAllowDrag) and (FActionButtons.Visible = False) then
  begin
    KillTimer(FSelectTimer);
    //FActionButtons.HideButtons(True);
    if (Root.GetObject is TCustomForm) then
    begin
      Form := TCustomForm(Root.GetObject);

      FDragDropImage                    := TksDragImage.Create(Form);
      FDragDropImage.FShadow.Enabled := FDragDropOptions.Shadow;

      FDragDropImage.Parent             := Form;
      FDragDropImage.HitTest := False;
      FDragDropImage.Width              := FMouseDownItem._FBitmap.Width / GetScreenScale;
      FDragDropImage.Height             := FMouseDownItem._FBitmap.Height  / GetScreenScale;

      FDragDropImage.Fill.Bitmap.Bitmap := FMouseDownItem._FBitmap;

      FDragDropImage.Fill.Kind          := TBrushKind.Bitmap;
      FDragDropImage.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
      FDragDropImage.Opacity            := FDragDropOptions.Opacity;

      FDragDropScrollTimer := CreateTimer(100,DoDropScroll);

      Capture;
      FDragDropImage.MouseDownOffset := PointF(FMouseDownPoint.X - FMouseDownItem.ItemRect.Left,
                                               FMouseDownPoint.Y - FMouseDownItem.ItemRect.Top + FScrollPos);
      if FDragDropImage.MouseDownOffset.Y < 8 then
        FDragDropImage.MouseDownOffset := PointF(FDragDropImage.MouseDownOffset.X, FDragDropImage.MouseDownOffset.y + 8);
      UpdateDropImage(FMouseDownPoint.X+8, FMouseDownPoint.Y+8);
      FDragging := True;
      FMouseDownItem.FDragging := True;
      FDragOverItem := nil;
    end;
  end
  else
  if (FSelectionOptions.FLongTapSelects) and (FActionButtons.Visible = False) then
    DoSelectItem;
end;

procedure TksTableView.UpdateDropImage(x, y: single);
var
  ScreenMousePos : TPointF;
  FormMousePos   : TPointF;
  AAllowDrop: Boolean;
  ADragOverItem: TksTableViewItem;
begin

  if FDragDropImage = nil then
    Exit;

  AAllowDrop := True;

  ADragOverItem := GetItemFromPos(x, y);
  if (Assigned(FOnCanDropItem)) and (ADragOverItem <> nil) then
    FOnCanDropItem(Self, FMouseDownItem, ADragOverItem, AAllowDrop);

  if FDragDropOptions.DragHighlight.Enabled then
  begin
    case AAllowDrop of
      True: FDragDropImage.AllowDropStroke := FDragDropOptions.DragHighlight.AllowDropStroke;
      False: FDragDropImage.AllowDropStroke := FDragDropOptions.DragHighlight.DisallowDropStroke;
    end;
    // add 1 to the thickness so it shows inside the existing dark gray border...
    FDragDropImage.Stroke.Thickness := FDragDropImage.Stroke.Thickness + 1;

  end
  else
    FDragDropImage.Stroke.Color := claNull;

  FDragDropImage.Fill.Bitmap.Bitmap := FMouseDownItem._FBitmap;
  FDragDropImage.Width              := FMouseDownItem._FBitmap.Width / GetScreenScale;
  FDragDropImage.Height             := FMouseDownItem._FBitmap.Height  / GetScreenScale;

  if (FDragDropImage.MouseDownOffset.X>FDragDropImage.Width) then
    FDragDropImage.MouseDownOffset := PointF((FDragDropImage.Width / 2)+8,FDragDropImage.MouseDownOffset.Y);

  if (FDragDropImage.MouseDownOffset.Y>FDragDropImage.Height) then
    FDragDropImage.MouseDownOffset := PointF(FDragDropImage.MouseDownOffset.X,(FDragDropImage.Height / 2)+8);


  ScreenMousePos := LocalToScreen(PointF(x, y));
  FormMousePos   := TForm(FDragDropImage.Parent).ScreenToClient(ScreenMousePos);
  FDragDropImage.SetBounds(FormMousePos.X - FDragDropImage.MouseDownOffset.X,
                           FormMousePos.Y - FDragDropImage.MouseDownOffset.Y + GetStartOffsetY,
                           FDragDropImage.Width, FDragDropImage.Height);
  Invalidate;
end;

procedure TksTableView.DoDropScroll;
var
  MinHeight : Single;
  MaxHeight : Single;
begin
  if (FMouseCurrentPos.Y<0) then
  begin
    FScrolling   := false;
    FScrollPos   := FScrollPos - (GetScreenScale * (0-FMouseCurrentPos.Y));
    MinHeight    := GetStartOffsetY;

    if (FScrollPos<MinHeight) then
      FScrollPos := MinHeight;

    Repaint;
  end
  else if (FMouseCurrentPos.Y>Height) then
  begin
    FScrolling := false;
    FScrollPos := FScrollPos + (GetScreenScale * (FMouseCurrentPos.Y-Height));
    MaxHeight  := Max((GetTotalItemHeight - Height) + GetStartOffsetY, 0);

    if (FScrollPos>MaxHeight) then
      FScrollPos := MaxHeight;

    Repaint;
  end;
end;

function TksTableView.GetItemFromPos(AXPos,AYPos: single): TksTableViewItem;
var
  ICount: integer;
  JCount: integer;
  AFiltered: TksTableViewItems;
  AItem: TksTableViewItem;
begin
  Result := nil;
  AFiltered := FFilteredItems;
  for ICount := 0 to AFiltered.Count - 1 do
  begin
    AItem := AFiltered[ICount];

    if (AItem.IsStickyHeader) then
    begin
      if PtInRect(RectF(0,0,AItem.ItemRect.Width,AItem.ItemRect.Height), PointF(AXPos,AYPos)) then
      begin
        Result := AItem;

        // Check for clicking on Header over Sticky Header
        for JCount := ICount+1 to AFiltered.Count - 1 do
        begin
          AItem := AFiltered[JCount];
          if (AItem.Purpose=Header) then
          begin
            if PtInRect(AItem.ItemRect, PointF(AXPos, (AYPos + FScrollPos))) then
            begin
              Result := AItem;
              Exit;
            end;
          end;
        end;
        Exit;
      end;
    end
    else
    begin
      if PtInRect(AItem.ItemRect, PointF(AXPos, (AYPos + FScrollPos))) then
      begin
        Result := AItem;
        Exit;
      end;
    end;
  end;
end;

function TksTableView.GetMouseDownBox: TRectF;
var
  pt: TPointF;
  v: single;
begin
  v := C_TABlEVIEW_SCROLL_THRESHOLD;
  pt := FMouseDownPoint;
  Result := RectF(pt.x - v, pt.y - v, pt.x + v, pt.y + v);
end;

function TksTableView.GetSearchHeight: single;
begin
  Result := 0;
  if FSearchVisible then
    Result := FSearchBox.Height;
end;

function TksTableView.GetSearchText: string;
begin
  Result := FSearchBox.Text;
end;

function TksTableView.GetFixedHeaderHeight: single;
var
  I : Integer;
begin
  if (Items.Count>0) then
  begin
    Result := 0; //Items[0].FItemRect.Top {- GetSearchHeight};
    for I:=0 to Min(FFixedRowOptions.FHeaderCount,Items.Count)-1 do
      Result := Result + Items[I].FItemRect.Height;
  end
  else
    Result := 0;
end;

function TksTableView.GetCachedCount: integer;
//var
//  ICount: integer;
begin
  {Result := 0;
  for ICount := 0 to FItems.Count-1 do
    if FItems[ICount].Cached then
      Result := Result + 1;   }
  Result := FItems.CachedCount;
end;

function TksTableView.GetFixedFooterHeight: single;
var
  ICount : Integer;
begin
  ICount := Max(0,Items.Count-FFixedRowOptions.FFooterCount);
  if (ICount<Items.Count) then
    Result := Height - Items[ICount].FItemRect.Top
  else
    Result := 0;
end;

function TksTableView.GetStartOffsetY: single;
begin
  Result := GetSearchHeight + GetFixedHeaderHeight;
end;

function TksTableView.GetSelectedItem: TksTableViewItem;
begin
  Result := nil;
  if FItemIndex > -1 then
    Result := FilteredItems[FItemIndex];
end;

function TksTableView.GetTopItem: TksTableViewItem;
var
  ICount: integer;
  AViewport: TRectF;
  AItems: TksTableViewItems;
begin
  Result := nil;
  AViewport := ViewPort;
  AItems := FFilteredItems;
  for ICount := 0 to AItems.Count - 1 do
  begin
    if AItems[ICount].IsVisible(AViewport) then
    begin
      Result := AItems[ICount];
      Exit;
    end;
  end;
end;

function TksTableView.GetTotalItemHeight: single;
begin
  Result := FFilteredItems.GetTotalItemHeight;
end;

function TksTableView.GetViewPort: TRectF;
begin
  Result := RectF(0, 0, Width, Height);
  OffsetRect(Result, 0, FScrollPos);
end;

function TksTableView.GetVisibleItems: TList<TksTableViewItem>;
var
  ICount: integer;
  ATopItem: TksTableViewItem;
  AViewport: TRectF;
begin
  Result := TList<TksTableViewItem>.Create;
  ATopItem := TopItem;
  if ATopItem = nil then
    Exit;
  AViewport := ViewPort;
  for ICount := ATopItem.Index to FItems.Count - 1 do
  begin
    if Items[ICount].IsVisible(AViewport) then
      Result.Add(Items[ICount])
    else
      Break;
  end;
end;

procedure TksTableView.HideFocusedControl;
var
  AParent: TFmxObject;
begin
  if FFocusedControl <> nil then
  begin
    FFocusedControl.HideControl;
    FFocusedControl := nil;
    AParent := Parent;
    while AParent <> nil do
    begin
      if (AParent is TForm) then
      begin
        (AParent as TForm).Focused := nil;
        Break;
      end;
      AParent := AParent.Parent;
    end;
  end;
end;

procedure TksTableView.Invalidate;
begin
  InvalidateRect(LocalRect);
end;

function TksTableView.IsHeader(AItem: TksTableViewItem): Boolean;
begin
  Result := False;
  if AItem <> nil then
    Result := AItem.Purpose = TksTableViewItemPurpose.Header;
end;

procedure TksTableView.KeyDown(var Key: Word; var KeyChar: WideChar;
  Shift: TShiftState);
begin
  inherited;
  if Key = vkUp then ScrollTo(ScrollViewPos-ItemHeight);
  if Key = vkDown then ScrollTo(ScrollViewPos+ItemHeight);
  if Key = vkHome then ScrollTo(0);
  if Key = vkEnd then ScrollTo(FMaxScrollPos);
  if Key = vkPrior then ScrollTo(ScrollViewPos-Height);
  if Key = vkNext then ScrollTo(ScrollViewPos+Height);

end;

procedure TksTableView.KillAllTimers;
begin
  KillTimer(FSelectTimer);
  KillTimer(FDeselectTimer);
end;

procedure TksTableView.KillTimer(var ATimer: TFmxHandle);
begin
  if FTimerService <> nil then
  begin
    if (ATimer<>0) then
    begin
      FTimerService.DestroyTimer(ATimer);
      ATimer := 0;
    end;
  end;
end;

procedure TksTableView.MouseDown(Button: TMouseButton; Shift: TShiftState;
  x, y: single);
//var
//  AConsumesClick: Boolean;
begin

  if (UpdateCount > 0) or (FMouseEventsEnabledCounter > 0) then
    Exit;
  y := y - GetStartOffsetY;

  inherited;
  if (FUpdateCount > 0) or (AIsSwiping) then
    Exit;

  //if (Root is TCommonCustomForm) then
  //  (Root as TCommonCustomForm).Focused := nil;
  //Capture;


  FMouseDownObject := nil;
  FMouseDown := True;

  FSwipeDirection := ksSwipeUnknown;
  FMouseDownPoint := PointF(x, y);
  FMouseCurrentPos := FMouseDownPoint;

  FAniCalc.MouseDown(x, y);

  FMouseDownItem := GetItemFromPos(x,y);
  if FMouseDownItem <> nil then
  begin

    FMouseDownObject := FMouseDownItem.ObjectAtPos(x, y + FScrollPos);

    if (FMouseDownObject <> FFocusedControl) and (FFocusedControl <> nil) then
      HideFocusedControl;

    if (FMouseDownObject <> nil) then
    begin
      //AConsumesClick := FMouseDownObject.ConsumesClick;
      FMouseDownItem.DoClick(FMouseDownPoint.x, (FMouseDownPoint.y - FMouseDownItem.ItemRect.Top) + ScrollViewPos);
      if (Assigned(FItemClickEvent)) and (FMouseDownObject.ConsumesClick = False) then
        FItemClickEvent(Self, FMouseDownPoint.X, FMouseDownPoint.Y, FMouseDownItem, FMouseDownItem.ID, FMouseDownObject);
      Exit;
      //if FMouseDownObject.ConsumesClick then
      //  Exit;
    end;

    if FMouseDownItem = nil then
      Exit;

    if (FMouseDownItem.Purpose=Header) then
    begin
      if (FMouseDownItem.IsStickyHeader) and ((FHeaderOptions.StickyHeaders.Button.Visible)) then
      begin
        if (PtInRect(FStickyButtonRect, PointF(FMouseDownPoint.x,FMouseDownPoint.y + GetStartOffsetY))) then
        begin
          FHeaderOptions.StickyHeaders.Button.DoButtonClicked(Self, FMouseDownItem);
          exit;
        end;
      end;

      if (FCheckMarkOptions.FCheckMarks <> cmNone) then
      begin
        if (FMouseDownItem.CheckMarkClicked(FMouseDownPoint.x,FMouseDownPoint.y - FMouseDownItem.ItemRect.Top + ScrollViewPos)) then
        begin
          FMouseDownItem.Checked := not FMouseDownItem.Checked;
          exit;
        end;
      end;
    end;

    if (FMouseDownItem.Purpose = None) then
    begin
      KillTimer(FSelectTimer);
      FSelectTimer := CreateTimer(200, DoSelectTimer);
    end;
  end;
end;

procedure TksTableView.MouseMove(Shift: TShiftState; x, y: single);
var
  AMouseDownRect: TRectF;
  ADragOverItem : TksTableViewItem;
  //AAllowDrop    : Boolean;
  //I             : Integer;
begin
  if (UpdateCount > 0) or (FMouseEventsEnabledCounter > 0) then
    Exit;

  y := y - GetStartOffsetY;

  FMouseCurrentPos := PointF(x, y);
  inherited;

  if FDragging then
  begin
    ADragOverItem := GetItemFromPos(x, y);

    if ADragOverItem <> FMouseDownItem then
      FDragOverItem := ADragOverItem;

    // live moving is causing index problems... need to re-work this code.


    {if (FDragDropOptions.FLiveMoving) and (ADragOverItem<>Nil) and (ADragOverItem<>FMouseDownItem) then
    begin
      for I:=FItems.IndexOf(ADragOverItem) downto 1 do
      begin
        if (Items[I].Purpose<>TksTableViewItemPurpose.Header) then
          break;
        ADragOverItem := Items[I-1];
      end;

      AAllowDrop := (ADragOverItem=Nil) or (ADragOverItem.Purpose<>TksTableViewItemPurpose.Header);
      if (Assigned(FOnCanDropItem)) then
        FOnCanDropItem(Self, FMouseDownItem, ADragOverItem, AAllowDrop);

      if (AAllowDrop) and (ADragOverItem<>Nil) then
      begin
        FMouseDownItem.Appearance := ADragOverItem.Appearance;
        FMouseDownItem.Height     := ADragOverItem.Height;

        FItems.Move(FItems.IndexOf(FMouseDownItem), FItems.IndexOf(ADragOverItem));

        UpdateAll(true);

        RedrawAllVisibleItems;
      end;
    end;  }

    UpdateDropImage(FMouseCurrentPos.X+8, FMouseCurrentPos.Y+8);
    Exit;
  end;

  AMouseDownRect := GetMouseDownBox;

  if (ssLeft in Shift) and
     (PtInRect(AMouseDownRect, PointF(x, y)) = False) and
     (FSwipeDirection = ksSwipeUnknown) then
  begin
    FScrolling := True;
    if FSwipeDirection = ksSwipeUnknown then
    begin
      KillTimer(FSelectTimer);
      FSelectTimer := 0;
      if x < AMouseDownRect.Left then FSwipeDirection := ksSwipeRightToLeft;
      if x > AMouseDownRect.Right then FSwipeDirection := ksSwipeLeftToRight;
      if y < AMouseDownRect.Top then FSwipeDirection := ksSwipeBottomToTop;
      if y > AMouseDownRect.Bottom then FSwipeDirection := ksSwipeTopToBottom;
      FAniCalc.MouseDown(x, y);
    end;
  end;
  if FSwipeDirection = ksSwipeUnknown then
    Exit;

  if (FSwipeDirection in [ksSwipeLeftToRight, ksSwipeRightToLeft]) and (FMouseDownItem <> nil) then
  begin
    if (FSwipeDirection <> TksSwipeDirection.ksSwipeUnknown) and (not FMouseDownItem.IsHeader) then
      FMouseDownItem.DoSwipe(FSwipeDirection);
    Exit;
  end;

  if FSwipeDirection in [ksSwipeTopToBottom, ksSwipeBottomToTop] then
    x := FMouseDownPoint.x;

  if (FScrolling) and (ssLeft in Shift) then
    FAniCalc.MouseMove(x, y);
end;

procedure TksTableView.MouseUp(Button: TMouseButton; Shift: TShiftState;
  x, y: single);
var
  ACanDrop: Boolean;
  AAllowMove: Boolean;
  Form: TCustomForm;
begin
  y := y - GetStartOffsetY;

  AAllowMove := True;

  if (UpdateCount > 0) or (FMouseEventsEnabledCounter > 0) then
    Exit;
  inherited;

  if (FDragging) then
  begin
    Form := TCustomForm(Root.GetObject);
    Form.RemoveObject(FDragDropImage);
    FreeAndNil(FDragDropImage);
    FDragDropImage := nil;
    KillTimer(FDragDropScrollTimer);
    ReleaseCapture;

    //ADragOverItem := GetItemFromPos(x, y);

    if (Assigned(FOnDropItem)) and (FDragOverItem <> nil) then
    begin
      ACanDrop := True;
      if Assigned(FOnCanDropItem) then
         FOnCanDropItem(Self, FMouseDownItem, FDragOverItem, ACanDrop);

      if ACanDrop then
      begin
        FOnDropItem(Self,FMouseDownItem, FDragOverItem, AAllowMove);
        if AAllowMove then
        begin
          // move the drag row to the new position...

          FItems.Move(FMouseDownItem.Index, FDragOverItem.Index);
          UpdateAll(True);
          RedrawAllVisibleItems;

        end;
      end;


    end;
    FDragging := False;
    if FMouseDownItem <> nil then
      FMouseDownItem.FDragging := False;
    Invalidate;
    Exit;
  end;

  if PtInRect(GetMouseDownBox, PointF(x,y)) then
  begin
    if FSelectTimer <> 0 then
    begin
      if (FMouseDownObject = nil) or (FMouseDownObject.ConsumesClick = False) then
        DoSelectItem;
    end;
  end;

  if FScrolling then
    FAniCalc.MouseUp(x, y);

  FAniCalc.BoundsAnimation := True;

  FMouseDown := False;

  if (FItemIndex > -1) and (FSelectionOptions.FKeepSelection = False) then
    DeselectItem(FSelectionOptions.SelectDuration);

  if (FMouseDownObject <> nil) and (FScrolling = False) then
    FMouseDownObject.MouseUp(x, y);
end;

procedure TksTableView.MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
var
  Offset: Single;
  ANewPos: single;
begin
  inherited;
  if (csDesigning in ComponentState) then
    Exit;
  if (not Handled) then
  begin
    if not (ssHorizontal in Shift) then
    begin
      HideFocusedControl;              // <------   ADD THIS LINE
      FAniCalc.UpdatePosImmediately;
      Offset := Height / 14;
      Offset := Offset * -1 * (WheelDelta / 120);
      ANewPos := Max(ScrollViewPos + Offset, 0);
      ANewPos := Min(ANewPos, (FMaxScrollPos));
      ScrollTo(Floor(ANewPos));
      Handled := True;
    end
  end;
end;

procedure TksTableView.Paint;
var
  ICount: integer;
  AItems: TksTableViewItems;
  AViewport: TRectF;
  AItem: TksTableViewItem;
  ARect: TRectF;
  ASelectedRect: TRectF;
  ATop: single;
  sh: single;
  SaveState : TCanvasSaveState;
  SaveState2 : TCanvasSaveState;
  SaveStatePullRefresh: TCanvasSaveState;
  AStickyHeaderBottom: Single;
begin
  inherited;
  if not FPainting then
  begin
    SaveState := nil;
    SaveState2 := nil;
    AStickyHeaderBottom := 0;
    FPainting := True;
    try
      sh := GetSearchHeight;

      if (sh > 0) then
      begin
        SaveState := Canvas.SaveState;
        Canvas.IntersectClipRect (RectF(0, sh, Width, Height));
      end;

      if (Assigned(OnBeforePaint)) then
        OnBeforePaint(Self,Canvas);

      if FAppearence.Background <> nil then
        Canvas.Fill.Assign(FAppearence.Background);
      Canvas.FillRect(RectF(0, 0, Width, Height), 0, 0, AllCorners, 1);
      if (csDesigning in ComponentState) and (FBorder.Showing = False) then
      begin
        DrawDesignBorder(claDimgray, claDimgray);
      end;


      if (FPullToRefresh.Enabled) and (Trunc(ScrollViewPos) < 0) then
      begin
        SaveStatePullRefresh := Canvas.SaveState;
        try
          Canvas.Stroke.Thickness := 1/(GetScreenScale*2);
          Canvas.Stroke.Color := claDimgray;

          if IsHeader(Items.FirstItem) = False then
            Canvas.DrawLine(PointF(0, (0-ScrollViewPos)+sh), PointF(Width, (0-ScrollViewPos)+sh), 1);
          Canvas.IntersectClipRect (RectF(0, 0, Width, (0-ScrollViewPos)+sh));
          // pull to refresh...
          if (FMouseDown) then
            FNeedsRefresh := (ScrollViewPos <= -50);

          Canvas.Fill.Color := FPullToRefresh.TextColor;
          Canvas.Font.Size := 16;

          if (FNeedsRefresh) and (ScrollViewPos <= -25) then
          begin
            Canvas.FillText(RectF(0, sh, Width, sh+50), FPullToRefresh.FReleaseText, False, 1, [], TTextAlign.Center);
            FNeedsRefresh := True;
          end
          else
            Canvas.FillText(RectF(0, sh+0, Width, sh+50), FPullToRefresh.FPullText, False, 1, [], TTextAlign.Center);

        finally
          Canvas.RestoreState(SaveStatePullRefresh);
        end;

      end;

      AItems := FilteredItems;
      AViewport := ViewPort;

      for ICount := 0 to Min(FFixedRowOptions.FHeaderCount,Items.Count) - 1 do
        if (Items[ICount].ItemRect.Height>0) then
          Items[ICount].Render(Canvas, GetFixedHeaderHeight);

      if (FFixedRowOptions.FHeaderCount>0) or (FFixedRowOptions.FFooterCount>0) then
      begin
        SaveState2 := Canvas.SaveState;
        Canvas.IntersectClipRect (RectF(0, GetStartOffsetY, Width, Height - GetFixedFooterHeight));
      end;

      for ICount := 0 to AItems.Count - 1 do
      begin
        AItem := AItems[ICount];

        if (AItem.IsVisible(AViewport)) then
          AItem.Render(Canvas, AViewport.Top);
      end;

      if (FHeaderOptions.StickyHeaders.Enabled) then
      begin
        for ICount := 0 to AItems.Count -1 do
        begin
          AItem := AItems[ICount];
          if (AItem.Purpose = Header) then
          begin
            if AItem.ItemRect.Top < (AViewport.Top) then
              ATop := Round(AItem.ItemRect.Top)
            else
              ATop := AViewport.Top;

            ARect := AItem.Render(Canvas, ATop);

            if (AItem.IsStickyHeader) then
            begin
              AStickyHeaderBottom := ARect.Bottom;
              if ((FHeaderOptions.StickyHeaders.Button.Visible)) then
              begin
                FStickyButtonRect := RectF(ARect.Right - ARect.Height - 4, ARect.Top, ARect.Right -4, ARect.Bottom);
                InflateRect(FStickyButtonRect, -1, -1);
                if (AItem.Accessory.Visible) and (AItem.Accessory.Accessory <> atNone)  then
                  OffsetRect(FStickyButtonRect, -32, 0);
                if (FCheckMarkOptions.FCheckMarks <> cmNone) and (FCheckMarkOptions.FPosition = cmpRight) and (AItem.FCheckmarkAllowed) then
                  OffsetRect(FStickyButtonRect, -(AItem.FCheckMarkAccessory.Width + 8) , 0);
                if (SelectionOptions.FSelectionOverlay.FEnabled) then
                  OffsetRect(FStickyButtonRect,-(SelectionOptions.FSelectionOverlay.Stroke.Thickness/2),0);
                // draw the sticky button...
                case FHeaderOptions.StickyHeaders.Button.Selected of
                  True: AccessoryImages.DrawAccessory(Canvas, FStickyButtonRect, TksAccessoryType.atArrowDown, claBlack, FAppearence.SelectedColor);
                  False: AccessoryImages.DrawAccessory(Canvas, FStickyButtonRect, TksAccessoryType.atArrowDown, claNull, claNull);
                end;
              end;
            end;
          end;
        end;
      end;

      if (FFixedRowOptions.FHeaderCount>0) or (FFixedRowOptions.FFooterCount>0) then
        Canvas.RestoreState(SaveState2);

      for ICount := Max(0,Items.Count-FFixedRowOptions.FooterCount) to Items.Count - 1 do
        if (Items[ICount].ItemRect.Height>0) then
          Items[ICount].Render(Canvas, GetFixedHeaderHeight);

      if (FSelectionOptions.SelectionOverlay.Enabled) then
      begin
        Canvas.Stroke.Assign(FSelectionOptions.SelectionOverlay.Stroke);
        case FSelectionOptions.SelectionOverlay.Position of
          ksSelectorLeft: Canvas.DrawLine(PointF(0, 0), PointF(0, Height), 1);
          ksSelectorRight: Canvas.DrawLine(PointF(Width, 0), PointF(Width, Height), 1);
        end;
        if SelectedItem <> nil then
        begin
          ASelectedRect := SelectedItem.ItemRect;
          OffsetRect(ASelectedRect, 0, (0-ScrollViewPos)+GetStartOffsetY);
          FSelectionOptions.SelectionOverlay.DrawToCanvas(Canvas, ASelectedRect, AStickyHeaderBottom,
                                                          Height-GetFixedFooterHeight);
        end;
      end;


      if (FBackgroundText.Enabled) and (AItems.Count = 0) then
      begin
        if FBackgroundText.Text <> '' then
        begin
          Canvas.Font.Assign(FBackgroundText.Font);
          Canvas.Fill.Color := FBackgroundText.TextColor;
          Canvas.Fill.Kind := TBrushKind.Solid;

          ARect := LocalRect;
          if ScrollViewPos < 0  then
            OffsetRect(ARect, 0, 0-ScrollViewPos);
          Canvas.FillText(ARect, FBackgroundText.Text, False, 1, [], TTextAlign.Center);
        end;
      end;

      if (Assigned(OnAfterPaint)) then
        OnAfterPaint(Self,Canvas);

      if (sh>0) then
        Canvas.RestoreState(SaveState);

      if FBorder.Showing then
      begin
        Canvas.Stroke.Assign(FBorder.Stroke);
        Canvas.DrawRectSides(RectF(0, 0, Width, Height), 0, 0, AllCorners, 1, FBorder.Sides);
      end;

    finally
      FPainting := False;
    end;
  end;
end;

procedure TksTableView.RedrawAllVisibleItems;
var
  AList: TList<TksTableViewItem>;
  ICount: integer;
begin
  AList := GetVisibleItems;
  try
    for ICount := 0 to Items.Count-1 do
      Items[ICount].FCached := False;
    for ICount := 0 to AList.Count-1 do
      AList[ICount].CacheItem(True);
    Invalidate;
  finally
    AList.Free;
  end;
end;

procedure TksTableView.ClearCache(AClearType: TksClearCacheType);
var
  ICount: integer;
  AVisible: TList<TksTableViewItem>;
begin
  if AClearType = ksClearCacheAll then
  begin
    for ICount := 0 to Items.Count-1 do
      Items[ICount].ClearCache;
  end
  else
  begin
    if FItems.Count <= C_TABLEVIEW_PAGE_SIZE then
      Exit;
    AVisible := VisibleItems;
    try
      for ICount := 0 to Items.Count-1 do
        if AVisible.IndexOf(Items[ICount]) = -1 then
          Items[ICount].ClearCache;
    finally
      AVisible.Free;
    end;
  end;
end;

procedure TksTableView.CheckChildren(AHeader: TksTableViewItem ; Value : Boolean);
var
  I,J : Integer;
  AItem: TksTableViewItem;
begin
  for I := 0 to FilteredItems.Count-1 do
  begin
    AItem := FilteredItems[I];

    if (AItem=AHeader) then
    begin
      for J:=I+1 to FilteredItems.Count-1 do
      begin
        AItem := FilteredItems[J];

        if (AItem.Purpose=Header) then
          break;

        AItem.Checked := Value;
      end;
      break;
    end;
  end;
end;

procedure TksTableView.UncheckHeader(AChild: TksTableViewItem);
var
  AIndex: integer;
  ICount: integer;
begin
  AIndex := FilteredItems.IndexOf(AChild);

  for ICount := AIndex downto 0 do
  begin
    if FilteredItems[ICount].Purpose = Header then
    begin
      FilteredItems[ICount].Checked := False;
      FilteredItems[ICount].CacheItem(True);
      Invalidate;
      Exit;
    end;
  end;
end;

procedure TksTableView.BringSelectedIntoView;
begin
  ScrollToItem(SelectedItem);
end;

procedure TksTableView.ScrollToItem(AItem: TksTableViewItem; const AAnimate: Boolean = False);
var
  AMinHeight        : Single;
  AMaxHeight        : Single;
  ANewScrollViewPos : Single;
begin
  if AItem = nil then
    Exit;

  FAniCalc.UpdatePosImmediately;
  //CreateAniCalculator(False);

  ANewScrollViewPos := FScrollPos;
  AMinHeight := 0;
  if (FStickyHeader <> nil) then
    AMinHeight := FStickyHeader.FHeaderHeight;

  if (AItem.ItemRect.Top - ANewScrollViewPos < AMinHeight) then
    ANewScrollViewPos := AItem.ItemRect.Top - AMinHeight;

  AMaxHeight := Height - GetFixedFooterHeight - GetFixedHeaderHeight;
  if (AItem.ItemRect.Bottom - ANewScrollViewPos > AMaxHeight) then
    ANewScrollViewPos := AItem.ItemRect.Bottom - AMaxHeight;


  if (ANewScrollViewPos <> FScrollPos) then
    SetScrollViewPos(ANewScrollViewPos, AAnimate);
  UpdateScrollingLimits;
end;


procedure TksTableView.ResetIndicatorWidths;
var
  ICount: integer;
begin
  BeginUpdate;
  try
    for Icount := 0 to Items.Count-1 do
    begin
      if Items[ICount].FIndicator.Width <> RowIndicators.Width then
      begin
        Items[ICount].FIndicator.Width := RowIndicators.Width;
        Items[ICount].FForegroundColor := claNull;
        Items[ICount].FCached := False;
      end;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TksTableView.Resize;
begin
  inherited;
  if FItems.Count = 0  then
    Exit;


  if FUpdateCount > 0 then
    Exit;

  HideFocusedControl;
  UpdateItemRects(False);
  UpdateScrollingLimits;
  ClearCache(ksClearCacheAll);

  if (FSelectionOptions.FKeepSelectedInView) then
    BringSelectedIntoView;
end;

{$IFDEF XE10_OR_NEWER}

procedure TksTableView.VisibleChanged;
begin
  inherited;
  ClearCache(ksClearCacheAll);
end;

{$ENDIF}

procedure TksTableView.SearchSetFocus;
begin
  if FSearchVisible then
    FSearchBox.SetFocus;
end;

procedure TksTableView.SelectDate(ARow: TksTableViewItem; ASelected: TDateTime; AOnSelectDate: TNotifyEvent);
begin
  if FDateSelector = nil then
  begin
    FDateSelector := TDateEdit.Create(nil);
    FDateSelector.OnClosePicker := ComboClosePopup;
  end;
  FDateSelector.Position.X := ARow.ItemRect.Right - 100;
  FDateSelector.Position.Y := ARow.ItemRect.Top;
  FDateSelector.OnChange := nil;
  FDateSelector.TagObject := ARow;
  FDateSelector.Width := 0;
  {$IFDEF MSWINDOWS}
  FDateSelector.Width := 200;
  {$ENDIF}
  AddObject(FDateSelector);
  FDateSelector.Date := ASelected;
  FDateSelector.OnChange := AOnSelectDate;
  FDateSelector.OpenPicker;
end;

procedure TksTableView.SelectItem(ARow: TksTableViewItem; AItems: TStrings; ASelected: string; AOnSelectItem: TNotifyEvent);
begin
  //if FCombo <> nil then
  //  FCombo.DisposeOf;
  if FCombo = nil then
  begin
    FCombo := TComboBox.Create(nil);
    FCombo.OnClosePopup := ComboClosePopup;
    FCombo.Visible := False;
    AddObject(FCombo);
  end;

  FCombo.OnChange := nil;
  //FCombo.Position.X := ARow.ItemRect.Right - 100;
  FCombo.Position.Y := ARow.ItemRect.Top;


  FCombo.TagObject := ARow;
  FCombo.Items.Assign(AItems);

  FCombo.ItemIndex := AItems.IndexOf(ASelected);
  FCombo.Width := 0;
  {$IFDEF MSWINDOWS}
  FCombo.Width := 200;
  {$ENDIF}
  FCombo.OnChange := AOnSelectItem;
  FCombo.DropDown;
end;

procedure TksTableView.SetAccessoryOptions(const Value: TksTableViewAccessoryOptions);
begin
  FAccessoryOptions.Assign(Value);
end;

procedure TksTableView.SetAppearence(const Value: TksTableViewAppearence);
begin
  FAppearence.Assign(Value);
end;

procedure TksTableView.SetBackgroundText(const Value: TksTableViewBackgroundText);
begin
  BackgroundText.Assign(Value);
end;

procedure TksTableView.SetBorder(const Value: TksTableViewBorderOptions);
begin
  FBorder.Assign(Value);
end;

procedure TksTableView.SetFixedRowOptions(const Value: TksTableViewFixedRowsOptions);
begin
  FFixedRowOptions.Assign(Value);
end;

procedure TksTableView.SetCheckMarkOptions(const Value: TksTableViewCheckMarkOptions);
begin
  FCheckMarkOptions.Assign(Value);
end;

procedure TksTableView.SetFullWidthSeparator(const Value: Boolean);
begin
  FFullWidthSeparator := Value;
  Invalidate;
end;

procedure TksTableView.SetHeaderOptions(const Value: TksTableViewItemHeaderOptions);
begin
  FHeaderOptions.Assign(Value);
end;

procedure TksTableView.SetItemImageSize(const Value: integer);
begin
  FItemImageSize := Value;
end;

procedure TksTableView.SetItemIndex(const Value: integer);
var
  ASelected: TksTableViewItem;
  ANewSelected: TksTableViewItem;
begin
  if (Value < 0) or (Value > Items.Count-1) then
    Exit;
  if Value <> FItemIndex then
  begin
    ASelected := SelectedItem;
    FItemIndex := Value;
    ANewSelected := SelectedItem;

    if (FSelectionOptions.KeepSelectedInView) then
      BringSelectedIntoView;

    if FSelectionOptions.ShowSelection then
    begin
      if ASelected <> nil then
      begin
        ASelected.CacheItem(True);
      end;
      if ANewSelected <> nil then
        ANewSelected.CacheItem(True);
    end;
    Invalidate;
    ProcessMessages;
    if FMouseDown = False then
    begin
      if (FSelectionOptions.KeepSelection = False) and  (FItemIndex > -1) then
        DeselectItem(250);
    end;
  end;
end;

procedure TksTableView.SetColCount(const Value: integer);
begin
  if FColCount <> Value then
  begin
    FColCount := Value;
    ClearCache(ksClearCacheAll);
    UpdateAll(False);
    Invalidate;
  end;
end;

procedure TksTableView.SetKsItemHeight(const Value: integer);
begin
  FItemHeight := Value;
end;

procedure TksTableView.SetPullToRefresh(const Value: TksTableViewPullToRefresh);
begin
  if Value <> nil then
    FPullToRefresh.Assign(Value);
end;


procedure TksTableView.UpdateStickyHeaders;
var
  ICount: integer;
  AItem: TksTableViewItem;
  ANextStickyHeaderHeight: single;
  ANeedsRecalc: Boolean;
  AViewportTop: single;
  ALastStickyHeader: TksTableViewItem;
begin
  if FUpdateCount > 0 then
    Exit;

  if (FHeaderOptions.StickyHeaders.Enabled) and
     (FHeaderOptions.StickyHeaders.StickyHeight > 0) and
     (FilteredItems.Count > 0) then
  begin
    ANeedsRecalc      := false;
    AViewportTop      := Viewport.Top;
    ALastStickyHeader := FStickyHeader;
    FStickyHeader     := Nil;

    if (AViewportTop<0) then
      AViewportTop := 0;

    for ICount := 0 to FilteredItems.Count-1 do
    begin
      AItem := FilteredItems[ICount];
      if (AItem.Purpose = Header) then
      begin
        AItem.FIsStickyHeader := AItem.ItemRect.Top <= AViewportTop;
        if (AItem.FIsStickyHeader) then
        begin
          // is sticky header...
          FStickyHeader := AItem;
          if (AItem.FHeaderHeight <> FHeaderOptions.StickyHeaders.StickyHeight) then
          begin
            AItem.FHeaderHeight := FHeaderOptions.StickyHeaders.StickyHeight;
            ANeedsRecalc := true;
          end;
        end
        else if (AItem.ItemRect.Top <= (AViewportTop+FHeaderOptions.StickyHeaders.StickyHeight)) then
        begin
          ANextStickyHeaderHeight := Max(AItem.Height,(AViewportTop+FHeaderOptions.StickyHeaders.StickyHeight) - AItem.ItemRect.Top);
          if (AItem.FHeaderHeight <> ANextStickyHeaderHeight) then
          begin
            AItem.FHeaderHeight := ANextStickyHeaderHeight;
            ANeedsRecalc := true;
          end;
        end
        else
        begin
          if (AItem.FHeaderHeight<>0) then
          begin
            AItem.FHeaderHeight := 0;
            ANeedsRecalc := true;
          end;
        end;
      end;
    end;

    if (ANeedsRecalc) then
    begin
      UpdateItemRects(False);
      UpdateScrollingLimits;
    end;

    if (Assigned(FOnStickyHeaderChange)) and (ALastStickyHeader<>FStickyHeader) then
      FOnStickyHeaderChange(Self,ALastStickyHeader,FStickyHeader);
  end;
end;

procedure TksTableView.SetScrollViewPos(const Value: single; const AAnimate: Boolean = False);
var
  ICount: integer;
  AStep: single;
begin
  if not SameValue(FScrollPos, Value, TEpsilon.Vector) then
  begin
    HideFocusedControl;
    FActionButtons.HideButtons;

    if CachedCount > C_TABLEVIEW_PAGE_SIZE then
      ClearCache(ksClearCacheNonVisible);

    AStep := (Value - FScrollPos) / 20;
    if AAnimate then
    begin
      for ICount :=  1 to 20 do
      begin
        FScrollPos := FScrollPos + AStep;
        UpdateStickyHeaders;
        Invalidate;
        {$IFDEF MSWINDOWS}
        Sleep(5);
        {$ENDIF}
        ProcessMessages;
      end;
    end
    else
    begin
      FScrollPos := Value;
      UpdateStickyHeaders;
      //IRepaint;
      Invalidate;
    end;
    if (Round(FScrollPos) = 0) and (FNeedsRefresh) then
    begin
      ProcessMessages;
      FNeedsRefresh := False;
      DisableMouseEvents;
      DoPullToRefresh;
      FAniCalc.UpdatePosImmediately;
      EnableMouseEvents;
    end;
    if Assigned(FOnScrollViewChange) then
      FOnScrollViewChange(Self, FScrollPos, FMaxScrollPos);
  end;
end;

procedure TksTableView.ScrollTo(const Value: single);
var
  ANewValue: single;
begin
  ANewValue := Value;
  if ANewValue < 0 then ANewValue := 0;
  if ANewValue > FMaxScrollPos then ANewValue := FMaxScrollPos;
  if ((ANewValue-Height) < FMaxScrollPos) and (ANewValue >= 0) then
  begin
    FScrollPos := ANewValue;
    SetScrollViewPos(ANewValue);
    UpdateScrollingLimits;
    Invalidate;
  end;
end;


procedure TksTableView.ScrollToItem(AItemIndex: integer);
begin
  if (AItemIndex > -1) and (AItemIndex < FFilteredItems.Count) then
    ScrollToItem(FFilteredItems.Items[AItemIndex]);
end;

procedure TksTableView.SetSearchText(const Value: string);
begin
  FSearchBox.Text := Value;
end;

procedure TksTableView.SetSearchVisible(const Value: Boolean);
var
  AScrollPos: single;
begin
  if Value <> FSearchVisible then
  begin
    AScrollPos := ScrollViewPos;
    FSearchVisible := Value;
    FSearchBox.Visible := FSearchVisible;
    UpdateScrollingLimits;
    TAnimator.AnimateFloatWait(Self, 'ScrollPos', AScrollPos);

    UpdateItemRects(True);
    Invalidate;
  end;
end;

procedure TksTableView.SetSelectionOptions(const Value: TksTableViewSelectionOptions);
begin
  FSelectionOptions.Assign(Value);
end;

procedure TksTableView.SetTextDefaults(const Value: TksTableViewTextDefaults);
begin
  FTextDefaults.Assign(Value);
end;

// ------------------------------------------------------------------------------

{ TksTableViewBackgroundText }

constructor TksTableViewBackgroundText.Create;
begin
  inherited Create;
  FFont := TFont.Create;
  FFont.Size := 18;
  FTextColor := claSilver;
  FText := '';
  FEnabled := True;

end;

destructor TksTableViewBackgroundText.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

procedure TksTableViewBackgroundText.Assign(ASource: TPersistent);
var
  Src : TksTableViewBackgroundText;
begin
  if (ASource is TksTableViewBackgroundText) then
  begin
    Src := TksTableViewBackgroundText(ASource);

    FFont.Assign(Src.FFont);
    FTextColor := Src.FTextColor;
    FText      := Src.FText;
    FEnabled   := Src.FEnabled;
  end
  else
    inherited;
end;

procedure TksTableViewBackgroundText.SetFont(const Value: TFont);
begin
  FFont.Assign(FFont);
end;

procedure TksTableViewBackgroundText.SetText(const Value: string);
begin
  FText := Value;
end;

procedure TksTableViewBackgroundText.SetTextColor(const Value: TAlphaColor);
begin
  FTextColor := Value;
end;

procedure TksTableViewBackgroundText.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

// ------------------------------------------------------------------------------

{ TksTableViewBaseItemShape }

constructor TksTableViewBaseItemShape.Create(ATableItem: TksTableViewItem);
begin
  inherited;
  FFill := TBrush.Create(TBrushKind.Solid, claWhite);
  FStroke := TStrokeBrush.Create(TBrushKind.Solid, claBlack);
  FCornerRadius := 0;
  FShape := ksRectangle;
end;

destructor TksTableViewBaseItemShape.Destroy;
begin
  FreeAndNil(FFill);
  FreeAndNil(FStroke);
  inherited;
end;

procedure TksTableViewBaseItemShape.Render(AItemRect: TRectF; ACanvas: TCanvas);
var
  ARect: TRectF;
  AShadowWidth: single;
  ABmp: TBitmap;
begin
  inherited;
  if (Width = 0) or (Height = 0) then
    Exit;

  ABmp := TBitmap.Create;
  try
    AShadowWidth := 0;

    if (FTableItem.FTableView.RowIndicators.Shadow) and (Self = FTableItem.FIndicator) then
      AShadowWidth := 2;

    ABmp.SetSize(Round(Width * GetScreenScale), Round(Height * GetScreenScale));
    //ABmp.BitmapScale := GetScreenScale;


    ABmp.Clear(claNull);
    ABmp.Canvas.BeginScene;
    try
      ARect := RectF(0, 0, (ABmp.Width {/ GetScreenScale}) - AShadowWidth, (ABmp.Height {/ GetScreenScale}) - AShadowWidth);

      if AShadowWidth > 0 then
      begin
        OffsetRect(ARect, AShadowWidth, AShadowWidth);
        ABmp.Canvas.Fill.Color := claDimgray;
        if FShape = ksEllipse then
          ABmp.Canvas.FillEllipse(ARect, 1)
        else
          ABmp.Canvas.FillRect(ARect, FCornerRadius, FCornerRadius, AllCorners, 1);
        OffsetRect(ARect, 0-AShadowWidth, 0-AShadowWidth);
      end;
      ABmp.Canvas.Fill.Assign(FFill);
      ABmp.Canvas.Stroke.Assign(FStroke);
      ABmp.Canvas.StrokeThickness := 1;
      FFill.Color := FFill.Color;
      if FShape in [ksRectangle, ksRoundRect, ksSquare] then
      begin
        if FFill.Color <> claNull  then
          ABmp.Canvas.FillRect(ARect, FCornerRadius, FCornerRadius, AllCorners, 1);

        ABmp.Canvas.DrawRect(ARect, FCornerRadius, FCornerRadius, AllCorners, 1);
      end;
      if FShape = ksEllipse then
      begin
        if FFill.Color <> claNull  then
          ABmp.Canvas.FillEllipse(ARect, 1);
        ABmp.Canvas.DrawEllipse(ARect, 1);
      end;
    finally
      ABmp.Canvas.EndScene;
    end;
    ACanvas.DrawBitmap(ABmp, RectF(0, 0, ABmp.Width, ABmp.Height), ObjectRect, 1, False);
    ACanvas.Stroke.Color := clablack;
  finally
    ABmp.Free;
  end;
  inherited;
end;

procedure TksTableViewBaseItemShape.SetCornerRadius(const Value: single);
begin
  FCornerRadius := Value;
end;

procedure TksTableViewBaseItemShape.SetFill(const Value: TBrush);
begin
  FFill.Assign(Value);
end;

procedure TksTableViewBaseItemShape.SetShape(const Value: TksTableViewShape);
begin
  FShape := Value;
  if FShape = ksSquare then
  begin
    if FWidth <> FHeight then
      FHeight := FWidth;
  end;
end;

procedure TksTableViewBaseItemShape.SetStroke(const Value: TStrokeBrush);
begin
  FStroke.Assign(Value);
end;

// ------------------------------------------------------------------------------

{ TksTableViewItemTileBackground }

constructor TksTableViewItemTileBackground.Create(ATableItem: TksTableViewItem);
begin
  inherited;
  FPadding := TBounds.Create(RectF(5,5,5,5));
  CornerRadius := 5;
  Width := 0;
  Height := 0;
  Margins.Left := 5;
  Margins.Top := 5;
  Margins.Right := 5;
  Margins.Bottom := 5;
end;

destructor TksTableViewItemTileBackground.Destroy;
begin
  FreeAndNil(FPadding);
  inherited;
end;

procedure TksTableViewItemTileBackground.Assign(ASource: TksTableViewItemTileBackground);
begin
  FPadding.Assign(ASource.FPadding);
end;


// ------------------------------------------------------------------------------

{ TksListViewRowIndicators }

procedure TksListViewRowIndicators.Changed;
begin
  FTableView.ClearCache(ksClearCacheAll);
  FTableView.Invalidate;
end;

constructor TksListViewRowIndicators.Create(ATableView: TksTableView);
begin
  FTableView := ATableView;
  FWidth := C_TABLEVIEW_DEFAULT_INDICATOR_WIDTH;
  FHeight := C_TABLEVIEW_DEFAULT_INDICATOR_HEIGHT;
  FVisible := False;
  FShape := TksTableViewShape.ksRectangle;
  FOutlined := True;
  FShadow := True;
  FSelectRow := False;
  FAlignment := ksRowIndicatorLeft;
end;

// ------------------------------------------------------------------------------

procedure TksListViewRowIndicators.SetAlignment(const Value: TksTableViewRowIndicatorAlign);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    FTableView.ClearCache(ksClearCacheAll);
    FTableView.Invalidate;
  end;
end;

procedure TksListViewRowIndicators.SetSelectRow(const Value: Boolean);
begin
  if FSelectRow <> Value then
  begin
    FSelectRow := Value;
    if Value = False then
      FTableView.ResetIndicatorWidths;
    Changed;
  end;
end;

procedure TksListViewRowIndicators.SetShadow(const Value: Boolean);
begin
  if FShadow <> Value then
  begin
    FShadow := Value;
    FTableView.ClearCache(ksClearCacheAll);
    FTableView.Invalidate;
  end;
end;

procedure TksListViewRowIndicators.SetShape(const Value: TksTableViewShape);
begin
  if FShape <> Value then
  begin
    FShape := Value;
    if FShape = ksRectangle then
    begin
      FHeight := 0;
      FWidth := 8;
    end;
    if (FShape = ksSquare) or (FShape = ksEllipse) then
    begin
      FWidth := 16;
      FHeight := 16;
    end;
    Changed;
  end;
end;

{ TksTableViewActionButtons }

function TksTableViewActionButtons.AddButton(AText: string; AColor, ATextColor: TAlphaColor;
  const AIcon: TksAccessoryType = atNone; const AWidth: integer = 60): TksTableViewActionButton;
begin
  Result := TksTableViewActionButton.Create(False);
  Result.Text := AText;
  Result.Color := AColor;
  Result.Width := AWidth;
  Result.Accessory := AIcon;
  Result.TextColor := ATextColor;
  Add(Result);
end;

function TksTableViewActionButtons.AddDeleteButton: TksTableViewActionButton;
var
  ADelBtn: TksDeleteButton;
  AAcc: TksAccessoryType;
begin
  Result := nil;
  AAcc := atNone;
  ADelBtn := FTableView.DeleteButton;
  if ADelBtn.Enabled = False then
    Exit;
  if ADelBtn.ShowImage then
    AAcc := atTrash;
  if FTableView.DeleteButton.ShowText = False then
    ADelBtn.Text := '';

  Result := AddButton(ADelBtn.Text,
                      ADelBtn.Color,
                      ADelBtn.TextColor,
                      AAcc);
  Result.IsDeleteButton := True;
end;

function TksTableViewActionButtons.ButtonFromXY(x, y: single): TksTableViewActionButton;
var
  ARect: TRectF;
  ICount: integer;
  XPos: single;
begin
  Result := nil;
  ARect := RectF(0, 0, TotalWidth, FTableItem.Height);
  if FAlignment = TksTableViewActionButtonAlignment.abRightActionButtons then
    x := x - (FTableItem.ItemRect.Width -  TotalWidth);
  XPos := 0;
  for ICount := 0 to Count-1 do
  begin
    if (x >= XPos) and (x <= XPos+Items[ICount].Width) then
    begin
      Result := Items[ICount];
      Exit;
    end;
    XPos := XPos + Items[Icount].Width;
  end;
end;

constructor TksTableViewActionButtons.Create(AOwner: TksTableView);
begin
  inherited Create(True);
  FTableView := AOwner;
  FAlignment := abRightActionButtons;
  FPercentWidth := 0;
  FAnimating := False;
end;

function TksTableViewActionButtons.GetVisible: Boolean;
begin
  Result := FPercentWidth > 0;
end;

procedure TksTableViewActionButtons.HideButtons;
var
  ICount: integer;
begin
  //Exit;
  if (Visible = False) or (Count = 0) then
    Exit;
  if FAnimating then
    Exit;

  FAnimating := True;
  try
    for ICount := 100 downto 0 do
    begin
      FPercentWidth := ICount;
      FTableView.Invalidate;
      {$IFDEF NEXTGEN}
      if ICount mod 10 = 0 then
        ProcessMessages;
      {$ELSE}
      if ICount mod 2 = 0 then
        ProcessMessages;
      {$ENDIF}
    end;
  finally
    FAnimating := False;
    FTableItem := nil;
  end;
end;

procedure TksTableViewActionButtons.Render(ACanvas: TCanvas; ARect: TRectF);
var
  ICount: integer;
  AXPos: single;
  ABtnRect: TRectF;
  AScale: single;
begin
  AXPos := ARect.Left;
  AScale := ARect.Width / TotalWidth;

  for ICount := 0 to Count-1 do
  begin
    ABtnRect := RectF(AXPos, ARect.Top, AXPos+(Items[ICount].Width * AScale), ARect.Bottom);

    Items[ICount].Render(ACanvas, ABtnRect);//  AXPos, ARect.);
    AXPos := AXPos + (Items[ICount].Width * AScale);

  end;
end;

procedure TksTableViewActionButtons.SetPercentWidth(const Value: integer);
begin
  if PercentWidth <> Value then
  begin
    FPercentWidth := Value;
    FTableItem.FTableView.Invalidate;
    ProcessMessages;
  end;
end;

procedure TksTableViewActionButtons.ShowButtons(AItem: TksTableViewItem);
var
  ICount: integer;
begin
  if (FAnimating) or (Count = 0) then
    Exit;

  FTableItem := AItem;
  FTableView.DisableMouseEvents;
  FTableView.HideFocusedControl;
  FAnimating := True;
  try
    for ICount := 1 to 100 do
    begin
      FPercentWidth := ICount;
      FTableView.Invalidate;

      {$IFDEF NEXTGEN}
      if ICount mod 7 = 0 then
        ProcessMessages;
      {$ELSE}
      ProcessMessages;
      {$ENDIF}
    end;
    ProcessMessages;
  finally
    FAnimating := False;
    FTableView.FMouseDownItem := nil;
    FTableView.EnableMouseEvents;
  end;
end;



function TksTableViewActionButtons.TotalWidth: integer;
var
  ICount: integer;
begin
  Result := 0;
  for ICount := 0 to Count-1 do
    Result := Result + Items[Icount].Width;
end;

// ------------------------------------------------------------------------------

{ TksTableViewActionButton }

constructor TksTableViewActionButton.Create(AIsDelete: Boolean);
begin
  FWidth := 80;
  FTextColor := claWhite;
  FIsDeleteButton := AIsDelete;
end;

// ------------------------------------------------------------------------------

destructor TksTableViewActionButton.Destroy;
begin
  FreeAndNil(FIcon);
  inherited;
end;

procedure TksTableViewActionButton.Render(ACanvas: TCanvas; ARect: TRectF);
var
  ATextRect: TRectF;
  AIconRect: TRectF;
  AClipRect: TRectF;
  AState: TCanvasSaveState;
begin
  AState := ACanvas.SaveState;
  try

    ATextRect := ARect;
    AIconRect := ARect;
    ARect.Right := ARect.Right +1;
    ACanvas.Fill.Color := Color;
    ACanvas.FillRect(ARect, 0, 0, AllCorners, 1);
    ACanvas.Font.Size := 14;
    ACanvas.Fill.Color := TextColor;

    AClipRect := ARect;
    InflateRect(AClipRect, -2, -2);
    ACanvas.IntersectClipRect(AClipRect);

    if FAccessory <> atNone then
    begin
      if FIcon = nil then
      begin
        FIcon := TksTableViewAccessoryImage.Create;
        FIcon.Assign(AccessoryImages.GetAccessoryImage(FAccessory));
        (FIcon as TksTableViewAccessoryImage).Color := FTextColor;
      end;

      if (Text <> '')then
      begin
        AIconRect.Bottom := AIconRect.CenterPoint.Y;
        AIconRect.Top := AIconRect.Bottom - 28;
      end;
      ATextRect.Top := ATextRect.CenterPoint.Y;
      ATextRect.Bottom := ATextRect.CenterPoint.Y;
      OffsetRect(ATextRect, 0, 4);

      (FIcon as TksTableViewAccessoryImage).DrawToCanvas(ACanvas, AIconRect, False);
    end;
    ACanvas.FillText(ATextRect, Text, False, 1, [], TTextAlign.Center);

    if Trunc(ARect.Width) = 0 then
      FreeAndNil(FIcon);
  finally
    ACanvas.RestoreState(AState);
  end;
end;

procedure TksTableViewActionButton.SetAccessory(const Value: TksAccessoryType);
begin
  if FAccessory <> Value then
    FAccessory := Value;
end;

{ TksDeleteButton }

constructor TksDeleteButton.Create;
begin
  inherited;
  FEnabled := False;
  FText := 'Delete';
  FColor := claRed;
  FTextColor := claWhite;
  FWidth := 60;
  FShowImage := True;
  FShowText := True;
end;

// ------------------------------------------------------------------------------

{ TksTableViewTextDefaults }

constructor TksTableViewTextDefaults.Create;
begin
  FTitle := TksTableViewTextDefault.Create;
  FSubtitle := TksTableViewTextDefault.Create;
  FDetail := TksTableViewTextDefault.Create;
  FHeader := TksTableViewTextDefault.Create;

  FSubtitle.TextColor := claDimgray;
  FDetail.TextColor := claDodgerblue;
end;

destructor TksTableViewTextDefaults.Destroy;
begin
  FreeAndNil(FTitle);
  FreeAndNil(FSubtitle);
  FreeAndNil(FDetail);
  FreeAndNil(FHeader);
  inherited;
end;

procedure TksTableViewTextDefaults.SetDetail(const Value: TksTableViewTextDefault);
begin
  FDetail.Assign(Value);
end;

procedure TksTableViewTextDefaults.SetHeader(const Value: TksTableViewTextDefault);
begin
  FHeader.Assign(Value);
end;

procedure TksTableViewTextDefaults.SetSubTitle(const Value: TksTableViewTextDefault);
begin
  FSubtitle.Assign(Value);
end;

procedure TksTableViewTextDefaults.SetTitle(const Value: TksTableViewTextDefault);
begin
  FTitle.Assign(Value);
end;


// ------------------------------------------------------------------------------

{ TksTableViewTextDefault }

procedure TksTableViewTextDefault.Assign(ASource: TPersistent);
var
  Src : TksTableViewTextDefault;
begin
  if (ASource is TksTableViewTextDefault) then
  begin
    Src := TksTableViewTextDefault(ASource);

    FFont.Assign(Src.Font);
    FTextColor := Src.TextColor;
  end
  else
    inherited;
end;

constructor TksTableViewTextDefault.Create;
begin
  inherited Create;
  FFont := TFont.Create;
  FFont.Size := C_TABLEVIEW_DEFAULT_FONT_SIZE;
  FTextColor := claBlack;
end;

destructor TksTableViewTextDefault.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

procedure TksTableViewTextDefault.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TksTableViewTextDefault.SetTextColor(const Value: TAlphaColor);
begin
  FTextColor := Value;
end;

// ------------------------------------------------------------------------------

{ TksTableViewShadow }

procedure TksTableViewShadow.Assign(ASource: TPersistent);
var
  ASrc: TksTableViewShadow;
begin
  if (ASource is TksTableViewShadow) then
  begin
    ASrc := (ASource as TksTableViewShadow);

    Visible := ASrc.Visible;
    Color := ASrc.Color;
    Offset := ASrc.Offset;
  end
  else
    inherited;
end;

constructor TksTableViewShadow.Create;
begin
  FOffset := 2;
  FColor := claSilver;
  FVisible := True;
end;

procedure TksTableViewShadow.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

// ------------------------------------------------------------------------------

{ TksListItemRowTableCell }

procedure TksListItemRowTableCell.Changed;
begin
  // need to implement.
end;

constructor TksListItemRowTableCell.Create(ATable: TksTableViewItemTable);
begin
  inherited Create;
  FTable := ATable;
  FTextSettings := TTextSettings.Create(nil);
  FFill := TBrush.Create(TBrushKind.Solid, claWhite);
  FStroke := TStrokeBrush.Create(TBrushKind.Solid, claBlack);
  FPadding := TBounds.Create(RectF(0, 0, 0, 0));
  FTextSettings.FontColor := claBlack;
  FTextSettings.Font.Family := 'Arial';
  FTextSettings.HorzAlign := TTextAlign.Center;
  FTextSettings.VertAlign := TTextAlign.Center;
  FTextSettings.Font.Size := 12;
  FSides := AllSides;
  FVisible := True;
  {$IFDEF DEBUG}
  FText := 'CELL';
  {$ENDIF}
end;

destructor TksListItemRowTableCell.Destroy;
begin
  FreeAndNil(FTextSettings);
  FreeAndNil(FFill);
  FreeAndNil(FStroke);
  FreeAndNil(FPadding);
  inherited;
end;

procedure TksListItemRowTableCell.DrawToCanvas(x, y: single; ACanvas: TCanvas; ACol, ARow: integer; AShadow: TksTableViewShadow; AText: Boolean);
var
  s: single;
  ARect: TRectF;
  ATextRect: TRectF;
  AXShift: single;
  AYShift: single;
  AShadowRect: TRectF;
  ASide: TSide;
begin
  if not FVisible then
    Exit;
  s := GetScreenScale;
  if s < 2 then
    s := 2;

  with ACanvas do
  begin
    Stroke.Color := claBlack;
    Stroke.Thickness := (FStroke.Thickness * s)/2;
    AXShift := 0;
    AYShift := 0;
    if ACol = 0 then AXShift := 1*s;
    if ARow = 0 then AYShift := 1*s;
    ARect := RectF(x*s, y*s, (x+FWidth)*s, (y+FHeight)*s);

    if AText = False then
    begin
      if AShadow.Visible then
      begin
        // bottom shadow...
        AShadowRect := RectF(ARect.Left, ARect.Bottom, ARect.Right, ARect.Bottom+(AShadow.Offset*s));
        ACanvas.Fill.Color := AShadow.Color;
        OffsetRect(AShadowRect, AShadow.Offset*s, 0);
        ACanvas.FillRect(AShadowRect, 0, 0, AllCorners, 1);
        // right shadow...
        AShadowRect := RectF(ARect.Right, ARect.Top, ARect.Right+(AShadow.Offset*s), ARect.Bottom);
        ACanvas.Fill.Color := AShadow.Color;
        OffsetRect(AShadowRect, 0, AShadow.Offset*s);
        ACanvas.FillRect(AShadowRect, 0, 0, AllCorners, 1);
      end;

      if IsFixedCell then
        ACanvas.Fill.Color := GetColorOrDefault(FFill.Color, FTable.FixCellColor)
      else
      begin
        ACanvas.Fill.Color := GetColorOrDefault(FFill.Color, claWhite);
        if FTable.Banding.Active then
        begin
          case FRow mod 2 of
            0: ACanvas.Fill.Color := GetColorOrDefault(FTable.Banding.Color1, claWhite);
            1: ACanvas.Fill.Color := GetColorOrDefault(FTable.Banding.Color2, claWhite);
          end;
        end;
      end;
      ACanvas.Fill.Kind := FFill.Kind;
      ACanvas.FillRect(RectF(ARect.Left+AXShift, ARect.Top+AYShift, ARect.Right, ARect.Bottom), 0, 0, AllCorners, 1);

      ACanvas.Stroke.Color :=  GetColorOrDefault(FStroke.Color, claDimgray);
      ACanvas.StrokeCap := TStrokeCap.Flat;
      ACanvas.StrokeJoin := TStrokeJoin.Miter;
      DrawRect(RectF(ARect.Left+AXShift, ARect.Top+AYShift, ARect.Right, ARect.Bottom), 0, 0, AllCorners, 1);

      ACanvas.Stroke.Color := ACanvas.Fill.Color;

      for ASide := Low(TSide) to High(TSide) do
        if not (ASide in FSides) then
          DrawRectSides(RectF(ARect.Left+AXShift, ARect.Top+AYShift, ARect.Right, ARect.Bottom), 0, 0, AllCorners, 1, [ASide]);
    end
    else
    begin
      ARect := RectF(x, y, x+FWidth, y+FHeight);
      ATextRect := ARect;
      ATextRect.Left := ATextRect.Left + (FPadding.Left);
      ATextRect.Top := ATextRect.Top + (FPadding.Top * s);
      ATextRect.Right := ATextRect.Right - (FPadding.Right * s);
      ATextRect.Bottom := ATextRect.Bottom - (FPadding.Bottom * s);
      ACanvas.Font.Assign(FTextSettings.Font);
      ACanvas.Font.Size := FTextSettings.Font.Size;
      RenderText(ACanvas, ATextRect.Left, ATextRect.Top, ATextRect.Width, ATextRect.Height, FText,
                 ACanvas.Font, FTextSettings.FontColor, True, FTextSettings.HorzAlign,
                 FTextSettings.VertAlign, TTextTrimming.Character);
    end;
  end;
end;

function TksListItemRowTableCell.GetShadow: TksTableViewShadow;
begin
  Result := FTable.Shadow;
end;

function TksListItemRowTableCell.IsFixedCell: Boolean;
begin
  Result := (FRow <= (FTable.FixedRows-1)) or (FCol <= (FTable.FixedCols-1));
end;

procedure TksListItemRowTableCell.SetText(const Value: string);
begin
  FText := Value;
end;

procedure TksListItemRowTableCell.SetTextSettings(const Value: TTextSettings);
begin
  FTextSettings.Assign(Value);
end;

procedure TksListItemRowTableCell.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
  Changed;
end;

// ------------------------------------------------------------------------------

{ TksListItemRowTableBanding }

procedure TksListItemRowTableBanding.Assign(ASource: TPersistent);
var
  Src : TksListItemRowTableBanding;
begin
  if (ASource is TksListItemRowTableBanding) then
  begin
    Src := TksListItemRowTableBanding(ASource);
    FActive := Src.Active;
    FColor1 := Src.FColor1;
    FColor2 := Src.FColor2;
  end;
end;


constructor TksListItemRowTableBanding.Create;
begin
  inherited Create;
  FActive :=False;
  FColor1 := claNull;
  FColor2 := claNull;
end;

procedure TksListItemRowTableBanding.SetActive(const Value: Boolean);
begin
  FActive := Value;
end;

// ------------------------------------------------------------------------------

{ TksTableViewItemTable }

procedure TksTableViewItemTable.Clear;
var
  X, Y: integer;
  ARow: TksListItemRowTableRow;
begin
  for y := Low(FRows) to High(FRows) do
  begin
    ARow := FRows[y];
    for x := Low(ARow) to High(ARow) do
      FreeAndNil(ARow[x]);
  end;
end;

constructor TksTableViewItemTable.Create(ARow: TKsTableViewItem);
begin
  inherited;
  FShadow := TksTableViewShadow.Create;
  FBanding := TksListItemRowTableBanding.Create;
  SetLength(FRows, 5, 5);
  FBackground := claWhite;
  FBorderColor := claBlack;
  FColCount := 5;
  FRowCount := 5;
  FFixedCellColor := claGainsboro;
  FFixedRows := 1;
  FFixedCols := 1;
end;

destructor TksTableViewItemTable.Destroy;
begin
  Clear;
  FreeAndNil(FShadow);
  FreeAndNil(FBanding);
  inherited;
end;

function TksTableViewItemTable.GetCells(ACol, ARow: integer): TksListItemRowTableCell;
begin
  Result := FRows[ARow, ACol];
end;

function TksTableViewItemTable.GetColWidths(ACol: integer): single;
begin
  Result := FRows[0, ACol].Width;
end;

function TksTableViewItemTable.GetTableSize: TSizeF;
var
  ICount: integer;
begin
  Result.cx := 0;
  Result.cy := 0;

  if FRowCount > 0 then
  begin
    for ICount := Low(FRows) to High(FRows) do
    begin
      Result.cy := Result.cy + Frows[ICount, 0].Height;
    end;
  end;
  if (FColCount > 0) and (FColCount > 0) then
  begin
    for ICount := Low(FRows[0]) to High(FRows[0]) do
    begin
      Result.cx := Result.cx + Frows[0, ICount].Width;
    end;
  end;
end;

procedure TksTableViewItemTable.MergeRowCells(x, y, AMergeCount: integer);
var
  ICount: integer;
  ACell: TksListItemRowTableCell;
begin
  ACell := Cells[x, y];
  for ICount := x to x+(AMergeCount-1) do
  begin
    if ICount > x then
    begin
      Cells[ICount, y].Visible := False;
      ACell.Width := ACell.Width + Cells[ICount, y].Width;
    end;
  end;
end;

procedure TksTableViewItemTable.Render(AItemRect: TRectF; ACanvas: TCanvas);
begin
  inherited;
  RenderTableContents(ACanvas, False); // render the grid.
  RenderTableContents(ACanvas, True);  // render the cell text
end;

procedure TksTableViewItemTable.RenderTableContents(ACanvas: TCanvas; AText: Boolean);
var
  IRowCount, ICellCount: integer;
  AXPos, AYPos: single;
  ARow: TksListItemRowTableRow;
  ACell: TksListItemRowTableCell;
  ASides: TSides;
  ABmp: TBitmap;
  ASize: TSizeF;
  AScale: single;
begin
  AScale := GetScreenScale;
  if AScale < 2 then
    AScale := 2;

  if AText then
  begin
    AXPos := ObjectRect.Left;
    AYPos := ObjectRect.Top;

    ACell := nil;
    for IRowCount := Low(FRows) to High(FRows) do
    begin
      ARow := FRows[IRowCount];
      for ICellCount := Low(ARow) to High(ARow) do
      begin
        ACell := ARow[ICellCount];
        begin
          ASides := [TSide.Right, TSide.Bottom];
          if ICellCount = 0 then ASides := ASides + [TSide.Left];
          if IRowCount = 0 then ASides := ASides + [TSide.Top];
          ACell.DrawToCanvas(AXpos, AYPos, ACanvas, ICellCount, IRowCount, FShadow, True);
        end;
        AXPos := AXPos + (ColWidths[ICellCount]);
      end;
      AYpos := AYpos + (ACell.Height);
      AXpos := ObjectRect.Left;
    end;
    Exit;
  end;


  ABmp := TBitmap.Create;
  try
    ASize := GetTableSize;
    FWidth := ASize.cx;
    FHeight := ASize.cy;
    ABmp.SetSize(Round((ASize.cx+FShadow.Offset+2) * (AScale)), Round((ASize.cy+FShadow.Offset+2) * (AScale)));
    ABmp.Clear(claNull);
    ABmp.Canvas.BeginScene;
    with ABmp.Canvas.Fill do
    begin
      Kind := TBrushKind.Solid;
      Color := FBackground;
    end;
    with ABmp.Canvas.Stroke do
    begin
      Kind := TBrushKind.Solid;
      Color := FBorderColor;
    end;

    AXPos := 0;
    AYPos := 0;

    ACell := nil;
    for IRowCount := Low(FRows) to High(FRows) do
    begin
      ARow := FRows[IRowCount];
      for ICellCount := Low(ARow) to High(ARow) do
      begin
        ACell := ARow[ICellCount];
        begin
          ASides := [TSide.Right, TSide.Bottom];
          if ICellCount = 0 then ASides := ASides + [TSide.Left];
          if IRowCount = 0 then ASides := ASides + [TSide.Top];
          ACell.DrawToCanvas(AXpos, AYPos, ABmp.Canvas, ICellCount, IRowCount, FShadow, False);
        end;
        AXPos := AXPos + (ColWidths[ICellCount]);
      end;
      AYpos := AYpos + (ACell.Height);
      AXpos := 0;
    end;
    ABmp.Canvas.EndScene;
    ACanvas.DrawBitmap(ABmp, RectF(0, 0, ABmp.Width, ABmp.Height),
                       RectF(ObjectRect.Left, ObjectRect.Top, ObjectRect.Left+FWidth+FShadow.Offset+1, ObjectRect.Top+FHeight+FShadow.Offset+1), 1, True);
  finally
    FreeAndNil(ABmp);
  end;
end;

procedure TksTableViewItemTable.ResizeTable;
var
  AShadowWidth: integer;
  x,y: integer;
  ARow: TksListItemRowTableRow;
  ACell: TksListItemRowTableCell;
begin
  SetLength(FRows, FRowCount, FColCount);
  for y := Low(FRows) to High(FRows) do
  begin
    ARow := FRows[y];
    for x := Low(ARow) to High(ARow) do
    begin
      ACell := ARow[x];
      if ACell = nil then
      begin
        ACell := TksListItemRowTableCell.Create(Self);
        ACell.Width := FDefaultColWidth;
        ACell.Height := FDefaultRowHeight;
        ACell.FRow := y;
        ACell.FCol := x;
        FRows[y, x] := ACell;
      end;
    end;
  end;

  AShadowWidth := 0;
  if FShadow.Visible then
    AShadowWidth := FShadow.Offset;
  FWidth := GetTableSize.cx + AShadowWidth + (4*GetScreenScale);
  FHeight := GetTableSize.cy + AShadowWidth + (4*GetScreenScale);
end;

procedure TksTableViewItemTable.SetBackgroundColor(const Value: TAlphaColor);
begin
  FBackground := Value;
end;

procedure TksTableViewItemTable.SetBanding(const Value: TksListItemRowTableBanding);
begin
  FBanding.Assign(Value);
end;

procedure TksTableViewItemTable.SetBorderColor(const Value: TAlphaColor);
begin
  FBorderColor := Value;
end;

procedure TksTableViewItemTable.SetColColor(ACol: integer; AColor: TAlphaColor);
var
  ICount: integer;
begin
  for ICount := Low(FRows) to High(FRows) do
    FRows[ICount, ACol].Fill.Color := AColor;
end;

procedure TksTableViewItemTable.SetColCount(const Value: integer);
begin
  FColCount := Value;
  ResizeTable;
end;

procedure TksTableViewItemTable.SetColFont(ACol: integer; AFontName: TFontName; AColor: TAlphaColor; ASize: integer; AStyle: TFontStyles);
var
  ICount: integer;
  ACell: TksListItemRowTableCell;
begin
  for ICount := Low(FRows) to High(FRows) do
  begin
    ACell := FRows[ICount, ACol];
    with ACell.TextSettings do
    begin
      if AFontName <> '' then Font.Family := AFontName;
      Font.Size := ASize;
      FontColor := AColor;
      Font.Style := AStyle;
    end;
  end;
end;

procedure TksTableViewItemTable.SetColWidths(ACol: integer; const Value: single);
var
  ICount: integer;
begin
  for ICount := Low(FRows) to High(FRows) do
    FRows[ICount, ACol].Width := Value;
  ResizeTable;
end;

procedure TksTableViewItemTable.SetDefaultColWidth(const Value: single);
begin
  FDefaultColWidth := Value;
end;

procedure TksTableViewItemTable.SetDefaultRowHeight(const Value: single);
begin
  FDefaultRowHeight := Value;
end;

procedure TksTableViewItemTable.SetFixedCellColor(const Value: TAlphaColor);
begin
  FFixedCellColor := Value;
end;

procedure TksTableViewItemTable.SetRowColor(ARow: integer; AColor: TAlphaColor);
var
  ICount: integer;
begin
  for ICount := Low(FRows[ARow]) to High(FRows[ARow]) do
    FRows[ARow, ICount].Fill.Color := AColor;
end;

procedure TksTableViewItemTable.SetRowCount(const Value: integer);
begin
  FRowCount := Value;
  ResizeTable;
end;

procedure TksTableViewItemTable.SetRowFont(ARow: integer; AFontName: TFontName; AColor: TAlphaColor; ASize: integer; AStyle: TFontStyles);
var
  ICount: integer;
  ACell: TksListItemRowTableCell;
begin
  for ICount := Low(FRows[ARow]) to High(FRows[ARow]) do
  begin
    ACell := FRows[ARow, ICount];
    with ACell.TextSettings do
    begin
      if AFontName <> '' then Font.Family := AFontName;
      Font.Size := ASize;
      FontColor := AColor;
      Font.Style := AStyle;
    end;
  end;
end;

// ------------------------------------------------------------------------------

{ TksTableViewPullToRefresh }

procedure TksTableViewPullToRefresh.Assign(ASource: TPersistent);
var
  Src: TksTableViewPullToRefresh;
begin
  if (ASource is TksTableViewPullToRefresh) then
  begin
    Src := (ASource as TksTableViewPullToRefresh);
    FEnabled := Src.Enabled;
    FPullText := Src.PullText;
    FReleaseText := Src.ReleaseText;
    FFont.Assign(Src.Font);
    FTextColor := Src.TextColor;
  end
  else
    inherited;
end;

constructor TksTableViewPullToRefresh.Create(ATableView: TksTableView);
begin
  FTableView := ATableView;
  FFont := TFont.Create;
  FEnabled := True;
  FPullText := 'pull to refresh';
  FReleaseText := 'release to refresh';
  FFont.Size := 16;
  FTextColor := claSilver;
end;

destructor TksTableViewPullToRefresh.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

procedure TksTableViewPullToRefresh.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
  FTableView.FAniCalc.BoundsAnimation := FEnabled;

end;

procedure TksTableViewPullToRefresh.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

// ------------------------------------------------------------------------------

{ TksTableViewItemEmbeddedControl }

function TksTableViewItemEmbeddedControl.CanFocus: Boolean;
begin
  Result := False;
end;

function TksTableViewItemEmbeddedControl.ConsumesClick: Boolean;
begin
  Result := True;
end;

constructor TksTableViewItemEmbeddedControl.Create(ATableItem: TksTableViewItem);
begin
  inherited;
  FControl := CreateControl;
  //FControl.OnExit := DoLoseFocus;
  FWidth := FControl.Width;
  FHeight := FControl.Height;
  InitializeControl;
  FFocused := False;
  FControl.Cursor := crHandPoint;
  FControl.OnExit := DoExitControl;
end;

destructor TksTableViewItemEmbeddedControl.Destroy;
begin
  FreeAndNil(FCached);

  {$IFDEF MSWINDOWS}
  FControl.Free;
  {$ELSE}
  FControl.DisposeOf;
  {$ENDIF}
  inherited;
end;

procedure TksTableViewItemEmbeddedControl.DoExitControl(Sender: TObject);
begin
  FTableItem.TableView.HideFocusedControl;
end;

function TksTableViewItemEmbeddedControl.GetControlBitmap(AForceRecreate: Boolean): TBitmap;
var
  ARect: TRectF;
begin
  if FControl.IsFocused then
  begin
    Result := FCached;
    FCached.Clear(claNull);
    Exit;
  end;
  ARect := GetObjectRect;
  if (FCached = nil) or (IsBlankBitmap(FCached)) or (AForceRecreate) then
  begin
    FControl.Width := ARect.Width;
    FControl.Height := ARect.Height;
    // first free the cached bitmap if it exists...
    if FCached <> nil then
      FreeAndNil(FCached);
    FCached := FControl.MakeScreenshot;
  end;

  Result := FCached;
  if FControl.IsFocused then
     FCached.Clear(claNull);
end;

procedure TksTableViewItemEmbeddedControl.HideControl;
begin
  DisableEvents;
  FControl.Root.SetFocused(nil);
  GetControlBitmap(True);
  FFocused := False;
  FTableItem.CacheItem(True);
  FTableItem.FTableView.Invalidate;
  FControl.Visible := False;
end;

procedure TksTableViewItemEmbeddedControl.ApplyStyle(AControl: TFmxObject);
var
  ICount: integer;
begin
  if (AControl is TControl) then
  begin
    (AControl as TControl).RecalcSize;
    (AControl as TControl).UpdateEffects;
    (AControl as TControl).Repaint;
  end;
  if (AControl is TStyledControl) then
    (AControl as TStyledControl).ApplyStyleLookup;
  for ICount := 0 to AControl.ChildrenCount-1 do
    ApplyStyle(AControl.Children[ICount]);
end;

procedure TksTableViewItemEmbeddedControl.InitializeControl;
begin
  FTableItem.FTableView.AddObject(FControl);
  FControl.RecalcSize;
  ApplyStyle(FControl);
  FControl.UpdateEffects;
  FControl.Visible := False;

end;
      {
procedure TksTableViewItemEmbeddedControl.SimulateClick(x, y: single);
var
  AParent   : TFmxObject;
  AForm     : TCommonCustomForm;
  AFormPoint: TPointF;
begin
  AParent := FControl.Parent;
  if AParent = nil then
    Exit;
  while not (AParent is TCommonCustomForm) do
    AParent := AParent.Parent;

  if (AParent is TCommonCustomForm) then
  begin
    AForm      := TCommonCustomForm(AParent);
    AFormPoint := FControl.LocalToAbsolute(PointF(X,Y));

    AForm.MouseDown(TMouseButton.mbLeft, [], AFormPoint.X, AFormPoint.Y);
    AForm.MouseUp(TMouseButton.mbLeft, [], AFormPoint.X, AFormPoint.Y);
  end;
end;     }

procedure TksTableViewItemEmbeddedControl.MouseDown(x, y: single);
begin
  if (FControl.IsFocused) or (FVisible = False) or (FTableItem.TableView.FScrolling) then
    Exit;
  GetControlBitmap(True);
  FocusControl;
  SimulateClick(FControl, x, y);
end;

procedure TksTableViewItemEmbeddedControl.Render(AItemRect: TRectF; ACanvas: TCanvas);
var
  ABmp: TBitmap;
  r: TRectF;
begin
  if FFocused then
    Exit;
  r := ObjectRect;
  ABmp := GetControlBitmap(False);
  if ABmp = nil then
    Exit;
  ACanvas.DrawBitmap(ABmp,
                     RectF(0, 0, ABmp.Width, ABmp.Height),
                     r,
                     1,
                     False);
end;

procedure TksTableViewItemEmbeddedControl.FocusControl;
var
  r: TRectF;
begin
  inherited;
  if FControl.IsFocused then
    Exit;
  if FTableItem.FTableView.FFocusedControl <> Self then
    FTableItem.FTableView.HideFocusedControl;
  r := GetObjectRect;
  OffsetRect(r, 0, FTableItem.TableView.GetStartOffsetY);
  FControl.SetBounds(r.Left, (FTableItem.ItemRect.Top - FTableItem.FTableView.ScrollViewPos) + r.Top, r.width, r.height);
  FControl.Visible := True;
  FFocused := True;
  FTableItem.FTableView.FFocusedControl := Self;


  FCached.Canvas.Clear(claNull);
  FTableItem.CacheItem(True);

  if (FTableItem.TableView.SelectionOptions.KeepSelection) and (FTableItem.CanSelect) then
  begin
    if FTableItem.Purpose <> TksTableViewItemPurpose.Header then
      FTableItem.TableView.ItemIndex := FTableItem.Index;
  end;

  FControl.CanFocus := True;
  FControl.SetFocus;
  FTableItem.CacheItem(True);
  FTableItem.FTableView.Invalidate;
  FTableItem.FTableView.FSearchBox.BringToFront;
  EnableEvents;

 end;

function TksTableViewItemEmbeddedBaseEdit.CanFocus: Boolean;
begin
  Result := True;
end;

procedure TksTableViewItemEmbeddedBaseEdit.DisableEvents;
begin
  CustomEdit.OnChange := nil;
  CustomEdit.OnTyping := nil;
end;

procedure TksTableViewItemEmbeddedBaseEdit.DoEditChange(Sender: TObject);
begin
  FTableItem.TableView.DoEmbeddedEditChange(FTableItem, Self);
end;

procedure TksTableViewItemEmbeddedBaseEdit.EnableEvents;
begin
  CustomEdit.OnChange := DoEditChange;
  CustomEdit.OnTyping := DoEditChange;
end;

procedure TksTableViewItemEmbeddedBaseEdit.FocusControl;
begin
  if GetCustomEdit.IsFocused then
    Exit;
  inherited;
  GetCustomEdit.SelStart := Length(GetCustomEdit.Text);
end;

function TksTableViewItemEmbeddedBaseEdit.GetCustomEdit: TCustomEdit;
begin
  Result := (FControl as TCustomEdit);
end;


procedure TksTableViewItemEmbeddedBaseEdit.HideControl;
begin
  GetCustomEdit.SelStart := 0;
  inherited;
end;


procedure TksTableViewItemEmbeddedBaseEdit.SetStyle(
  const Value: TksEmbeddedEditStyle);
begin
  FStyle := Value;
  case FStyle of
    ksEditNormal: CustomEdit.StyleLookup := 'editstyle';
    ksEditClearing: CustomEdit.StyleLookup := 'clearingeditstyle';
    ksEditCombo: CustomEdit.StyleLookup := 'comboeditstyle';
    ksEditTransparent: CustomEdit.StyleLookup := 'transparentedit';
  end;
end;

// ------------------------------------------------------------------------------

{ TksTableViewItemEmbeddedEdit }

function TksTableViewItemEmbeddedEdit.CreateControl: TStyledControl;
begin
  Result := TEdit.Create(FTableItem.FTableView);
end;

function TksTableViewItemEmbeddedEdit.GetEditControl: TEdit;
begin
  Result := (FControl as TEdit);
end;

function TksTableViewItemEmbeddedEdit.GetText: string;
begin
  Result := GetEditControl.Text;
end;

procedure TksTableViewItemEmbeddedEdit.SetText(const Value: string);
begin
  GetEditControl.Text := Value;
end;

// ------------------------------------------------------------------------------

{ TksDragDropOptions }

constructor TksDragDropOptions.Create;
begin
  inherited Create;
  FDragHighlightOptions := TksDragHighlightOptions.Create;
  FShadow := True;
  FOpacity := 1;
  FEnabled := False;
  FLiveMoving := True;
  FDragSpaceColor := $FFECECEC;
end;

destructor TksDragDropOptions.Destroy;
begin
  FreeAndNil(FDragHighlightOptions);
  inherited;
end;

procedure TksDragDropOptions.SetDragHighlightOptions(const Value: TksDragHighlightOptions);
begin
  FDragHighlightOptions := Value;
end;

procedure TksDragDropOptions.SetOpacity(const Value: single);
begin
  FOpacity := Value;
  if FOpacity < 1 then
    FShadow := False;
end;

procedure TksDragDropOptions.SetShadow(const Value: Boolean);
begin
  FShadow := Value;
  if FShadow then
    FOpacity := 1;
end;

// ------------------------------------------------------------------------------

{ TksDragImage }

constructor TksDragImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBorder := TRectangle.Create(Self);
  FBorder.Stroke.Color := claDimgray;
  FBorder.Fill.Color := claNull;
  FBorder.Align := TAlignLayout.Client;
  Stroke.Thickness := 3;
  FShadow := TShadowEffect.Create(Self);
  FShadow.Direction := 45;
  FShadow.Distance := 5;
  FShadow.Softness := 0.2;
  Stroke.Color := claBlack;
  AddObject(FShadow);
  AddObject(FBorder);
end;

destructor TksDragImage.Destroy;
begin
  FreeAndNil(FShadow);
  inherited;
end;

function TksDragImage.GetAllowDropColor: TStrokeBrush;
begin
  Result := Stroke;
end;

procedure TksDragImage.SetAllowDropColor(const Value: TStrokeBrush);
begin
  Stroke.Assign(Value);
end;

// ------------------------------------------------------------------------------

{ TksDragHighlightOptions }

constructor TksDragHighlightOptions.Create;
begin
  FAllowDropStroke := TStrokeBrush.Create(TBrushKind.Solid, claLimegreen);
  FDisallowDropStroke := TStrokeBrush.Create(TBrushKind.Solid, claRed);
  FEnabled := True;
end;

destructor TksDragHighlightOptions.Destroy;
begin
  FreeAndNil(FAllowDropStroke);
  FreeAndNil(FDisallowDropStroke);
  inherited;
end;

procedure TksDragHighlightOptions.SetAllowDropStroke(const Value: TStrokeBrush);
begin
  FAllowDropStroke.Assign(Value);
end;

procedure TksDragHighlightOptions.SetDisallowDropStroke(const Value: TStrokeBrush);
begin
  FDisallowDropStroke.Assign(Value);
end;

// ------------------------------------------------------------------------------

{ TksTableViewSelectionOptions }

constructor TksTableViewSelectionOptions.Create(ATableView: TKsTableView);
begin
  inherited Create;
  FTableView := ATableView;
  FSelectionOverlay := TksTableViewSelectionOverlayOptions.Create(Self);
  FShowSelection := True;
  FKeepSelection := False;
  FSelectDuration := C_TABLEVIEW_DEFAULT_SELECT_DURATION;
  FKeepSelectedInView := True;
  FLongTapSelects := True;
end;

destructor TksTableViewSelectionOptions.Destroy;
begin
  FreeAndNil(FSelectionOverlay);
  inherited;
end;

procedure TksTableViewSelectionOptions.Assign(ASource: TPersistent);
var
  Src : TksTableViewSelectionOptions;
begin
  if (ASource is TksTableViewSelectionOptions) then
  begin
    Src := TksTableViewSelectionOptions(ASource);

    FSelectionOverlay.Assign(Src.FSelectionOverlay);
    FShowSelection           := Src.FShowSelection;
    FKeepSelection           := Src.FKeepSelection;
    FSelectDuration          := Src.FSelectDuration;
    FKeepSelectedInView      := Src.FKeepSelectedInView;
    FLongTapSelects           := Src.FLongTapSelects;
  end
  else
    inherited;
end;

procedure TksTableViewSelectionOptions.SetKeepSelection(const Value: Boolean);
begin
  if FKeepSelection <> Value then
  begin
    FKeepSelection := Value;
    FTableView.ClearCache(ksClearCacheAll);
    FTableView.Invalidate;
  end;
end;

procedure TksTableViewSelectionOptions.SetShowSelection(const Value: Boolean);
begin
  if FShowSelection <> Value then
  begin
    FShowSelection := Value;
    FTableView.ClearCache(ksClearCacheAll);
    FTableView.Invalidate;
  end;
end;

procedure TksTableViewSelectionOptions.SetSelectionOverlay(const Value: TksTableViewSelectionOverlayOptions);
begin
  FSelectionOverlay.Assign(Value);
  FTableView.ClearCache(ksClearCacheAll);
  FTableView.Invalidate;
end;

procedure TksTableViewSelectionOptions.SetKeepSelectedInView(const Value: Boolean);
begin
  FKeepSelectedInView := Value;
end;


procedure TksTableViewSelectionOptions.SetLongTapSelects(const Value: Boolean);
begin
  FLongTapSelects := Value;
end;

// ------------------------------------------------------------------------------

{ TksTableViewSelectionOverlayOptions }

constructor TksTableViewSelectionOverlayOptions.Create(AParent: TksTableViewSelectionOptions);
begin
  inherited Create;
  FParent := AParent;
  FBitmap := TBitmap.Create;
  FStroke := TStrokeBrush.Create(TBrushKind.Solid, claBlack);
  FPosition := ksSelectorRight;
  FBackgroundColor := claWhite;
  FStyle := ksArrow;
  FStroke.OnChanged := DoStrokeChanged;
  FLastStickyHeaderOffset := 0;
  FLastFixedFooterOffset := 0;
end;

destructor TksTableViewSelectionOverlayOptions.Destroy;
begin
  FreeAndNil(FStroke);
  FreeAndNil(FBitmap);
  inherited;
end;

procedure TksTableViewSelectionOverlayOptions.Assign(ASource: TPersistent);
var
  Src : TksTableViewSelectionOverlayOptions;
begin
  if (ASource is TksTableViewSelectionOverlayOptions) then
  begin
    Src := TksTableViewSelectionOverlayOptions(ASource);

    FPosition := Src.FPosition;
    FStyle    := Src.FStyle;
    FEnabled  := Src.FEnabled;
    FStroke.Assign(Src.FStroke);
    FBackgroundColor := Src.FBackgroundColor;

    if (FBitmap=Nil) then
      FBitmap := TBitmap.Create;
    FBitmap.Assign(Src.FBitmap);

    FSize                   := Src.FSize;
    FLastStickyHeaderOffset := Src.FLastStickyHeaderOffset;
    FLastFixedFooterOffset  := Src.FLastFixedFooterOffset;
  end
  else
    inherited;
end;

procedure TksTableViewSelectionOverlayOptions.DrawToCanvas(ACanvas: TCanvas; ARect: TRectF ; AStickyHeaderBottom,FixedFooterStart : Single);
var
  StickyHeaderOffset : Single;
  FixedFooterOffset : Single;
  ScreenScale: Single;
  ANewBitmapWidth : Integer;
  ANewBitmapHeight : Integer;
  ANewStickyHeaderOffset: Single;
  ANewFixedFooterOffset: Single;
begin
  if (ARect.Bottom>AStickyHeaderBottom) and (ARect.Top<FixedFooterStart) then
  begin
    ScreenScale := GetScreenScale;

    if FStyle = ksBlankSpace then
    begin
      ARect.Top           := ARect.Top - 1;
      AStickyHeaderBottom := AStickyHeaderBottom - 1;
    end;

    if (ARect.Top<AStickyHeaderBottom) then
      StickyHeaderOffset := AStickyHeaderBottom - ARect.Top
    else
      StickyHeaderOffset := 0;

    if (ARect.Bottom>FixedFooterStart) then
      FixedFooterOffset := ARect.Bottom - FixedFooterStart
    else
      FixedFooterOffset := 0;

    ANewBitmapWidth        := Round(ARect.Width * ScreenScale * 2);
    ANewBitmapHeight       := Round(ARect.Height * ScreenScale);
    ANewStickyHeaderOffset := StickyHeaderOffset * ScreenScale;
    ANewFixedFooterOffset  := (ARect.Height-FixedFooterOffset) * ScreenScale;

    if (FBitmap.Width <> ANewBitmapWidth) or (FBitmap.Height <> ANewBitmapHeight) or (ANewStickyHeaderOffset<>FLastStickyHeaderOffset) or (ANewFixedFooterOffset<>FLastFixedFooterOffset) then
    begin
      RecreateIndicator(ANewBitmapWidth,ANewBitmapHeight,ANewStickyHeaderOffset,ANewFixedFooterOffset);

      FLastStickyHeaderOffset := ANewStickyHeaderOffset;
      FLastFixedFooterOffset  := ANewFixedFooterOffset;
    end;

    case FPosition of
      ksSelectorLeft: ACanvas.DrawBitmap(FBitmap,
                                         RectF(0, StickyHeaderOffset * ScreenScale, FBitmap.Width, FBitmap.Height - (FixedFooterOffset * ScreenScale)),
                                         RectF(ARect.Left - ARect.Width, ARect.Top + StickyHeaderOffset, ARect.Left + ARect.Width, ARect.Bottom-FixedFooterOffset),
                                         1,
                                         false);

      ksSelectorRight: ACanvas.DrawBitmap(FBitmap,
                                          RectF(0, StickyHeaderOffset * ScreenScale, FBitmap.Width, FBitmap.Height - (FixedFooterOffset * ScreenScale)),
                                          RectF(ARect.Right - ARect.Width, ARect.Top + StickyHeaderOffset, ARect.Right + ARect.Width, ARect.Bottom-FixedFooterOffset),
                                          1,
                                          false);
    end;
  end;
end;

procedure TksTableViewSelectionOverlayOptions.RecreateIndicator(AWidth,AHeight,AStickyHeaderOffset,AFixedFooterOffset: single);
var
  APath: TPathData;
  ASize: single;
  AMaxSize: single;
  AOffsetX: single;
  AOffsetY: single;
  AIndicatorRect: TRectF;
  AHypot: single;
  StrokeThickness : Single;
  ScreenScale: Single;
  ALineSize: single;
  ATop: single;
  ABottom: single;
begin
  ScreenScale     := GetScreenScale;
  StrokeThickness := (FStroke.Thickness /2) * ScreenScale;

  FBitmap.SetSize(Round(AWidth), Round(AHeight));
  FBitmap.Canvas.BeginScene;
  FBitmap.Canvas.Fill.Color := claNull;
  FBitmap.Canvas.FillRect(RectF(0,0,FBitmap.Width,FBitmap.Height),0,0,AllCorners,1);
  try
    FBitmap.Canvas.Stroke.Assign(FStroke);
    FBitmap.Canvas.Fill.Color := FBackgroundColor;

    ASize := (2*FSize*ScreenScale);
    AMaxSize := AHeight - StrokeThickness;
    if (ASize>AMaxSize) then
      ASize := AMaxSize;

    AOffsetX := (AWidth  - ASize) / 2;
    AOffsetY := (AHeight - ASize) / 2;

    AIndicatorRect := RectF(AOffsetX, AOffsetY, FBitmap.Width-AOffsetX, FBitmap.Height-AOffsetY);

    FBitmap.Canvas.Stroke.Thickness := StrokeThickness;

    if FStyle = ksBlankSpace then
    begin
      FBitmap.Canvas.Fill.Color := FStroke.Color;
      FBitmap.Canvas.FillRect(RectF(0,0,FBitmap.Width,FBitmap.Height),0,0,AllCorners,1);

      ATop    := AStickyHeaderOffset+Round(StrokeThickness);
      ABottom := Floor(FBitmap.Height-StrokeThickness)-(AHeight-AFixedFooterOffset);

      if (ATop<ABottom-1) then
      begin
        FBitmap.Canvas.ClearRect(RectF(0,ATop,FBitmap.Width,ABottom));

        FBitmap.Canvas.Fill.Color := FBackgroundColor;
        FBitmap.Canvas.FillRect(RectF((FBitmap.Width/2)-StrokeThickness-1,ATop,
                                       (FBitmap.Width/2)+StrokeThickness+1,ABottom),
                                       0,0,AllCorners,1);
      end;
    end
    else if FStyle = ksSemiCircle then
    begin
      FBitmap.Canvas.FillEllipse(AIndicatorRect, 1);
      FBitmap.Canvas.DrawEllipse(AIndicatorRect, 1);

      if (AStickyHeaderOffset>AIndicatorRect.Top) and (AStickyHeaderOffset<AIndicatorRect.Bottom) then
      begin
        AHypot   := (ASize/2);
        AOffsetY := Abs(AIndicatorRect.CenterPoint.Y - AStickyHeaderOffset);

        if (AHypot>AOffsetY) then
        begin
          ALineSize := Sqrt((AHypot*AHypot) - (AOffsetY*AOffsetY));

          AStickyHeaderOffset := Floor(AStickyHeaderOffset + (StrokeThickness/2));

          FBitmap.Canvas.DrawLine(PointF(AIndicatorRect.CenterPoint.X-ALineSize,AStickyHeaderOffset),
                                  PointF(AIndicatorRect.CenterPoint.X+ALineSize,AStickyHeaderOffset),
                                  1);
        end;
      end;

      if (AFixedFooterOffset>AIndicatorRect.Top) and (AFixedFooterOffset<AIndicatorRect.Bottom) then
      begin
        AHypot   := (ASize/2);
        AOffsetY := Abs(AIndicatorRect.CenterPoint.Y - AFixedFooterOffset);

        if (AHypot>AOffsetY) then
        begin
          ALineSize := Sqrt((AHypot*AHypot) - (AOffsetY*AOffsetY));

          AFixedFooterOffset := AFixedFooterOffset - (StrokeThickness/2) + 0.5;

          FBitmap.Canvas.DrawLine(PointF(AIndicatorRect.CenterPoint.X-ALineSize,AFixedFooterOffset),
                                  PointF(AIndicatorRect.CenterPoint.X+ALineSize,AFixedFooterOffset),
                                  1);
        end;
      end;
    end
    else if FStyle = ksArrow then
    begin
      APath := TPathData.Create;
      try
        APath.MoveTo(PointF(AIndicatorRect.Left, AIndicatorRect.CenterPoint.Y));
        APath.LineTo(PointF(AIndicatorRect.CenterPoint.X, AIndicatorRect.Top));
        APath.LineTo(PointF(AIndicatorRect.Right, AIndicatorRect.CenterPoint.Y));
        APath.LineTo(PointF(AIndicatorRect.CenterPoint.X, AIndicatorRect.Bottom));
        APath.LineTo(PointF(AIndicatorRect.Left, AIndicatorRect.CenterPoint.Y));
        APath.ClosePath;
        FBitmap.Canvas.FillPath(APath, 1);
        FBitmap.Canvas.DrawPath(APath, 1);

        if (AStickyHeaderOffset>AIndicatorRect.Top) and (AStickyHeaderOffset<AIndicatorRect.Bottom) then
        begin
          ALineSize := (ASize/2) - Abs(AIndicatorRect.CenterPoint.Y - AStickyHeaderOffset);

          AStickyHeaderOffset := Floor(AStickyHeaderOffset + (StrokeThickness/2));

          FBitmap.Canvas.DrawLine(PointF(AIndicatorRect.CenterPoint.X-ALineSize,AStickyHeaderOffset),
                                  PointF(AIndicatorRect.CenterPoint.X+ALineSize,AStickyHeaderOffset),
                                  1);
        end;

        if (AFixedFooterOffset>AIndicatorRect.Top) and (AFixedFooterOffset<AIndicatorRect.Bottom) then
        begin
          ALineSize := (ASize/2) - Abs(AIndicatorRect.CenterPoint.Y - AFixedFooterOffset);

          AFixedFooterOffset := AFixedFooterOffset - (StrokeThickness/2) + 0.5;

          FBitmap.Canvas.DrawLine(PointF(AIndicatorRect.CenterPoint.X-ALineSize,AFixedFooterOffset),
                                  PointF(AIndicatorRect.CenterPoint.X+ALineSize,AFixedFooterOffset),
                                  1);
        end;
      finally
        FreeAndNil(APath);
      end;
    end;

  finally
    FBitmap.Canvas.EndScene;
  end;
end;


procedure TksTableViewSelectionOverlayOptions.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    FParent.FTableView.Invalidate;
  end;
end;

procedure TksTableViewSelectionOverlayOptions.SetPosition(const Value: TksTableViewOverlaySelectorPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    FParent.FTableView.Invalidate;
  end;
end;

procedure TksTableViewSelectionOverlayOptions.SetSize(const Value: integer);
begin
  if FSize <> Value then
  begin
    FSize := Value;
    FParent.FTableView.Invalidate;
  end;
end;

procedure TksTableViewSelectionOverlayOptions.SetStrokeBrush(const Value: TStrokeBrush);
begin
  if Value <> nil then
  begin
    FStroke.Assign(Value);
    FParent.FTableView.Invalidate;
  end;
end;

procedure TksTableViewSelectionOverlayOptions.SetStyle(const Value: TksTableViewOverlaySelectorStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    FBitmap.SetSize(0, 0);
    FParent.FTableView.Invalidate;
  end;
end;

procedure TksTableViewSelectionOverlayOptions.DoStrokeChanged(Sender: TObject);
begin
  FParent.FTableView.Invalidate;
end;

// ------------------------------------------------------------------------------

{ TksTableViewItemEmbeddedDateEdit }

function TksTableViewItemEmbeddedDateEdit.CreateControl: TStyledControl;
begin
  Result := TDateEdit.Create(FTableItem.FTableView);
end;

procedure TksTableViewItemEmbeddedDateEdit.DisableEvents;
begin
  (FControl as TDateEdit).OnChange := nil;
end;

procedure TksTableViewItemEmbeddedDateEdit.DoDateChanged(Sender: TObject);
begin
  FTableItem.TableView.DoEmbeddedDateEditChange(FTableItem, Self);
end;

procedure TksTableViewItemEmbeddedDateEdit.EnableEvents;
begin
  (FControl as TDateEdit).OnChange := DoDateChanged;
end;

function TksTableViewItemEmbeddedDateEdit.GetDate: TDateTime;
begin
  Result := GetEditControl.Date;
end;

function TksTableViewItemEmbeddedDateEdit.GetEditControl: TDateEdit;
begin
  Result := (FControl as TDateEdit);
end;

procedure TksTableViewItemEmbeddedDateEdit.SetDate(const Value: TDateTime);
begin
  GetEditControl.Date := Value;
end;

// ------------------------------------------------------------------------------

{ TksTableViewItemEmbeddedButton }

function TksTableViewItemButton.CreateControl: TStyledControl;
begin
  Result := TSpeedButton.Create(FTableItem.TableView);
  (Result as TSpeedButton).CanFocus := False;
  (Result as TSpeedButton).DisableFocusEffect := True;
  (Result as TSpeedButton).StyleLookup := 'listitembutton';

end;

procedure TksTableViewItemButton.DisableEvents;
begin
  GetButton.OnClick := nil;
end;

procedure TksTableViewItemButton.DoButtonClicked(Sender: TObject);
begin
  FTableItem.TableView.DoButtonClicked(FTableItem, Self);
end;

procedure TksTableViewItemButton.EnableEvents;
begin
  GetButton.OnClick := DoButtonClicked;
end;

function TksTableViewItemButton.GetButton: TSpeedButton;
begin
  Result := (FControl as TSpeedButton);
end;

function TksTableViewItemButton.GetStyleLookup: string;
begin
  Result := GetButton.StyleLookup;
end;

function TksTableViewItemButton.GetText: string;
begin
  Result := GetButton.Text;
end;

function TksTableViewItemButton.GetTintColor: TAlphaColor;
begin
  Result := GetButton.TintColor;
end;

procedure TksTableViewItemButton.SetStyleLookup(const Value: string);
begin
  if StyleLookup <> Value then
  begin
    InitializeControl;
    GetButton.StyleLookup := Value;

    {$IFDEF ANDROID}
    GetButton.Size.Size := GetButton.DefaultSize;
    fheight := GetButton.Size.height;
    FWidth := GetButton.Size.Width;
    {$ENDIF}
    Changed;
  end;
end;

procedure TksTableViewItemButton.SetText(const Value: string);
begin
  GetButton.Text := Value;
end;

procedure TksTableViewItemButton.SetTintColor(const Value: TAlphaColor);
begin
  GetButton.TintColor := Value;
end;

// ------------------------------------------------------------------------------

{ TksTableViewAccessoryOptions }

procedure TksTableViewAccessoryOptions.Changed;
begin
  FTableView.RedrawAllVisibleItems;
end;

constructor TksTableViewAccessoryOptions.Create(ATableView: TksTableView);
begin
  inherited Create;
  FTableView := ATableView;
  FShowAccessory := True;
  FColor := claNull;
end;

procedure TksTableViewAccessoryOptions.Assign(ASource: TPersistent);
var
  Src : TksTableViewAccessoryOptions;
begin
  if (ASource is TksTableViewAccessoryOptions) then
  begin
    Src := TksTableViewAccessoryOptions(ASource);

    FShowAccessory := Src.FShowAccessory;
    FColor         := Src.FColor;
  end
  else
    inherited;
end;

procedure TksTableViewAccessoryOptions.SetColor(const Value: TAlphaColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TksTableViewAccessoryOptions.SetShowAccessory(const Value: Boolean);
begin
  if FShowAccessory <> Value then
  begin
    FShowAccessory := Value;
    Changed;
  end;
end;

// ------------------------------------------------------------------------------

{ TksTableViewItemHeaderOptions }

procedure TksTableViewItemHeaderOptions.Changed;
begin
  FTableView.UpdateFilteredItems;
  FTableView.Invalidate;
end;

constructor TksTableViewItemHeaderOptions.Create(ATableView: TksTableView);
begin
  inherited Create;
  FTableView := ATableView;
  FStickyHeaders := TksTableViewStickyHeaderOptions.Create(FTableView);
  FHeight := C_TABLEVIEW_DEFAULT_HEADER_HEIGHT;
end;

procedure TksTableViewItemHeaderOptions.LegacyGetStickyHeadersHeight(Reader: TReader);
begin
  FStickyHeaders.StickyHeight := Reader.ReadInteger;
end;

procedure TksTableViewItemHeaderOptions.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('StickyHeaderHeight', LegacyGetStickyHeadersHeight, nil, False);
end;

destructor TksTableViewItemHeaderOptions.Destroy;
begin
  FreeAndNil(FStickyHeaders);
  inherited;
end;

procedure TksTableViewItemHeaderOptions.Assign(ASource: TPersistent);
var
  Src : TksTableViewItemHeaderOptions;
begin
  if (ASource is TksTableViewItemHeaderOptions) then
  begin
    Src := TksTableViewItemHeaderOptions(ASource);

    FHeight := Src.FHeight;
    FStickyHeaders.Assign(Src.FStickyHeaders);
  end
  else
    inherited;
end;


function TksTableViewItemHeaderOptions.GetHeaderColor: TAlphaColor;
begin
  Result := FTableView.Appearence.HeaderColor;
end;

procedure TksTableViewItemHeaderOptions.SetHeaderColor(const Value: TAlphaColor);
begin
  FTableView.Appearence.HeaderColor := Value;
end;

procedure TksTableViewItemHeaderOptions.SetHeaderHeight(const Value: integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    Changed;
  end;
end;

procedure TksTableViewItemHeaderOptions.SetStickyHeaders(const Value: TksTableViewStickyHeaderOptions);
begin
  FStickyHeaders.Assign(Value);
end;

// ------------------------------------------------------------------------------

{ TksTableViewBorderOptions }

function TksTableViewBorderOptions.Showing: Boolean;
begin
  Result := (Visible) and
            (FStroke.Color <> claNull) and
            (FStroke.Kind <> TBrushKind.None);
end;

procedure TksTableViewBorderOptions.Changed;
begin
  FTableView.Invalidate;
end;

constructor TksTableViewBorderOptions.Create(ATableView: TksTableView);
begin
  inherited Create;
  FTableView := ATableView;
  FStroke := TStrokeBrush.Create(TBrushKind.Solid, claBlack);
  FSides := AllSides;
  FVisible := False;
end;

destructor TksTableViewBorderOptions.Destroy;
begin
  FreeAndNil(FStroke);
  inherited;
end;

procedure TksTableViewBorderOptions.Assign(ASource: TPersistent);
var
  Src : TksTableViewBorderOptions;
begin
  if (ASource is TksTableViewBorderOptions) then
  begin
    Src := TksTableViewBorderOptions(ASource);

    FVisible := Src.FVisible;
    FSides   := Src.FSides;
    FStroke.Assign(Src.FStroke);
  end
  else
    inherited;
end;

function TksTableViewBorderOptions.IsSidesStored: Boolean;
begin
  Result := FSides * AllSides <> AllSides
end;

procedure TksTableViewBorderOptions.SetSides(const Value: TSides);
begin
  if FSides <> Value then
  begin
    FSides := Value;
    Changed;
  end;
end;

procedure TksTableViewBorderOptions.SetStroke(const Value: TStrokeBrush);
begin
  FStroke.Assign(Value);
  Changed;
end;

procedure TksTableViewBorderOptions.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

// ------------------------------------------------------------------------------

{ TksTableViewFixedRowsOptions }

constructor TksTableViewFixedRowsOptions.Create(ATableView: TksTableView);
begin
  inherited Create;
  FTableView         := ATableView;
  FHeaderCount       := 0;
  FFooterCount       := 0;
  FMinimumWorkHeight := 0;
end;

procedure TksTableViewFixedRowsOptions.Assign(ASource: TPersistent);
var
  Src : TksTableViewFixedRowsOptions;
begin
  if (ASource is TksTableViewFixedRowsOptions) then
  begin
    Src := TksTableViewFixedRowsOptions(ASource);
    FHeaderCount       := Src.FHeaderCount;
    FFooterCount       := Src.FFooterCount;
    FMinimumWorkHeight := Src.FMinimumWorkHeight;
  end
  else
    inherited;
end;

procedure TksTableViewFixedRowsOptions.Changed;
begin
  FTableView.UpdateItemRects(false);
  FTableView.Invalidate;
end;

procedure TksTableViewFixedRowsOptions.SetHeaderCount(const Value: Integer);
begin
  if (FHeaderCount <> Value) then
  begin
    FHeaderCount := Value;
    Changed;
  end;
end;

procedure TksTableViewFixedRowsOptions.SetFooterCount(const Value: Integer);
begin
  if (FFooterCount <> Value) then
  begin
    FFooterCount := Value;
    Changed;
  end;
end;

procedure TksTableViewFixedRowsOptions.SetMinimumWorkHeight(const Value: Integer);
begin
  if (FMinimumWorkHeight <> Value) then
  begin
    FMinimumWorkHeight := Value;
    Changed;
  end;
end;

// ------------------------------------------------------------------------------

{ TksTableViewCheckMarkOptions }

constructor TksTableViewCheckMarkOptions.Create(ATableView: TksTableView);
begin
  inherited Create;
  FTableView := ATableView;
  FCheckMarks := TksTableViewCheckMarks.cmNone;
  FPosition := TksTableViewCheckMarkPosition.cmpRight;
  FCheckMarkChecked := TksTableViewItemAccessory.Create(nil);
  FCheckMarkUnchecked := TksTableViewItemAccessory.Create(nil);

  FCheckMarkChecked.FAccessory := atCheckBoxChecked;
  FCheckMarkChecked.FAlign := TksTableItemAlign.Leading;
  FCheckMarkChecked.Color := C_TABLEVIEW_ACCESSORY_KEEPCOLOR;
  FCheckMarkChecked.OwnsBitmap := False;
  FCheckMarkUnchecked.FAccessory := atCheckBox;
  FCheckMarkUnchecked.FAlign := TksTableItemAlign.Leading;
  FCheckMarkUnchecked.Color := C_TABLEVIEW_ACCESSORY_KEEPCOLOR;
  FCheckMarkUnchecked.OwnsBitmap := False;

  FShowInHeader := true;
  FCheckArea := caWholeRow;
  FCheckSelects := true;
  FHeaderCheckSelectsAll := true;

end;

destructor TksTableViewCheckMarkOptions.Destroy;
begin
  FreeAndNil(FCheckMarkChecked);
  FreeAndNil(FCheckMarkUnchecked);
  inherited;
end;

procedure TksTableViewCheckMarkOptions.Changed;
begin
  FTableView.ClearCache(ksClearCacheAll);
  FTableView.Invalidate;
end;

procedure TksTableViewCheckMarkOptions.SetCheckMarks(const Value: TksTableViewCheckMarks);
begin
  if FCheckMarks <> Value then
  begin
    FCheckMarks := Value;
    if FCheckMarks <> TksTableViewCheckMarks.cmMultiSelect then
      FTableView.UncheckAll;
    Changed;
  end;
end;

procedure TksTableViewCheckMarkOptions.SetPosition(const Value: TksTableViewCheckMarkPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    Changed;
  end;
end;

procedure TksTableViewCheckMarkOptions.SetShowInHeader(const Value: Boolean);
begin
  if FShowInHeader <> Value then
  begin
    FShowInHeader := Value;
    Changed;
  end;
end;

procedure TksTableViewCheckMarkOptions.SetCheckArea(const Value: TksTableViewCheckMarkCheckArea);
begin
  if FCheckArea <> Value then
    FCheckArea := Value;
end;

procedure TksTableViewCheckMarkOptions.SetCheckSelects(const Value: Boolean);
begin
  if FCheckSelects <> Value then
  begin
    FCheckSelects := Value;
    Changed;
  end;
end;

procedure TksTableViewCheckMarkOptions.SetHeaderCheckSelectsAll(const Value: Boolean);
begin
  if FHeaderCheckSelectsAll <> Value then
    FHeaderCheckSelectsAll := Value;
end;


procedure TksTableViewCheckMarkOptions.Assign(ASource: TPersistent);
var
  Src : TksTableViewCheckMarkOptions;
begin
  if (ASource is TksTableViewCheckMarkOptions) then
  begin
    Src := TksTableViewCheckMarkOptions(ASource);

    FCheckMarks            := Src.FCheckMarks;
    FPosition              := Src.FPosition;
    FShowInHeader          := Src.FShowInHeader;
    FCheckArea             := Src.FCheckArea;
    FCheckSelects          := Src.FCheckSelects;
    FHeaderCheckSelectsAll := Src.FHeaderCheckSelectsAll;
  end
  else
    inherited;
end;

// ------------------------------------------------------------------------------

{ TksTableViewStickyHeaderOptions }

procedure TksTableViewStickyHeaderOptions.Changed;
begin
  FTableView.Invalidate;
end;

constructor TksTableViewStickyHeaderOptions.Create(ATableView: TksTableView);
begin
  inherited Create;
  FTableView := ATableView;
  FButton := TksTableViewStickyHeaderButton.Create(FTableView);
  FEnabled := True;
  FStickyHeight := 0;
end;



destructor TksTableViewStickyHeaderOptions.Destroy;
begin
  FreeAndNil(FButton);
  inherited;
end;

procedure TksTableViewStickyHeaderOptions.Assign(ASource: TPersistent);
var
  Src : TksTableViewStickyHeaderOptions;
begin
  if (ASource is TksTableViewStickyHeaderOptions) then
  begin
    Src := TksTableViewStickyHeaderOptions(ASource);

    FEnabled      := Src.FEnabled;
    FStickyHeight := Src.FStickyHeight;
    FButton.Assign(Src.FButton);
    FExtendScrollHeight := Src.FExtendScrollHeight;
  end
  else
    inherited;
end;

procedure TksTableViewStickyHeaderOptions.SetButton(const Value: TksTableViewStickyHeaderButton);
begin
  FButton.Assign(Value);
end;

procedure TksTableViewStickyHeaderOptions.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Changed;
  end;
end;

procedure TksTableViewStickyHeaderOptions.SetStickyHeight(const Value: single);
begin
  if FStickyHeight <> Value then
  begin
    FStickyHeight := Value;
    Changed;
  end;
end;

procedure TksTableViewStickyHeaderOptions.SetExtendScrollHeight(const Value: Boolean);
begin
  if FExtendScrollHeight <> Value then
  begin
    FExtendScrollHeight := Value;
    Changed;
  end;
end;

// ------------------------------------------------------------------------------

{ TksTableViewJumpToHeaderOptions }

constructor TksTableViewJumpToHeaderOptions.Create;
begin
  FHeaderFill      := TBrush.Create(TBrushKind.Solid, claWhite);
  FHeaderFont      := TFont.Create;
  FHeaderTextColor := claBlack;
  FHeaderHeight    := 32;
  FHeaderText      := '';
  FItemFill        := TBrush.Create(TBrushKind.Solid, claWhite);
  FItemFont        := TFont.Create;
  FItemTextColor   := claBlack;
  FItemHeight    := 32;
end;

destructor TksTableViewJumpToHeaderOptions.Destroy;
begin
  FreeAndNil(FHeaderFill);
  FreeAndNil(FHeaderFont);
  FreeAndNil(FItemFill);
  FreeAndNil(FItemFont);
  inherited;
end;

procedure TksTableViewJumpToHeaderOptions.Assign(ASource: TPersistent);
var
  Src : TksTableViewJumpToHeaderOptions;
begin
  if (ASource is TksTableViewJumpToHeaderOptions) then
  begin
    Src := TksTableViewJumpToHeaderOptions(ASource);

    FHeaderFill.Assign(Src.HeaderFill);
    FHeaderFont.Assign(Src.HeaderFont);

    FHeaderTextColor := Src.HeaderTextColor;
    FHeaderHeight    := Src.FHeaderHeight;
    FHeaderText      := Src.HeaderText;

    FItemFill.Assign(Src.ItemFill);
    FItemFont.Assign(Src.ItemFont);

    FItemTextColor := Src.ItemTextColor;
    FItemHeight    := Src.ItemHeight;
  end
  else
    inherited;
end;

// ------------------------------------------------------------------------------

{ TksTableViewStickyHeaderButton }

procedure TksTableViewStickyHeaderButton.Changed;
begin
  FTableView.Invalidate;
end;

constructor TksTableViewStickyHeaderButton.Create(ATableView: TksTableView);
begin
  inherited Create;
  FTableView := ATableView;
  FVisible := False;
  FButtonType := hbtJumpToHeader;
  FJumpToHeaderOptions := TksTableViewJumpToHeaderOptions.Create;
  FSelected := False;
end;

destructor TksTableViewStickyHeaderButton.Destroy;
begin
  FreeAndNil(FJumpToHeaderOptions);
  inherited;
end;

procedure TksTableViewStickyHeaderButton.Assign(ASource: TPersistent);
var
  Src : TksTableViewStickyHeaderButton;
begin
  if (ASource is TksTableViewStickyHeaderButton) then
  begin
    Src := TksTableViewStickyHeaderButton(ASource);

    FVisible := Src.FVisible;
    FHeaderTableViewBackground.Assign(Src.FHeaderTableViewBackground);
    FHeaderTableViewShadowEffect.Assign(Src.FHeaderTableViewShadowEffect);
    FButtonType := Src.FButtonType;
    FJumpToHeaderOptions.Assign(Src.FJumpToHeaderOptions);
    FSelected := Src.FSelected;
  end
  else
    inherited;
end;


procedure TksTableViewStickyHeaderButton.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

procedure TksTableViewStickyHeaderButton.SetButtonType(const Value: TksTableViewHeaderButtonType);
begin
  if FButtonType <> Value then
  begin
    FButtonType := Value;
    Changed;
  end;
end;

procedure TksTableViewStickyHeaderButton.SetJumpToHeaderOptions(const Value: TksTableViewJumpToHeaderOptions);
begin
  JumpToHeaderOptions.Assign(Value);
end;


procedure TksTableViewStickyHeaderButton.DoButtonClicked(Sender: TObject ; AItem: TksTableViewItem);
var
  I               : Integer;
  Form            : TCustomForm;
  ScreenPos       : TPointF;
  ButtonFormPos   : TPointF;
  BottomFormPos   : TPointF;
  AHeaderItem     : TksTableViewItem;
  TableViewHeight : Single;
begin
  FTableView.Invalidate;
  if FTableView.Root = nil then
    Exit;

  FSelected := true;

  if (FButtonType=hbtJumpToHeader) then
  begin
    if (FTableView.Root.GetObject is TCustomForm) then
    begin
      Form := TCustomForm(FTableView.Root.GetObject);

      ScreenPos     := FTableView.LocalToScreen(PointF(0, FTableView.FStickyButtonRect.Bottom));
      ButtonFormPos := Form.ScreenToClient(ScreenPos);

      ScreenPos     := FTableView.LocalToScreen(PointF(0, FTableView.Height));
      BottomFormPos := Form.ScreenToClient(ScreenPos);

      if FHeaderTableViewBackground = nil then
        FHeaderTableViewBackground := TRectangle.Create(Form);

      FHeaderTableViewBackground.Parent  := Form;
      FHeaderTableViewBackground.Opacity := 0;
      FHeaderTableViewBackground.OnClick := CancelPopup;
      FHeaderTableViewBackground.SetBounds(0,0,Form.Width,Form.Height);

      if FHeaderTableView = nil then
        FHeaderTableView                       := TksTableView.Create(Form);
      FHeaderTableView.ClearItems;
      FHeaderTableView.Parent                := Form;
      FHeaderTableView.BorderOptions.Visible := true;
      FHeaderTableView.ItemHeight            := 32;
      FHeaderTableView.PullToRefresh.Enabled := false;
      FHeaderTableView.OnItemClick           := JumpToHeaderClick;


      if FHeaderTableViewShadowEffect = nil then
        FHeaderTableViewShadowEffect := TShadowEffect.Create(Form);

      FHeaderTableViewShadowEffect.Parent    := FHeaderTableView;
      FHeaderTableViewShadowEffect.Distance  := 4;

      FHeaderTableView.BeginUpdate;

      if (FJumpToHeaderOptions.FHeaderText<>'') then
      begin
        with (FHeaderTableView.Items.AddHeader(FJumpToHeaderOptions.FHeaderText)) do
        begin
          Height := JumpToHeaderOptions.HeaderHeight;
          Fill.Assign(JumpToHeaderOptions.HeaderFill);
          Title.Font.Assign(JumpToHeaderOptions.HeaderFont);
          Title.TextColor := JumpToHeaderOptions.HeaderTextColor;
        end;
      end;

      for I:=0 to FTableView.FilteredItems.Count-1 do
      begin
        AHeaderItem := FTableView.FilteredItems[I];
        if (AHeaderItem.Purpose=Header) then
        begin
          with (FHeaderTableView.Items.AddItem(AHeaderItem.Title.Text)) do
          begin
            Height := JumpToHeaderOptions.ItemHeight;
            Fill.Assign(JumpToHeaderOptions.ItemFill);
            Title.Font.Assign(JumpToHeaderOptions.ItemFont);
            Title.TextColor := JumpToHeaderOptions.ItemTextColor;
          end;
        end;
      end;

      FHeaderTableView.EndUpdate;

      TableViewHeight := FHeaderTableView.GetTotalItemHeight;

      if (ButtonFormPos.Y + TableViewHeight > BottomFormPos.Y - 6) then
        TableViewHeight := BottomFormPos.Y - ButtonFormPos.Y - 6;

      FHeaderTableView.SetBounds(4,ButtonFormPos.Y,FTableView.Width-10,TableViewHeight);
    end;
  end;
end;

procedure TksTableViewStickyHeaderButton.CancelPopup(Sender: TObject);
begin
  FRemovePopupTimer := FTableView.CreateTimer(50,RemovePopup);
end;

procedure TksTableViewStickyHeaderButton.RemovePopup;
var
  Form : TCustomForm;
begin
  FTableView.KillTimer(FRemovePopupTimer);

  FSelected := False;
  FTableView.Invalidate;
  if (FTableView.Root.GetObject is TCustomForm) then
  begin
    Form := TCustomForm(FTableView.Root.GetObject);
    Form.RemoveObject(FHeaderTableViewShadowEffect);
    Form.RemoveObject(FHeaderTableView);
    Form.RemoveObject(FHeaderTableViewBackground);

    FreeAndNil(FHeaderTableViewShadowEffect);
    FreeAndNil(FHeaderTableView);
    FreeAndNil(FHeaderTableViewBackground);
  end;
end;

procedure TksTableViewStickyHeaderButton.JumpToHeaderClick(Sender: TObject; x, y: Single; AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
var
  I           : Integer;
  AHeaderItem : TksTableViewItem;
  NeedsUpdate : Boolean;
begin
  Sleep(100);
  NeedsUpdate := false;

  for I:=0 to FTableView.FilteredItems.Count-1 do
  begin
    AHeaderItem := FTableView.FilteredItems[I];

    if (AHeaderItem.Purpose=Header) then
    begin
      if (FTableView.HeaderOptions.StickyHeaders.StickyHeight>0) then
      begin
        if (AHeaderItem.FHeaderHeight<>FTableView.HeaderOptions.StickyHeaders.StickyHeight) then
        begin
          AHeaderItem.FHeaderHeight := FTableView.HeaderOptions.StickyHeaders.StickyHeight;
          NeedsUpdate := true;
        end;
      end;

      if (AHeaderItem.Title.Text=AItem.Title.Text) then
      begin
        if (NeedsUpdate) then
        begin
          FTableView.UpdateItemRects(false);
          FTableView.UpdateScrollingLimits;
        end;

        FTableView.ScrollTo(AHeaderItem.ItemRect.Top);
        break;
      end;
    end;
  end;
  CancelPopup(Nil);
end;

// ------------------------------------------------------------------------------

{ TksTableViewItemSwitch }

function TksTableViewItemSwitch.CreateControl: TStyledControl;
begin
  Result := TSwitch.Create(FTableItem.TableView);
  (Result as TSwitch).CanFocus := True;
  (Result as TSwitch).DisableFocusEffect := True;

  Fheight := (Result as TSwitch).DefaultSize.height;
  FWidth := (Result as TSwitch).DefaultSize.Width;
  {$IFDEF MSWINDOWS}
  Result.Width := 50;
  Result.Height := 30;
  {$ENDIF}
  FClickDelay := 0;
end;

procedure TksTableViewItemSwitch.DisableEvents;
begin
  GetSwitch.OnSwitch := nil;
end;

procedure TksTableViewItemSwitch.DoSwitchClicked(Sender: TObject);
begin
  if FClickDelay > 0 then
    Exit;
  FClickDelay := FTableItem.TableView.CreateTimer(250, DoSwitchClickedDelayed);
end;

procedure TksTableViewItemSwitch.DoSwitchClickedDelayed;
begin
  FTableItem.TableView.KillTimer(FClickDelay);
  FTableItem.TableView.DoSwitchClicked(FTableItem, Self);
end;

procedure TksTableViewItemSwitch.EnableEvents;
begin
  GetSwitch.OnSwitch := DoSwitchClicked;
end;

function TksTableViewItemSwitch.GetChecked: Boolean;
begin
  Result := GetSwitch.IsChecked;
end;

function TksTableViewItemSwitch.GetSwitch: TSwitch;
begin
  Result := (FControl as TSwitch);
end;

procedure TksTableViewItemSwitch.SetChecked(const Value: Boolean);
begin
  GetSwitch.IsChecked := Value;
end;

// ------------------------------------------------------------------------------

{ TksTableViewChatBubble }

constructor TksTableViewChatBubble.Create(ATableItem: TksTableViewItem);
begin
  inherited;
  FFont := TFont.Create;
  FShape := ksRoundRect;
  FFill.Color := claGray;
  FStroke.Kind := TBrushKind.None;
  FVertAlign := TksTableItemAlign.Center;
  FTextColor := claWhite;
  FPosition := ksCbpLeft;
end;

destructor TksTableViewChatBubble.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

procedure TksTableViewChatBubble.RecalculateSize;
begin
  FWidth := CalculateTextWidth(FText, FFont, False, FTableItem.TableView.Width * 0.60, 8)+24;
  FHeight := CalculateTextHeight(FText, FFont, True, TTextTrimming.None, FWidth, 8)+16;
end;

procedure TksTableViewChatBubble.Render(AItemRect: TRectF; ACanvas: TCanvas);
var
  ARect: TRectF;
  APath: TPathData;
begin
  inherited;
  ARect := ObjectRect;
  APath := TPathData.Create;
  try
    if FAlign = TksTableItemAlign.Leading then
    begin
      APath.MoveTo(PointF(ARect.Left-4, ARect.Bottom-2));
      APath.LineTo(PointF(ARect.Left+10, ARect.Bottom-6));
      APath.LineTo(PointF(ARect.Left+10, ARect.Bottom-18));
      APath.LineTo(PointF(ARect.Left-4, ARect.Bottom-2));
    end;
    if FAlign = TksTableItemAlign.Trailing then
    begin
      APath.MoveTo(PointF(ARect.Right+4, ARect.Bottom-2));
      APath.LineTo(PointF(ARect.Right-10, ARect.Bottom-6));
      APath.LineTo(PointF(ARect.Right-10, ARect.Bottom-18));
      APath.LineTo(PointF(ARect.Right+4, ARect.Bottom-2));
    end;
    ACanvas.Stroke.Color := claBlack;
    ACanvas.Fill.Color := FFill.Color;
    ACanvas.FillPath(APath, 1);
  finally
    FreeAndNil(APath);
  end;
  {$IFNDEF MSWINDOWS}
  OffsetRect(ARect, 8, 8);
  {$ENDIF}
  RenderText(ACanvas, ARect, FText, FFont, FTextColor, True, TTextAlign.Leading, TTextAlign.Center, TTextTrimming.None, 8);
end;

procedure TksTableViewChatBubble.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  RecalculateSize;
  Changed;
end;

procedure TksTableViewChatBubble.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    RecalculateSize;
    Changed;
  end;
end;

procedure TksTableViewChatBubble.SetTextColor(const Value: TAlphaColor);
begin
  if FTextColor <> Value then
  begin
    FTextColor := Value;
    Changed;
  end;
end;




initialization

  AIsSwiping := False;
  AccessoryImages := TksTableViewAccessoryImageList.Create;

finalization

 FreeAndNil(AccessoryImages);


end.









