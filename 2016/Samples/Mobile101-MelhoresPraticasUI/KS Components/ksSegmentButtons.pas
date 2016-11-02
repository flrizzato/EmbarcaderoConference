{*******************************************************************************
*                                                                              *
*  TksSegmentButtons - Segment button selection component                      *
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

unit ksSegmentButtons;

interface

{$I ksComponents.inc}

uses
  Classes, FMX.Types, FMX.Controls, FMX.Graphics, Types, System.UITypes,
  FMX.StdCtrls, System.Generics.Collections, FMX.Objects, FMX.Effects,
  System.UIConsts, ksSpeedButton, ksTypes;

type
  TksSegmentButton = class;
  TksSegmentButtons = class;

  TksSelectSegmentButtonEvent = procedure(Sender: TObject; AIndex: integer; AButton: TksSegmentButton) of object;


  TksSegmentSpeedButton = class(TksSpeedButton)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TKsSegmentButton = class(TCollectionItem)
  private
    FButton: TksSegmentSpeedButton;
    FID: string;
    FText: string;
    procedure SetText(const Value: string);
    function GetBadgeValue: integer;
    procedure SetBadgeValue(const Value: integer);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property ID: string read FID write FID;
    property Text: string read FText write SetText;
    property BadgeValue: integer read GetBadgeValue write SetBadgeValue;
  end;

  TksSegmentButtonCollection = class(TCollection)
  private
    FSegmentButtons: TKsSegmentButtons;
  protected
    function GetOwner: TPersistent; override;
    function GetItem(Index: Integer): TKsSegmentButton;
    procedure SetItem(Index: Integer; Value: TKsSegmentButton);
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AButtons: TKsSegmentButtons);
    function Add: TKsSegmentButton;
    function Insert( Index: Integer ): TKsSegmentButton;
    property Items[index: Integer]: TKsSegmentButton read GetItem write SetItem; default; // default - Added by Fenistil
  end;


  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or
    {$IFDEF XE8_OR_NEWER} pidiOSDevice32 or pidiOSDevice64
    {$ELSE} pidiOSDevice {$ENDIF} or pidiOSSimulator or pidAndroid)]
  TksSegmentButtons = class(TksControl)
  private
    FGroupID: string;
    FItemIndex: integer;
    FBtnWidth: single;
    FOnChange: TNotifyEvent;
    FSegments: TksSegmentButtonCollection;
    FTintColor: TAlphaColor;
    FBackgroundColor: TAlphaColor;
    FOnSelectSegment: TksSelectSegmentButtonEvent;
    procedure UpdateButtons;
    procedure SetItemIndex(const Value: integer);
    procedure SetSegments(const Value: TksSegmentButtonCollection);
    procedure SetBackgroundColor(const Value: TAlphaColor);
    procedure SetTintColor(const Value: TAlphaColor);
    function GetSelected: TKsSegmentButton;
    function GetSelectedID: string;
    procedure SetSelectedID(const Value: string);
  protected
    procedure Resize; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Selected: TKsSegmentButton read GetSelected;
    property SelectedID: string read GetSelectedID write SetSelectedID;
  published
    property Align;
    property ItemIndex: integer read FItemIndex write SetItemIndex default -1;
    property Margins;
    property Position;
    property Width;
    property TintColor: TAlphaColor read FTintColor write SetTintColor default claNull;
    property BackgroundColor: TAlphaColor read FBackgroundColor write SetBackgroundColor default claNull;
    property Segments: TksSegmentButtonCollection read FSegments write SetSegments;
    property Size;
    property Height;
    property Visible;
    // events
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnSelectSegment: TksSelectSegmentButtonEvent read FOnSelectSegment write FOnSelectSegment;
  end;

  {$R *.dcr}

  procedure Register;


implementation

uses SysUtils,  Math;

procedure Register;
begin
  RegisterComponents('Kernow Software FMX', [TksSegmentButtons]);
end;

{ TKsSegmentButton }

