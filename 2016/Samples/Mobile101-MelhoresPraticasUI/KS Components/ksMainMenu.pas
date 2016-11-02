{*******************************************************************************
*                                                                              *
*  TksMainMenu - menu compoonent                                                *
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


unit ksMainMenu;

interface

{$I ksComponents.inc}

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, ksTableView, FMX.Graphics,
  System.Types, System.Generics.Collections, System.UITypes, ksTypes
  {$IFDEF XE8_OR_NEWER}
  , FMX.ImgList
  {$ENDIF}
  ;

type
  TksMainMenu = class;

  TksMenuLayout = (mlTiles, mlList);

  TksMenuOptionClickEvent = procedure(Sender: TObject; AIndex: integer; AID: string) of object;

  TksMainMenuOptionItem = class
  private
    FBitmap: TBitmap;
    FText: string;
    FId: string;
    FFill: TAlphaColor;
    procedure SetBitmap(const Value: TBitmap);
    procedure SetText(const Value: string);
    procedure SetFill(const Value: TAlphaColor);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property Text: string read FText write SetText;
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property ID: string read FId write FId;
    property Fill: TAlphaColor read FFill write SetFill;
  end;

  TksMainMenuOptionItemList = class(TObjectList<TksMainMenuOptionItem>)
  private
    FMainMenu: TksMainMenu;
  public
    constructor Create(AMainMenu: TksMainMenu);
    procedure AddOption(AText, AId: string; AImage: TBitmap); overload;
    {$IFDEF XE8_OR_NEWER}
    procedure AddOption(AText, AId: string; AImageIndex: integer); overload;
    {$ENDIF}
  end;


  TksMainMenuTileOptions = class(TPersistent)
  private
    [weak]FMainMenu: TksMainMenu;
    FTileRows: integer;
    FTileColumns: integer;
    FTilePadding: integer;
    FShowCaptions: Boolean;
    FShadows: Boolean;
    procedure SetShowCaptions(const Value: Boolean);
    procedure SetTileColumns(const Value: integer);
    procedure SetTilePadding(const Value: integer);
    procedure SetTileRows(const Value: integer);
    procedure RecreateMenu;
    procedure SetShadows(const Value: Boolean);
  public
    constructor Create(AMainMenu: TksMainMenu);

  published
    property TileRows: integer read FTileRows write SetTileRows default 3;
    property TileColumns: integer read FTileColumns write SetTileColumns default 2;
    property TilePadding: integer read FTilePadding write SetTilePadding default 10;
    property ShowCaptions: Boolean read FShowCaptions write SetShowCaptions default True;
    property Shadows: Boolean read FShadows write SetShadows default True;

  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or
    {$IFDEF XE8_OR_NEWER} pidiOSDevice32 or pidiOSDevice64
    {$ELSE} pidiOSDevice {$ENDIF} or pidiOSSimulator or pidAndroid)]
  TksMainMenu = class(TksControl)
  private
    FTableView: TksTableView;
    FLayout: TksMenuLayout;
    FPainting: Boolean;
    FTileOptions: TksMainMenuTileOptions;
    FItems: TksMainMenuOptionItemList;
    {$IFDEF XE8_OR_NEWER}
    FImages: TImageList;
    {$ENDIF}
    FOnOptionClicked: TksMenuOptionClickEvent;
    procedure SetLatout(const Value: TksMenuLayout);
    procedure RecreateMenu;
    procedure SetTileOptions(const Value: TksMainMenuTileOptions);
    procedure DrawTileOutline(ACanvas: TCanvas; ACol, ARow: integer);
    procedure GetTileRects(ACol, ARow: integer; var ATile, AGraphic, AText: TRectF);
    procedure ClickTile(Sender: TObject; x, y: single; AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
    procedure ClickItem(Sender: TObject; x, y: single; AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
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
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Items: TksMainMenuOptionItemList read FItems;
    { Public declarations }
  published
    property Align;
    property Background: TBrush read GetBackground write SetBackground;
    {$IFDEF XE8_OR_NEWER}
    property Images: TImageList read FImages write SetImages;
    {$ENDIF}
    property Layout: TksMenuLayout read FLayout write SetLatout default mlTiles;
    property TileOptions: TksMainMenuTileOptions read FTileOptions write SetTileOptions;
    property Position;
    property Size;
    property OnOptionClicked: TksMenuOptionClickEvent read FOnOptionClicked write FOnOptionClicked;
    { Published declarations }
  end;

  {$R *.dcr}

  procedure Register;

implementation

uses System.UIConsts, Math, FMX.MultiResBitmap, FMX.Forms;

procedure Register;
begin
  RegisterComponents('Kernow Software FMX', [TksMainMenu]);
end;

{ TksMainMenu }

procedure TksMainMenu.ClickItem(Sender: TObject; x, y: single; AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
begin
  if Assigned(FOnOptionClicked) then
  begin
    FOnOptionClicked(Self, AItem.Index, AId);
  end;
end;

procedure TksMainMenu.ClickTile(Sender: TObject; x, y: single; AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
begin
  if (ARowObj is TksTableViewItemImage)  then
  begin
    Application.ProcessMessages;
    Sleep(100);
    if Assigned(FOnOptionClicked) then
    begin

      FOnOptionClicked(Self, AItem.Index, ARowObj.ID);
    end;
  end;
end;

constructor TksMainMenu.Create(AOwner: TComponent);
begin
  inherited;
  FTableView := TksTableView.Create(Self);
  FTileOptions := TksMainMenuTileOptions.Create(Self);
  FItems := TksMainMenuOptionItemList.Create(Self);
  FTableView.Stored := False;
  FTableView.Align := TAlignLayout.Client;
  FTableView.Visible := False;
  AddObject(FTableView);
  FPainting := False;
  FTableView.PullToRefresh.Enabled := False;
end;

destructor TksMainMenu.Destroy;
begin
  FTableView.DisposeOf;
  FreeAndNil(FTileOptions);
  FreeAndNil(FItems);
  inherited;
end;

function TksMainMenu.GetBackground: TBrush;
begin
  Result := FTableView.Appearence.Background;
end;

function TksMainMenu.GetColWidth: single;
begin
  Result := (Width / FTileOptions.TileColumns);
end;

function TksMainMenu.GetRowHeight: single;
begin
  Result := (Height / FTileOptions.FTileRows);
end;

procedure TksMainMenu.GetTileRects(ACol, ARow: integer; var ATile: TRectF; var AGraphic: TRectF; var AText: TRectF);
var
  AWidth, AHeight: Single;
begin
  AWidth := GetColWidth;
  AHeight := GetRowHeight;
  ATile := RectF(0, 0, AWidth, AHeight);
  InflateRect(ATile, 0-FTileOptions.TilePadding, 0-FTileOptions.TilePadding);

  OffsetRect(ATile, (ACol-1) * AWidth, (ARow-1)*AHeight);

  AGraphic := ATile;
  AGraphic.Height := ATile.Height - 30;

  OffsetRect(AGraphic, (ATile.Width - AGraphic.Width) / 2, 0);

  AText := AGraphic;
  AText.Top := AGraphic.Bottom;
  AText.Bottom := ATile.Bottom;
end;

function TksMainMenu.GetTileRowCount: integer;
begin
  Result := Round((FItems.Count / FTileOptions.TileColumns) + 0.5);
end;

procedure TksMainMenu.DrawTileOutline(ACanvas: TCanvas; ACol, ARow: integer);
var
  r1, r2, r3: TRectF;
begin
  GetTileRects(ACol, ARow, r1, r2, r3);
  ACanvas.Stroke.Color := claSilver;
  ACanvas.Stroke.Kind := TBrushKind.Solid;
  ACanvas.StrokeDash := TStrokeDash.Solid;
  ACanvas.StrokeThickness := 1;
  ACanvas.DrawRect(r1, 0, 0, AllCorners, 1);
  ACanvas.DrawRect(r2, 0, 0, AllCorners, 1);
  ACanvas.DrawRect(r3, 0, 0, AllCorners, 1);
end;

procedure TksMainMenu.Paint;
var
  ICountX, ICountY: integer;
begin
  if (csDesigning in ComponentState) then
  begin
    if not FPainting then
    begin
      FPainting := True;
      try

        // design-time border
        Canvas.Stroke.Color := claBlack;
        Canvas.Stroke.Dash := TStrokeDash.Dash;
        Canvas.StrokeThickness := 1;
        Canvas.DrawRect(RectF(0, 0, Width, Height), 0, 0, AllCorners, 1);


        Canvas.Fill.Assign(FTableView.Appearence.Background);
        Canvas.FillRect(RectF(0, 0, Width, Height), 0, 0, AllCorners, 1);

        if FLayout = mlTiles then
        begin
          for ICountY := 1 to FTileOptions.TileRows do
          begin
            for ICountX := 1 to FTileOptions.TileColumns do
            begin
              DrawTileOutline(Canvas, ICountX, ICountY);
            end;
          end;
        end;
      finally
        FPainting := False;
      end;
    end;
  end;
end;

procedure TksMainMenu.RecreateMenu;
var
  ICount: integer;
  AItem: TksTableViewItem;
  r1, r2, r3: TRectF;
  ACol, ARow: integer;
  AText: TksTableViewItemText;
  AImage: TksTableViewItemImage;
  //ABackground: TksTableViewItemShape;
begin
  if (csDesigning in ComponentState) then
    Exit;
  FTableView.Visible := True;

  FTableView.BeginUpdate;
  try
    FTableView.ClearItems;

    if FLayout = mlTiles then
    begin
      //AItem := FTableView.Items.AddItem('');
      FTableView.ItemHeight := Round(Max(GetTileRowCount * GetRowHeight, Height));

      FTableView.SelectionOptions.ShowSelection := False;

      AItem := FTableView.Items.AddItem('');
      AItem.CanSelect := False;
      ACol := 1;
      ARow := 1;
      FTableView.Appearence.SeparatorColor := claNull;
      FTableView.AccessoryOptions.ShowAccessory := False;
      for ICount := 1 to FItems.Count do
      begin
        GetTileRects(ACol, ARow, r1, r2, r3);

        //ABackground := AItem.DrawRect(RectF(0, 0, 20, 20), claBlack, claRed);//FItems[Icount].Fill);

        AImage := AItem.DrawBitmap(FItems[ICount-1].Bitmap, r2);
        AImage.ShowSelection := True;
        AImage.ID := FItems[ICount-1].ID;
        AImage.VertAlign := TksTableItemAlign.Leading;
        AImage.DrawMode := ksDrawModeFit;
        AImage.Shadow.Visible := True;
        AImage.Shadow.Offset := 3;
        FTableView.OnItemClick := ClickTile;

        AText := AItem.TextOut(FItems[ICount-1].Text, r3.Left, r3.Top, r3.Width, TksTableItemAlign.Leading);
        AText.Height := r3.Height;
        AText.TextAlignment := TTextAlign.Center;
        AText.TextVertAlign := TTextAlign.Center;
        if ACol = FTileOptions.TileColumns then
        begin
          Inc(ARow);
          ACol := 1;
        end
        else
          Inc(ACol);
      end;
    end
    else
    begin
      FTableView.SelectionOptions.ShowSelection := True;
      FTableView.ItemHeight := 50;

      FTableView.ItemImageSize := 32;
      FTableView.AccessoryOptions.ShowAccessory := True;
      FTableView.Appearence.SeparatorColor := $FFF0F0F0;
      FTableView.OnItemClick := ClickItem;
      for ICount := 0 to FItems.Count-1 do
      begin
        AItem := FTableView.Items.AddItem(FItems[ICount].Text, '', '', atMore);
        AItem.ID := FItems[ICount].ID;
        AItem.Image.Bitmap := FItems[ICount].Bitmap;
      end;

    end;
  finally
    FTableView.EndUpdate
  end;
end;

procedure TksMainMenu.Resize;
begin
  inherited;
  RecreateMenu;
end;

procedure TksMainMenu.SetBackground(const Value: TBrush);
begin
  FTableView.Appearence.Background := Value;
end;

{$IFDEF XE8_OR_NEWER}

procedure TksMainMenu.SetImages(const Value: TImageList);
begin
  FImages := Value;
end;

{$ENDIF}

procedure TksMainMenu.SetLatout(const Value: TksMenuLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    RecreateMenu;
  end;
end;

procedure TksMainMenu.SetTileOptions(const Value: TksMainMenuTileOptions);
begin
  FTileOptions.Assign(Value);
end;

{ TksMainMenuTileOptions }

constructor TksMainMenuTileOptions.Create(AMainMenu: TksMainMenu);
begin
  inherited Create;
  FMainMenu := AMainMenu;
  FTileColumns := 2;
  FTileRows := 3;
  FTilePadding := 10;
  FShowCaptions := True;
  FShadows := True;
end;

procedure TksMainMenuTileOptions.RecreateMenu;
begin
  FMainMenu.RecreateMenu;
end;

procedure TksMainMenuTileOptions.SetShadows(const Value: Boolean);
begin
  if FShadows <> Value then
  begin
    FShadows := Value;
    RecreateMenu;
  end;
end;

procedure TksMainMenuTileOptions.SetShowCaptions(const Value: Boolean);
begin
  FShowCaptions := Value;
end;

procedure TksMainMenuTileOptions.SetTileColumns(const Value: integer);
begin
  if FTileColumns <> Value then
  begin
    FTileColumns := Value;
    if FTileColumns < 1 then
      FTileColumns := 1;
    RecreateMenu;
  end;
end;

procedure TksMainMenuTileOptions.SetTilePadding(const Value: integer);
begin
  if FTilePadding <> Value then
  begin
    FTilePadding := Value;
    RecreateMenu;
  end;
end;

procedure TksMainMenuTileOptions.SetTileRows(const Value: integer);
begin
  if FTileRows <> Value then
  begin
    FTileRows := Value;
    if FTileRows < 1 then
      FTileRows := 1;
    RecreateMenu;
  end;
end;

{ TksMainMenuOptionItem }

constructor TksMainMenuOptionItem.Create;
begin
  inherited Create;
  FBitmap := TBitmap.Create;
  FText := '';
  FId := '';
end;

destructor TksMainMenuOptionItem.Destroy;
begin
  FreeAndNil(FBitmap);
  inherited;
end;

procedure TksMainMenuOptionItem.SetBitmap(const Value: TBitmap);
begin
  FBitmap.Assign(Value);
end;

procedure TksMainMenuOptionItem.SetFill(const Value: TAlphaColor);
begin
  FFill := Value;

end;

procedure TksMainMenuOptionItem.SetText(const Value: string);
begin
  FText := Value;

end;

{ TksMainMenuOptionItemList }

procedure TksMainMenuOptionItemList.AddOption(AText, AId: string; AImage: TBitmap);
var
  AItem: TksMainMenuOptionItem;
begin
  AItem := TksMainMenuOptionItem.Create;
  AItem.Text := AText;
  AItem.Bitmap := AImage;
  AItem.ID := AID;
  Add(AItem);
  FMainMenu.RecreateMenu;
end;

{$IFDEF XE8_OR_NEWER}

procedure TksMainMenuOptionItemList.AddOption(AText, AId: string; AImageIndex: integer);
var
  ABmp: TCustomBitmapItem;
begin
  ABmp := FMainMenu.Images.Source[AImageIndex].MultiResBitmap.ItemByScale(1, False, False);
  AddOption(AText, AId, ABmp.Bitmap);
end;

{$ENDIF}

constructor TksMainMenuOptionItemList.Create(AMainMenu: TksMainMenu);
begin
  inherited Create(True);
  FMainMenu := AMainMenu;
end;

end.
