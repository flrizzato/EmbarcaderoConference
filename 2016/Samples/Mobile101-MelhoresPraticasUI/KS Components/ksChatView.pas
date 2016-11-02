{*******************************************************************************
*                                                                              *
*  TksChatView - TksTableView wrapper for chat bubbles applications            *
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

unit ksChatView;

interface

{$I ksComponents.inc}

uses System.UITypes, FMX.Controls, FMX.Layouts, FMX.Objects, System.Classes,
  FMX.Types, Generics.Collections, FMX.Graphics, System.UIConsts, FMX.Effects,
  FMX.StdCtrls, System.Types, FMX.Forms, ksTableView, FMX.Edit,
  FMX.VirtualKeyboard, System.Messaging, ksTypes;


type
  TksChatView = class;


  TksChatBubbleInfo = record
    Text: string;
    APosition: TksTableViewChatBubblePosition;
    Color: TAlphaColor;
    TextColor: TAlphaColor;
    TableViewItem: TksTableViewItem;
  end;

  TKsChatViewClickBubbleEvent = procedure(Sender: TObject; ABubble: TksChatBubbleInfo) of object;
  TksChatViewPostText = procedure(Sender: TObject; var ABubble: TksChatBubbleInfo; var AAllowPost: Boolean) of object;

  TksChatViewEdit = class(TToolBar)
  private
    FEdit: TEdit;
    FSendButton: TButton;
    procedure EnterEdit(Sender: TObject);
    procedure SendButtonClick(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure DoSendButtonClick;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Edit: TEdit read FEdit;
    property Button: TButton read FSendButton;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or
    {$IFDEF XE8_OR_NEWER} pidiOSDevice32 or pidiOSDevice64
    {$ELSE} pidiOSDevice {$ENDIF} or pidiOSSimulator or pidAndroid)]
  TksChatView = class(TksControl)
  private
    FTableView: TksTableView;
    FEdit: TksChatViewEdit;
    FMyImage: TBitmap;
    FSpacer: TLayout;
    FBeforePostText: TksChatViewPostText;
    FEditVisible: Boolean;
    FButtonText: string;
    FOnSendButtonClick: TksChatViewPostText;
    FShowDoneButton: Boolean;
    FOnChatBubbleClick: TKsChatViewClickBubbleEvent;
    procedure SetEditVisible(const Value: Boolean);
    procedure SetMyImage(const Value: TBitmap);
    procedure VirtualKeyboardChangeHandler(const Sender: TObject; const Msg: System.Messaging.TMessage);
    procedure SetButtonText(const Value: string);

    procedure SetShowDoneButton(const Value: Boolean);
    procedure DoChatViewClick(Sender: TObject; x, y: single; AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
  protected
    procedure Paint; override;
    procedure DoSendButtonClick;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddChatBubble(AText: string;
                            APosition: TksTableViewChatBubblePosition;
                            AColor, ATextColor: TAlphaColor;
                            const AUserImage: TBitmap);
    procedure Clear;
    procedure ClearEdit;
    procedure ScrollToTop;
    procedure ScrollToEnd;
  published
    property Align;
    property ButtonText: string read FButtonText write SetButtonText;
    property MyImage: TBitmap read FMyImage write SetMyImage;
    property EditVisible: Boolean read FEditVisible write SetEditVisible default True;
    property Position;
    property ShowDoneButton: Boolean read FShowDoneButton write SetShowDoneButton default False;
    property Size;

    // events...
    property OnSendButtonClick: TksChatViewPostText read FOnSendButtonClick write FOnSendButtonClick;
    property BeforePostText: TksChatViewPostText read FBeforePostText write FBeforePostText;
    property OnChatBubbleClick: TKsChatViewClickBubbleEvent read FOnChatBubbleClick write FOnChatBubbleClick;
  end;

  {$R *.dcr}

  procedure Register;

implementation

uses SysUtils, FMX.Platform, FMX.Ani, FMX.Dialogs;

procedure Register;
begin
  RegisterComponents('Kernow Software FMX', [TksChatView]);
end;

{ TksChatView }

procedure TksChatView.AddChatBubble(AText: string; APosition: TksTableViewChatBubblePosition; AColor, ATextColor: TAlphaColor; const AUserImage: TBitmap);
var
  AInfo: TksChatBubbleInfo;
  AAllow: Boolean;
begin
  AAllow := True;
  AInfo.Text := AText;
  AInfo.Color := AColor;
  AInfo.TextColor := ATextColor;
  if Assigned(FBeforePostText) then
    FBeforePostText(Self, AInfo, AAllow);

  if not AAllow then
    Exit;

  FTableView.Items.AddChatBubble(AInfo.Text, APosition, AInfo.Color, AInfo.TextColor, AUserImage);

  FTableView.ScrollToItem(FTableView.Items.LastItem, True);
end;

procedure TksChatView.Clear;
begin
  FTableView.ClearItems;
end;

procedure TksChatView.ClearEdit;
begin
  FEdit.Edit.Text := '';
end;

procedure TksChatView.VirtualKeyboardChangeHandler(const Sender: TObject;
  const Msg: System.Messaging.TMessage);
var
  AKeyboardBounds: TRect;
begin
  if TVKStateChangeMessage(Msg).KeyboardVisible then
  begin
    AKeyboardBounds := TVKStateChangeMessage(Msg).KeyboardBounds;

    FSpacer.Height := AKeyboardBounds.Height - ((Root.GetObject as TCommonCustomForm).Height - FSpacer.AbsoluteRect.Bottom);
  end
  else
    FSpacer.Height := 0;
end;

constructor TksChatView.Create(AOwner: TComponent);
var
  VKToolbar: IFMXVirtualKeyboardToolbarService;
begin
  inherited;
  FTableView := nil;
  FEdit := nil;
  FSpacer := nil;
  FMyImage := TBitmap.Create;
  if not (csDesigning in ComponentState) then
  begin
    FTableView := TksTableView.Create(Self);
    FEdit := TksChatViewEdit.Create(Self);
    FSpacer := TLayout.Create(Self);
    FTableView.OnItemClick := DoChatViewClick;

    FTableView.Appearence.SeparatorColor := claNull;
    FTableView.SelectionOptions.ShowSelection := False;
    FTableView.Align := TAlignLayout.Client;

    FSpacer.Align := TAlignLayout.MostBottom;
    FSpacer.Height := 0;

    {FTableView.Stored := False;
    FEdit.Stored := False;
    FSpacer.Stored := False; }

    FEdit.Align := TAlignLayout.Bottom;
    AddObject(FTableView);
    AddObject(FEdit);
    AddObject(FSpacer);

    TMessageManager.DefaultManager.SubscribeToMessage(TVKStateChangeMessage, VirtualKeyboardChangeHandler);

    // hide the done button
    FShowDoneButton := False;
    if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardToolbarService, IInterface(VKToolbar)) then
      VKToolbar.SetToolbarEnabled(False);
  end;
  FEditVisible := True;
  FButtonText := 'SEND';

  Size.Width := 200;
  Size.Height := 300;