procedure TKsSegmentButton.Assign(Source: TPersistent);
begin
  if (Source is TKsSegmentButton) then
  begin
    FID := (Source as TKsSegmentButton).ID;
    FText := (Source as TKsSegmentButton).Text;
  end;
end;


constructor TKsSegmentButton.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FButton := TksSegmentSpeedButton.Create((Collection as TksSegmentButtonCollection).FSegmentButtons);
end;

destructor TKsSegmentButton.Destroy;
begin
  {$IFDEF NEXTGEN}
  FButton.DisposeOf;
  {$ELSE}
  FButton.Free;
  {$ENDIF}
  inherited;
end;

function TKsSegmentButton.GetBadgeValue: integer;
begin
  Result := FButton.Badge.Value;
end;

procedure TKsSegmentButton.SetBadgeValue(const Value: integer);
begin
  FButton.Badge.Value := Value;
end;

procedure TKsSegmentButton.SetText(const Value: string);
begin
  FText := Value;
  (Collection as TksSegmentButtonCollection).FSegmentButtons.UpdateButtons;

end;

{ TksSegmentButtons }


procedure TksSegmentButtons.Assign(Source: TPersistent);
begin
  if (Source is TksSegmentButtons) then
  begin
    FGroupID := (Source as TksSegmentButtons).FGroupID;
    FItemIndex := (Source as TksSegmentButtons).FItemIndex;
    FBtnWidth := (Source as TksSegmentButtons).FBtnWidth;
    FOnChange := (Source as TksSegmentButtons).FOnChange;
    FTintColor := (Source as TksSegmentButtons).FTintColor;
    FBackgroundColor := (Source as TksSegmentButtons).FBackgroundColor;
    FSegments.Assign((Source as TksSegmentButtons).Segments);
  end;
end;

constructor TksSegmentButtons.Create(AOwner: TComponent);
var
  AGuid: TGUID;
begin
  inherited;
  FSegments := TksSegmentButtonCollection.Create(Self);
  SetAcceptsControls(False);
  CreateGUID(AGuid);
  FGroupID := AGuid.ToString;
  FGroupID := StringReplace(FGroupID, '{', '', [rfReplaceAll]);
  FGroupID := StringReplace(FGroupID, '-', '', [rfReplaceAll]);
  FGroupID := StringReplace(FGroupID, '}', '', [rfReplaceAll]);
  FBackgroundColor := claNull;
  FTintColor := claNull;
  Size.Height := 50;
  Size.Width := 300;
end;

destructor TksSegmentButtons.Destroy;
begin
  FreeAndNil(FSegments);
  inherited;
end;

function TksSegmentButtons.GetSelected: TKsSegmentButton;
begin
  Result := nil;
  if (FItemIndex > -1) and (FItemIndex < FSegments.Count) then
    Result := FSegments[FItemIndex];
end;

function TksSegmentButtons.GetSelectedID: string;
begin
  Result := '';
  if Selected <> nil then
    Result := Selected.ID;
end;

procedure TksSegmentButtons.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  ItemIndex := Trunc(X / FBtnWidth);
end;

procedure TksSegmentButtons.Paint;
begin
  inherited;
  if (csDesigning in ComponentState) then
  begin
    DrawDesignBorder(claDimgray, claDimgray);
    if FSegments.Count = 0 then
      Canvas.FillText(ClipRect, 'Add "Segments" in the Object Inspector', True, 1, [], TTextAlign.Center);
  end;
  if FSegments.Count > 0 then
  begin
    if Height <> (FSegments[0].FButton.Height + 16) then
    begin
      Height := FSegments[0].FButton.Height + 16;
      UpdateExplicitBounds;
    end;
  end;
end;

procedure TksSegmentButtons.Resize;
begin
  inherited;
  UpdateButtons;
end;

procedure TksSegmentButtons.UpdateButtons;
var
  ICount: integer;
