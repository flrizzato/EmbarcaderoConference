unit ksListViewHelper;

interface

{$I ksComponents.inc}

uses
  System.SysUtils, System.Types, System.UITypes, System.UIConsts, System.Classes,
  ksTableView;


type
  TListItemPurpose = TksTableViewItemPurpose;

  TListItemAppearence = (ListItemRightDetail, ListItemBottomDetail);

  TListViewItem = class (TksTableViewItem)
  private
    FItemAppearence: TListItemAppearence;
    FListItemAppearence: TListItemAppearence;

    function GetText() : String;
    function GetDetail() : String;

    procedure SetText(Value : String);
    procedure SetDetail(Value : String);
    procedure SetListItemAppearence(const Value: TListItemAppearence);
  public
    property Text   : String read GetText write SetText;
    property Detail : String read GetDetail write SetDetail;
    property ItemAppearence: TListItemAppearence read FListItemAppearence write SetListItemAppearence;
  end;

  TksTableViewItemsHelper = class helper for TksTableViewItems
  public
    function Add(): TListViewItem; overload;
  end;

implementation

//------------------------------------------------------------------------------

function TListViewItem.GetText() : String;
begin
  Result := Title.Text;
end;

//------------------------------------------------------------------------------

function TListViewItem.GetDetail() : String;
begin
  case FItemAppearence of
    ListItemRightDetail: Result := TksTableViewItem(Self).Detail.Text;
    ListItemBottomDetail: Result := SubTitle.Text;
  end;

end;
//------------------------------------------------------------------------------
procedure TListViewItem.SetText(Value : String);
begin
  Title.Text := Value;
end;
//------------------------------------------------------------------------------
procedure TListViewItem.SetDetail(Value : String);
begin
  case FItemAppearence of
    ListItemRightDetail: TksTableViewItem(Self).Detail.Text := Value;
    ListItemBottomDetail: SubTitle.Text := Value;
  end;

end;

procedure TListViewItem.SetListItemAppearence(const Value: TListItemAppearence);
begin
  if FListItemAppearence <> Value then
  begin
    FListItemAppearence := Value;
    if FListItemAppearence = ListItemRightDetail then
    begin
      TksTableViewItem(Self).Detail.Text := TksTableViewItem(Self).SubTitle.Text;
      TksTableViewItem(Self).SubTitle.Text := '';
    end
    else
    begin
      TksTableViewItem(Self).SubTitle.Text := TksTableViewItem(Self).Detail.Text;
      TksTableViewItem(Self).Detail.Text := '';
    end;
  end;
end;

//------------------------------------------------------------------------------
function TksTableViewItemsHelper.Add(): TListViewItem;
begin
  Result        := TListViewItem.Create(Self.FTableView);
  Result.Height := Self.FTableView.ItemHeight;

  Result.ItemAppearence := ListItemBottomDetail;
  Self.Add(Result);

  Self.UpdateIndexes;

  Self.FTableView.UpdateItemRects(False);
  Self.FTableView.UpdateScrollingLimits;
end;
//------------------------------------------------------------------------------


end.