end;

destructor TksChatView.Destroy;
begin
  if not (csDesigning in ComponentState) then
  begin
    FTableView.DisposeOf;
    FEdit.DisposeOf;
    FSpacer.DisposeOf;
  end;
  FreeAndNil(FMyImage);
  inherited;
end;

procedure TksChatView.DoChatViewClick(Sender: TObject; x, y: single; AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
var
  ABubble: TksTableViewChatBubble;
  AInfo: TksChatBubbleInfo;
begin
  if (ARowObj is TksTableViewChatBubble) then
  begin
    ABubble := (ARowObj as TksTableViewChatBubble);
    if Assigned(FOnChatBubbleClick) then
    begin
      AInfo.Text := ABubble.Text;
      AInfo.APosition := ABubble.Position;
      AInfo.Color := ABubble.Fill.Color;
      AInfo.TextColor := ABubble.TextColor;
      AInfo.TableViewItem := AItem;
      FOnChatBubbleClick(Self, AInfo);
    end;
  end;
end;

procedure TksChatView.DoSendButtonClick;
var
  AInfo: TksChatBubbleInfo;
  AAllow: Boolean;
begin
  AAllow := True;
  AInfo.Text := FEdit.FEdit.Text;
  AInfo.Color := claDodgerblue;
  AInfo.TextColor := claWhite;

  if Assigned(FOnSendButtonClick) then
  begin
    FOnSendButtonClick(Self, AInfo, AAllow);
    if AAllow = False then
      Exit;
  end;
  AddChatBubble(AInfo.Text, ksCbpLeft, AInfo.Color, AInfo.TextColor, FMyImage);
  FEdit.Edit.Text := '';
end;

procedure TksChatView.Paint;
var
  AToolbarHeight: integer;
  AEditRect: TRectF;
  ABtnRect: TRectF;
  AState: TCanvasSaveState;
begin
  inherited;
  AToolbarHeight := 40;
  if (csDesigning in ComponentState) then
  begin
    AEditRect := RectF(8, Height-(AToolbarHeight-8), Width - 70, Height-8);
    ABtnRect := RectF((Width-70)+8, Height-(AToolbarHeight-8), Width-8, Height-8);

    AState := Canvas.SaveState;
    try
      Canvas.IntersectClipRect(RectF(0, 0, Width, Height));
      Canvas.Fill.Color := claWhite;
      Canvas.Fill.Kind := TBrushKind.Solid;
      Canvas.FillRect(RectF(0, 0, Width, Height), 0, 0, AllCorners, 1);
      if FEditVisible then
      begin
        Canvas.Fill.Color := claGainsboro;
        Canvas.FillRect(RectF(0, Height-AToolbarHeight, Width, Height), 0, 0, AllCorners, 1);
      end;
    finally
      Canvas.RestoreState(AState);
    end;

    if FEditVisible then
    begin
      AState := Canvas.SaveState;
      try
        Canvas.IntersectClipRect(AEditRect);
        Canvas.Fill.Color := claWhite;
        Canvas.FillRect(AEditRect, 0, 0, AllCorners, 1);
        Canvas.Stroke.Color := claDimgray;
        Canvas.Stroke.Kind := TBrushKind.Solid;
        Canvas.DrawRect(AEditRect, 0, 0, AllCorners, 1);
      finally
        Canvas.RestoreState(AState);
      end;

      AState := Canvas.SaveState;
      try
        Canvas.IntersectClipRect(ABtnRect);
        Canvas.Fill.Color := $FFEEEEEE;
        Canvas.Stroke.Color := claDimgray;
        Canvas.FillRect(ABtnRect, 0, 0, AllCorners, 1);
        Canvas.DrawRect(ABtnRect, 0, 0, AllCorners, 1);
        Canvas.Fill.Color := claBlack;
        Canvas.FillText(ABtnRect, FButtonText, False, 1, [], TTextAlign.Center);
      finally
        Canvas.RestoreState(AState);
      end;
    end;
    DrawDesignBorder(claBlack, claBlack);
  end;
end;


procedure TksChatView.ScrollToEnd;
begin
  FTableView.ScrollToItem(FTableView.Items.LastItem);
end;

procedure TksChatView.ScrollToTop;
begin
  FTableView.ScrollToItem(FTableView.Items.FirstItem);
end;

procedure TksChatView.SetButtonText(const Value: string);
begin
  if FButtonText <> Value then
  begin
    FButtonText := Value;
    if FEdit <> nil then
      FEdit.FSendButton.Text := Value;
    Repaint;
  end;
end;

procedure TksChatView.SetEditVisible(const Value: Boolean);
begin
  if FEditVisible <> Value then
  begin
    FEditVisible := Value;
    if FEdit <> nil then
      FEdit.Visible := Value;
  end;
end;

procedure TksChatView.SetMyImage(const Value: TBitmap);
begin
  FMyImage.Assign(Value);
end;

procedure TksChatView.SetShowDoneButton(const Value: Boolean);
var
  VKToolbar: IFMXVirtualKeyboardToolbarService;
begin
  if FShowDoneButton <> Value then
  begin
    FShowDoneButton := Value;
    if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardToolbarService, IInterface(VKToolbar)) then
      VKToolbar.SetToolbarEnabled(FShowDoneButton);
  end;
