unit ksTableViewTest;

interface


uses
  DUnitX.TestFramework,
  ksTypes,
  ksCommon,
  ksTableView;

type

  [TestFixture]
  TksTableViewTest = class(TObject)
  private
    FTableView: TksTableView;
    FEventFired: Boolean;
    procedure Add100Items;
    procedure SearchFilterChanged(Sender: TObject; ASearchText: string);
    procedure DeletingItemEvent(Sender: TObject; AItem: TksTableViewItem; var ACanDelete: Boolean);
    procedure DeleteItemEvent(Sender: TObject; AItem: TksTableViewItem);
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // tests...
    [Test] procedure TestGetCheckedCount;
    [Test] procedure Test1000Items;
    [Test] procedure TestFilteredItems;
    [Test] procedure TestClearItems;
    [Test] procedure TestScrollToLastItem;
    [Test] procedure TestAccessories;
    [Test] procedure TestGetItemFromPos;
    [Test] procedure BringSelectedIntoView;
    [Test] procedure TestTotalItemHeight;
    [Test] procedure TestTopItem;
    [Test] procedure TestTopItemFiltered;
    [Test] procedure TestEmbeddedButtons;
    [Test] procedure TestEmbeddedEdits;
    [Test] procedure TestEmbeddedSwitches;
    [Test] procedure TestChatBubbles;
    [Test] procedure TestItemHorzAlignments;
    [Test] procedure TestItemVertAlignments;
    [Test] procedure TestObjectAtPos;
    [Test] procedure TestTextWidth;
    [Test] procedure TestTextHeight;
    [Test] procedure TestTextHeightMultiLine;
    [Test] procedure TestGetScreenScale;
    [Test] procedure TestSearchFilterEvent;
    [Test] procedure TestDeletingItemEvent;
    [Test] procedure TestOnDeleteItemEvent;
    [Test] procedure TestDeleteItemEvent;
  end;

implementation

uses SysUtils, System.UITypes, System.UIConsts;

//----------------------------------------------------------------------------------------------------

procedure TksTableViewTest.SearchFilterChanged(Sender: TObject; ASearchText: string);
begin
  FEventFired := ASearchText = 'TEST';
end;

procedure TksTableViewTest.Setup;
begin
  FTableView := TksTableView.Create(nil);
  FEventFired := False;
end;

procedure TksTableViewTest.TearDown;
begin
  //FTableView.Free;
end;

//----------------------------------------------------------------------------------------------------

procedure TksTableViewTest.Add100Items;
var
  ICount: integer;
begin
  // arrange
  // act
  FTableView.BeginUpdate;
  try
    for ICount := 1 to 100 do
      FTableView.Items.AddItem('Item '+IntToStr(ICount), 'a sub title', 'the detail', atNone);
  finally
    FTableView.EndUpdate;
  end;
end;

procedure TksTableViewTest.TestGetCheckedCount;
var
  ICount: integer;
begin
  FTableView.CheckMarkOptions.CheckMarks := TksTableViewCheckMarks.cmMultiSelect;
  Add100Items;
  for ICount := 1 to 100 do
  begin
    if ICount mod 2 = 0 then
      FTableView.Items[ICount-1].Checked := True;
  end;
  Assert.AreEqual(50, FTableView.Items.GetCheckedCount);
end;


procedure TksTableViewTest.TestGetItemFromPos;
var
  AItem: TksTableViewItem;
begin
  Add100Items;
  AItem := FTableView.GetItemFromPos(10, 600);
  Assert.AreEqual(13, AItem.Index);
end;

procedure TksTableViewTest.TestGetScreenScale;
var
  AScale: Extended;
begin
  AScale := GetScreenScale;
  Assert.AreEqual(1.0, AScale);
end;

procedure TksTableViewTest.TestItemHorzAlignments;
var
  ICount: TksTableItemAlign;
begin
  for ICount := Low(TksTableItemAlign) to High(TksTableItemAlign) do
  begin
    with FTableView.Items.AddItem('') do
      AddButton(30, 'TEST').Align := ICount;
  end;
  Assert.AreEqual(4, FTableView.Items.Count);
end;

procedure TksTableViewTest.TestItemVertAlignments;
var
  ICount: TksTableItemAlign;