begin
  if FSegments.Count = 0 then
    Exit;
  FBtnWidth := (Width-16) / FSegments.Count;
  for ICount := 0 to FSegments.Count-1 do
  begin
    if Assigned(FSegments[ICount].FButton) then
    begin
      if ContainsObject(FSegments[ICount].FButton) = False then
        AddObject(FSegments[ICount].FButton);

      with FSegments[ICount].FButton do
      begin
        StaysPressed := True;
        GroupName := FGroupID;
        Width := FBtnWidth;
        TintColor := FTintColor;
        if FItemIndex = ICount then
          TextSettings.FontColor := FBackgroundColor
        else
          TextSettings.FontColor := FTintColor;
        IsPressed := (ICount = FItemIndex);
        Text := FSegments[ICount].Text;
        {$IFDEF ANDROID}
        StyleLookup := 'listitembutton';
        Height := 30;
        {$ELSE}
        if ICount = 0 then StyleLookup := 'segmentedbuttonleft';
        if ICount > 0 then StyleLookup := 'segmentedbuttonmiddle';
        if ICount = FSegments.Count-1 then StyleLookup := 'segmentedbuttonright';
        if FSegments.Count = 1 then StyleLookup := 'listitembutton';
        {$ENDIF}
        Position.Y := (Self.Height - Height) / 2;
        Position.X := (ICount * FBtnWidth)+8;
      end;
    end;
  end;
end;

procedure TksSegmentButtons.SetBackgroundColor(const Value: TAlphaColor);
begin
  FBackgroundColor := Value;
  UpdateButtons;
end;

procedure TksSegmentButtons.SetItemIndex(const Value: integer);
begin
  if FItemIndex <> Value then
  begin

    FItemIndex := Value;
    UpdateButtons;

    if Assigned(FOnChange) then
      FOnChange(Self);
    if FItemIndex > -1 then
    begin
      if Assigned(FOnSelectSegment) then
        FOnSelectSegment(Self, FItemIndex, Segments[FItemIndex]);
    end;
  end;
end;

procedure TksSegmentButtons.SetSegments(const Value: TksSegmentButtonCollection);
begin
  FSegments.Assign(Value);
end;

procedure TksSegmentButtons.SetSelectedID(const Value: string);
var
  ICount: integer;
begin
  for ICount := 0 to Segments.Count-1 do
  begin
    if Segments[ICount].ID = Value then
    begin
      ItemIndex := ICount;
      Exit;
    end;
  end;
  ItemIndex := -1;
end;

procedure TksSegmentButtons.SetTintColor(const Value: TAlphaColor);
begin
  FTintColor := Value;
  UpdateButtons;
end;

{ TksSegmentButtonCollection }

function TksSegmentButtonCollection.Add: TKsSegmentButton;
begin
  Result := inherited Add as TKsSegmentButton;
  FSegmentButtons.UpdateButtons;
end;

constructor TksSegmentButtonCollection.Create(AButtons: TKsSegmentButtons);
begin
  inherited Create(TKsSegmentButton);
  FSegmentButtons := AButtons;
end;

function TksSegmentButtonCollection.GetItem(Index: Integer): TKsSegmentButton;
begin
  Result := inherited Items[index] as TKsSegmentButton;
end;

function TksSegmentButtonCollection.GetOwner: TPersistent;
begin
  Result := FSegmentButtons;
end;

function TksSegmentButtonCollection.Insert(Index: Integer): TKsSegmentButton;
begin
  Result := inherited insert( index ) as TKsSegmentButton;
  FSegmentButtons.UpdateButtons;
end;

procedure TksSegmentButtonCollection.SetItem(Index: Integer; Value: TKsSegmentButton);
begin
  inherited SetItem(index, Value);
end;

procedure TksSegmentButtonCollection.Update(Item: TCollectionItem);
begin
  inherited;
  (Owner as TksSegmentButtons).UpdateButtons;
end;

{ TksSegmentSpeedButton }

constructor TksSegmentSpeedButton.Create(AOwner: TComponent);
begin
  inherited;
  Locked := True;
  Stored := False;
  HitTest := False;
  StyledSettings := [];
end;

end.