end;

{ procedure TksChatView.SetShowDoneButton(const Value: Boolean);
begin
  FShowDoneButton := Value;
end;

TksChatViewEdit }

constructor TksChatViewEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEdit := TEdit.Create(Self);
  FSendButton := TButton.Create(Self);
  FSendButton.CanFocus := False;
  FSendButton.StaysPressed := False;
  Padding.Rect := RectF(6, 6, 6, 6);
  FSendButton.Align := TAlignLayout.Right;
  FEdit.Align := TAlignLayout.Client;
  FSendButton.Margins.Left := 8;
  FSendButton.StyleLookup := 'listitembutton';
  FSendButton.Text := 'SEND';

  FEdit.Stored := False;
  FSendButton.Stored := False;

  AddObject(FSendButton);
  AddObject(FEdit);
  FSendButton.OnClick := SendButtonClick;

  FEdit.OnEnter := EnterEdit;
  FEdit.OnKeyDown := EditKeyDown;
end;

destructor TksChatViewEdit.Destroy;
begin
  FEdit.DisposeOf;
  FSendButton.DisposeOf;
  inherited;
end;

procedure TksChatViewEdit.DoSendButtonClick;
begin
  TksChatView(Parent).DoSendButtonClick;
end;

procedure TksChatViewEdit.EditKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if (csDesigning in ComponentState) then
    Exit;
  if Key = 13 then
    SendButtonClick(Self);
end;

procedure TksChatViewEdit.EnterEdit(Sender: TObject);
var
  tv: TksTableView;
begin
  if (csDesigning in ComponentState) then
    Exit;
  tv := TksChatView(Parent).FTableView;
  tv.ScrollToItem(tv.Items.LastItem, True);
end;

procedure TksChatViewEdit.SendButtonClick(Sender: TObject);
begin
  DoSendButtonClick;
end;

end.