begin
  for ICount := Low(TksTableItemAlign) to High(TksTableItemAlign) do
  begin
    with FTableView.Items.AddItem('') do
      AddButton(30, 'TEST', 0, ICount);
  end;
  Assert.AreEqual(4, FTableView.Items.Count);
end;

procedure TksTableViewTest.TestObjectAtPos;
var
  AItem: TksTableViewItem;
  AObj1, AObj2: TksTableViewItemObject;
begin
  Add100Items;
  AItem := FTableView.Items[0];
  with AItem.DrawRect(50, 5, 30, 20, claBlack, claWhite) do
  begin
    VertAlign := TksTableItemAlign.Leading;
    ID := '1';
  end;
  AObj1 := AItem.ObjectAtPos(55, 10);

  with AItem.DrawRect(100, 5, 30, 20, claBlack, claWhite) do
  begin
    VertAlign := TksTableItemAlign.Leading;
    ID := '2';
  end;
  AObj2 := AItem.ObjectAtPos(105, 10);
  Assert.AreEqual('1,2', AObj1.ID+','+AObj2.ID);
end;

procedure TksTableViewTest.TestOnDeleteItemEvent;
begin

end;

procedure TksTableViewTest.BringSelectedIntoView;
begin
  Add100Items;
  FTableView.SelectionOptions.KeepSelectedInView := False;
  FTableView.SelectionOptions.KeepSelection := True;
  FTableView.ItemIndex := 15;
  FTableView.BringSelectedIntoView;
  Assert.AreEqual(404, Integer(Round(FTableView.ScrollViewPos)));
end;

procedure TksTableViewTest.DeleteItemEvent(Sender: TObject; AItem: TksTableViewItem);
begin
  FEventFired := AItem.Index = 4;
end;

procedure TksTableViewTest.DeletingItemEvent(Sender: TObject; AItem: TksTableViewItem; var ACanDelete: Boolean);
begin
  FEventFired := True;
  ACanDelete := False;
end;

procedure TksTableViewTest.Test1000Items;
var
  ICount: integer;
begin
  // arrange
  // act
  FTableView.BeginUpdate;
  try
    for ICount := 1 to 1000 do
      FTableView.Items.AddItem('Item '+IntToStr(ICount), 'a sub title', 'the detail', atNone);
  finally
    FTableView.EndUpdate;
  end;
  // assert
  Assert.AreEqual(1000, FTableView.Items.Count);
end;

procedure TksTableViewTest.TestAccessories;
var
  ICount: TksAccessoryType;
begin
  FTableView.BeginUpdate;
  for ICount := Low(TksAccessoryType) to High(TksAccessoryType) do
    FTableView.Items.AddItem('Item', ICount);
  FTableView.EndUpdate;
end;

procedure TksTableViewTest.TestClearItems;
begin
  // arrange
  Add100Items;
  // act
  FTableView.ClearItems;
  // assert
  Assert.AreEqual(0, FTableView.Items.Count);
end;

procedure TksTableViewTest.TestDeleteItemEvent;
begin
  Add100Items;
  FTableView.OnDeleteItem := DeleteItemEvent;
  FTableView.Items.Delete(4);
  Assert.AreEqual(True, FEventFired);
end;

procedure TksTableViewTest.TestDeletingItemEvent;
begin
  Add100Items;
  FTableView.OnDeletingItem := DeletingItemEvent;
  FTableView.Items.Delete(4);
  Assert.AreEqual(True, (FEventFired) and (FTableView.Items.Count = 100));
end;

procedure TksTableViewTest.TestEmbeddedButtons;
var
  AItem: TksTableViewItem;
  ICount: integer;
begin
  FTableView.BeginUpdate;
  for ICount := 1 to 20 do
  begin
    AItem := FTableView.Items.AddItem('Button');
    AItem.AddButton(30, 'TEST');
  end;
  FTableView.EndUpdate;
  Assert.AreEqual(20, FTableView.Items.Count);
end;

procedure TksTableViewTest.TestEmbeddedEdits;
var
  AItem: TksTableViewItem;
  ICount: TksEmbeddedEditStyle;
