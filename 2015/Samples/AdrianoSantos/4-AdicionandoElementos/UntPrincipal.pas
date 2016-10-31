//---------------------------------------------------------------------------

// This software is Copyright (c) 2015 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of an Embarcadero developer tools product.
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

unit UntPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.ListView.Types,
  FMX.StdCtrls, FMX.ListView, FMX.ListView.Appearances, Data.Bind.GenData,
  Fmx.Bind.GenData, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.ListBox, FMX.Graphics,
  FMX.TabControl, FMX.Objects, RatingsAppearanceU, FMX.MobilePreview, FMX.Controls.Presentation,
  FMX.ListView.Adapters.Base;

type
  TfrmPrincipal = class(TForm)
    ToolBar1: TToolBar;
    ToggleEditMode: TSpeedButton;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    ListViewBottomDetail: TListView;
    LinkFillControlToField1: TLinkFillControlToField;
    SpeedButtonLiveBindings: TSpeedButton;
    ToolBar2: TToolBar;
    SpeedButtonFill: TSpeedButton;
    ImageRAD: TImage;
    procedure ToggleEditModeClick(Sender: TObject);
    procedure SpeedButtonFillClick(Sender: TObject);
    procedure SpeedButtonLiveBindingsClick(Sender: TObject);
    procedure ListViewBottomDetailUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
    procedure LinkFillControlToField1FilledListItem(Sender: TObject;
      const AEditor: IBindListEditorItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

uses System.Math;

const
  sThumbNailName = 'TI';
  sCaption       = 'CA';

procedure TfrmPrincipal.LinkFillControlToField1FilledListItem(Sender: TObject;
  const AEditor: IBindListEditorItem);
var
  LItem      : TListViewItem;
  LThumb     : TListItemImage;
  LCaption   : TListItemText;
  LField     : TBindSourceAdapterField;
  LFieldName : TBindSourceAdapterField;
  LBitmap    : TPersistent;
  LName      : string;
begin
  if AEditor.CurrentIndex >= 0 then
  begin
    LItem      := ListViewBottomDetail.Items[AEditor.CurrentIndex];
    LThumb     := (LItem.Objects.FindDrawable(sThumbNailName) as TListItemImage);
    LCaption   := (LItem.Objects.FindDrawable(sCaption) as TListItemText);
    LField     := Self.PrototypeBindSource1.InternalAdapter.FindField('Bitmap1');
    LFieldName := Self.PrototypeBindSource1.InternalAdapter.FindField('BitmapName1');
    if (LField <> nil) and (LThumb <> nil) then
    begin
      if (LThumb.Bitmap = nil) or (not LThumb.OwnsBitmap) then
      begin
        LThumb.OwnsBitmap := True;
        LThumb.Bitmap     := TBitmap.Create(0, 0);
      end;
      if LField.GetTValue.TryAsType<TPersistent>(LBitmap) then
        LThumb.Bitmap.Assign(LBitmap)
      else
        LThumb.Bitmap.Assign(nil);
    end;

    if (LFieldName <> nil) and (LCaption <> nil) then
    begin
      if LFieldName.GetTValue.TryAsType<string>(LName) then
        LCaption.Text := LName
      else
        LCaption.Text := '';
    end;
  end;
end;

procedure TfrmPrincipal.ListViewBottomDetailUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
  LImage   : TListItemImage;
  LCaption : TListItemText;
begin
  LImage := AItem.View.FindDrawable(sThumbNailName) as TListItemImage;
  if LImage = nil then
  begin
    LImage               := TListItemImage.Create(AItem);
    LImage.Name          := sThumbNailName;
    LImage.Align         := TListItemAlign.Trailing;
    LImage.PlaceOffset.Y := 5;
    LImage.PlaceOffset.X := -30;
    LImage.Width         := 20;
    LImage.Height        := 20;
  end;

  LCaption := AItem.View.FindDrawable(sCaption) as TListItemText;
  if LCaption = nil then
  begin
    LCaption               := TListItemText.Create(AItem);
    LCaption.Name          := sCaption;
    LCaption.Align         := TListItemAlign.Trailing;
    LCaption.VertAlign     := TListItemAlign.Trailing;
    LCaption.PlaceOffset.X := -8;
    LCaption.TextAlign     := TTextAlign.Center;
    LCaption.Trimming      := TTextTrimming.Character;
    LCaption.IsDetailText  := True;
    LCaption.Width         := 60;
    LCaption.Height        := 25;
  end;

end;

procedure TfrmPrincipal.SpeedButtonFillClick(Sender: TObject);
var
  I: Integer;
  LItem: TListViewItem;
begin
  LinkFillControlToField1.Active := False;
  for I := 1 to 20 do
  begin
    LItem                 := ListViewBottomDetail.Items.Add;
    LItem.Text            := Format('Título %d', [I]);
    LItem.Detail          := Format('Detalhe %d', [I]);
    LItem.BitmapRef       := ImageRAD.Bitmap;
    LItem.Data[sCaption]  := Format('Ícone %d', [I]);
    (LItem.Objects.FindDrawable(sThumbNailName) as TListItemImage).OwnsBitmap := False;
    (LItem.Objects.FindDrawable(sThumbNailName) as TListItemImage).Bitmap := ImageRAD.Bitmap;
  end;

end;

procedure TfrmPrincipal.SpeedButtonLiveBindingsClick(Sender: TObject);
begin
  LinkFillControlToField1.Active := True;
end;


procedure TfrmPrincipal.ToggleEditModeClick(Sender: TObject);
begin
  ListViewBottomDetail.EditMode := not ListViewBottomDetail.EditMode;
end;

end.