begin
  FTableView.BeginUpdate;
  try
    for ICount := Low(TksEmbeddedEditStyle) to High(TksEmbeddedEditStyle) do
    begin
      AItem := FTableView.Items.AddItem('Button');
      AItem.AddEdit(0, 0, 100, 'TEST', ICount);
    end;
  finally
    FTableView.EndUpdate;
  end;
  Assert.AreEqual(4, FTableView.Items.Count);
end;

procedure TksTableViewTest.TestEmbeddedSwitches;
var
  AItem: TksTableViewItem;
  ICount: integer;
begin
  FTableView.BeginUpdate;
  try
    for ICount := 1 to 20 do
    begin
      AItem := FTableView.Items.AddItem('Switch');
      AItem.AddSwitch(0, (ICount mod 2) = 0);
    end;
  finally
    FTableView.EndUpdate;
  end;
  Assert.AreEqual(20, FTableView.Items.Count);
end;

procedure TksTableViewTest.TestChatBubbles;
var
  ICount: integer;
  AAlign: TksTableViewChatBubblePosition;
  AColor: TAlphaColor;
  ATextColor: TAlphaColor;
begin
  FTableView.BeginUpdate;
  try
    for ICount := 1 to 100 do
    begin
      if ICount mod 2 = 1 then
      begin
        AAlign := ksCbpLeft;
        AColor := claDodgerblue;
        ATextColor := claWhite;
      end
      else
      begin
        AAlign := ksCbpRight;
        AColor := claSilver;
        ATextColor := claBlack;
      end;
      FTableView.Items.AddChatBubble('Chat Text '+IntToStr(ICount), AAlign, AColor, ATextColor, nil);
    end;
    Assert.AreEqual(100, FTableView.Items.Count);
  finally
    FTableView.EndUpdate;
  end;
end;

procedure TksTableViewTest.TestFilteredItems;
begin
  // arrange
  FTableView.SearchVisible := True;
  Add100Items;
  // act
  FTableView.SearchText := 'Item 6';
  // assert
  Assert.AreEqual(11, FTableView.FilteredItems.Count);
end;

procedure TksTableViewTest.TestScrollToLastItem;
var
  AResult: Extended;
begin
  // arrange
  Add100Items;
  // act
  FTableView.ScrollToItem(99);
  // assert
  AResult := FTableView.ScrollViewPos;
  Assert.AreEqual(4100.0, AResult);
end;

procedure TksTableViewTest.TestSearchFilterEvent;
begin
  FTableView.SearchVisible := True;
  FTableView.OnSearchFilterChanged := SearchFilterChanged;
  FTableView.SearchText := 'TEST';
  Assert.AreEqual(True, FEventFired);
end;

procedure TksTableViewTest.TestTextHeight;
var
  AHeight: string;
begin
  FTableView.Items.AddItem('This is a test');
  AHeight := FormatFloat('0.00', FTableView.Items[0].Title.CalculateSize.Height);
  Assert.AreEqual('17.29', AHeight);
end;

procedure TksTableViewTest.TestTextHeightMultiLine;
var
  AHeight: string;
begin
  FTableView.Items.AddItem('This is a test'+#13+'This is the second line...'+#13+'And the third :-)');
  AHeight := FormatFloat('0.00', FTableView.Items[0].Title.CalculateSize.Height);
  Assert.AreEqual('51.87', AHeight);
end;

procedure TksTableViewTest.TestTextWidth;
var
  AWidth: string;
begin
  FTableView.Items.AddItem('This is a test');
  AWidth := FormatFloat('0.00', FTableView.Items[0].Title.CalculateSize.Width);
  Assert.AreEqual('69.92', AWidth);
end;

procedure TksTableViewTest.TestTopItem;
begin
  Add100Items;
  Assert.AreEqual(0, FTableView.TopItem.Index);
end;

procedure TksTableViewTest.TestTopItemFiltered;
begin
  Add100Items;
  FTableView.SearchText := 'Item 4';
  Assert.AreEqual(3, FTableView.TopItem.AbsoluteIndex);
end;

procedure TksTableViewTest.TestTotalItemHeight;
begin
  Add100Items;
  Assert.AreEqual(4400, Integer(Round(FTableView.TotalItemHeight)));
end;

initialization
  TDUnitX.RegisterTestFixture(TksTableViewTest);
end.
