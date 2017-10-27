unit Classes.Custom.Adapter;

interface

uses
  FMX.ListView.Adapters.Base, FMX.Types, System.Types, FMX.ListView.Types, System.Classes, FMX.ListView,
  System.Generics.Collections, FMX.Graphics, System.RegularExpressions, System.SyncObjs,
  System.SysUtils, System.UITypes, IdHTTP, FMX.Objects;

type
  TCustomAdapter = class(TAbstractListViewAdapter,
    IListViewAdapter,
    IListViewTextProvider,
    IListViewTextButtonProvider)
  private
    FParent: TListViewBase;
    FStrings: TStringList;
    FBitmaps: TDictionary<Integer, TBitmap>;
    FUriRegex: TRegEx;
    FNameRegex: TRegEx;
    FIdRegex: TRegEx;
    FRegexMonitor: TObject;
    FRequests: TList<Integer>;
    FThreads: TArray<TThread>;
    FCS: TCriticalSection;
    FSem: TSemaphore;
    FExitRequested: Boolean;
    FIndex: Integer;
    FOnButtonClicked: TNotifyEvent;
    FBackDropImage: TImage;
    procedure CreateThreads;
    procedure DestroyThreads;

    procedure StringListChanging(Sender: TObject);
    procedure StringListChange(Sender: TObject);
    function GetName(const Index: Integer): string;

    procedure ImagesLoaded;
    procedure MatchView(const pItem: TListItem);
    procedure AddItem(Index: Integer);
    function NextItem: Integer;

    function GetId(Index: Integer): string;
    function GetURI(Index: Integer): string;

    procedure ButtonClicked(Sender: TObject);
    procedure SetOnButtonClicked(const Value: TNotifyEvent);

  strict protected
    procedure DoCreateNewViews; override;
  public
    procedure ResetView(const Item: TListItem);
    procedure ResetViews(const Purposes: TListItemPurposes);

    { IListViewAdapter }
    function GetCount: Integer;
    function GetItem(const Index: Integer): TListItem;
    function IndexOf(const AItem: TListItem): Integer;
    function GetEnumerator: TEnumerator<TListItem>;
    function GetDefaultViewHeight: Integer;

    { IListViewTextProvider }
    function GetText(const Index: Integer): string;
    function GetIndexTitle(const Index: Integer): string;

    { IListViewTextButtonProvider }
    function GetTextButtonDrawable(const Index: Integer): TListItemTextButton;
  public
    constructor Create(const AParent: TListViewBase; const AStrings: TStringList);
    destructor Destroy; override;

    property BackDropImage: TImage read FBackDropImage write FBackDropImage;
    property OnButtonClicked: TNotifyEvent read FOnButtonClicked write SetOnButtonClicked;
  end;

implementation

{ TcustomAdapter }

procedure TCustomAdapter.AddItem(Index: Integer);
begin
  try
    FCS.Acquire;
    FRequests.Add(Index);
    FSem.Release;
  finally
    FCS.Release;
  end;
end;

procedure TCustomAdapter.ButtonClicked(Sender: TObject);
begin
  if Assigned(FOnButtonClicked) then
  begin
    FOnButtonClicked(Sender);
  end;
end;

constructor TCustomAdapter.Create(const AParent: TListViewBase; const AStrings: TStringList);
begin
  inherited Create;
  FParent := AParent;
  FStrings := AStrings;
  FBitmaps := TDictionary<Integer, TBitmap>.Create;
  FUriRegex := TRegEx.Create('\[(http://.*)\]');

  FNameRegex := TRegEx.Create('\[([A-Za-z]+)\]');
  FIdRegex := TRegEx.Create('\[([0-9]+)\]');

  FRegexMonitor := TObject.Create;
  FRequests := TList<Integer>.Create;
  FCS := TCriticalSection.Create;
  FSem := TSemaphore.Create(nil, 0, 1000, '');

  CreateThreads;

  // todo: armazenar evento anterior
  FStrings.OnChanging := StringListChanging;
  Fstrings.OnChange := StringListChange;
end;

procedure TCustomAdapter.CreateThreads;
var
  i: Integer;
begin
  SetLength(FThreads, 4{todo: constante ThreadPool});
  for i := 0 to Length(FThreads) -1 do
  begin
    FThreads[i] := TThread.CreateAnonymousThread(
      procedure
      var
        lHttp: TidHTTP;
        lStream: TBytesStream;
        lIndex: Integer;
        lURI: string;
        lBitMap: TBitmap;
      begin
        lHttp := TIdHTTP.Create(nil);
        lStream := TBytesStream.Create;
        try
          lIndex := NextItem;
          while lIndex <> -1 do
          begin
            lURI := GetURI(lIndex);
            try
              lHttp.Get(lURI, lStream);
              TThread.Synchronize(nil,
                procedure
                begin
                  try
                    lBitMap := TBitmap.CreateFromStream(lStream);
                    if Assigned(lBitMap) and
                      ((lBitMap.Width > 0) and (lBitMap.Height > 0)) then
                    begin
                      FBitmaps.Add(lIndex, lBitmap);
                    end;
                  except
                    // silence
                  end;
                end);

              if Assigned(lBitMap) and
                ((lBitMap.Width > 0) and (lBitMap.Height > 0)) then
              begin
                TThread.Queue(nil,
                  procedure
                  begin
                    ImagesLoaded;
                  end);
              end;

            except
              on E: Exception do
              begin
                TThread.Queue(nil,
                  procedure
                  begin
                    TListItemText(
                      TListItem(
                        FStrings.Objects[lIndex]).View.FindDrawable('blurb')
                      ).Text := 'Load error: ' + E.Message;
                    ItemsInvalidate;
                  end);

                AddItem(lIndex);
                TThread.CurrentThread.Sleep(Random(100) + 100);
              end;
            end;

            lIndex := NextItem;
          end;
        finally
          lHttp.Free;
          lStream.Free;
        end;
      end);
    FThreads[i].FreeOnTerminate := False;
    FThreads[i].Start;
  end;
end;

destructor TCustomAdapter.Destroy;
var
  lPair: TPair<Integer, TBitMap>;
  i: Integer;
begin
  DestroyThreads;
  FRequests.Free;
  for lPair in FBitmaps do
  begin
    lPair.Value.Free;
  end;

  for i := 0 to FStrings.Count -1 do
  begin
    FStrings.Objects[i].Free;
  end;

  FBitmaps.Free;
  FRegexMonitor.Free;
  inherited;
end;

procedure TCustomAdapter.DestroyThreads;
var
  i: Integer;
begin
  FExitRequested := True;
  FSem.Release(4);
  for i := 0 to High(FThreads) do
  begin
    FThreads[i].WaitFor;
    FThreads[i].Free;
  end;
end;

procedure TCustomAdapter.DoCreateNewViews;
begin
  inherited;
end;

function TCustomAdapter.GetCount: Integer;
begin
  Result := FStrings.Count;
end;

function TCustomAdapter.GetDefaultViewHeight: Integer;
begin
  Result := 33;
end;

function TCustomAdapter.GetEnumerator: TEnumerator<TListItem>;
begin
  Result := nil;
end;

function TCustomAdapter.GetId(Index: Integer): string;
var
  lMatch: TMatch;
begin
  Result := '';
  lMatch := FIdRegex.Match(FStrings[Index]);
  if lMatch.Success then
  begin
    Result := lMatch.Groups[1].Value;
  end;
end;

function TCustomAdapter.GetIndexTitle(const Index: Integer): string;
begin
  Result := '';
end;

function TCustomAdapter.GetItem(const Index: Integer): TListItem;
begin
  Result := TListItem(FStrings.Objects[Index]);
  if not Assigned(Result) then
  begin
    Result := TListItem.Create(FParent.Adapter, FParent);
    Result.Height := GetDefaultViewHeight;
    Result.Index := Index;
    FStrings.Objects[Index] := Result;

    ResetView(Result);
  end;
end;

function TCustomAdapter.GetName(const Index: Integer): string;
var
  lMatches: TMatch;
begin
  Result := string.Empty;// igual a '' // EmptyStr >> evitar usar >> EmptyStr := '0';
  lMatches := FNameRegex.Match(FStrings[Index]);
  if lMatches.Success then
  begin
    Result := lMatches.Groups[1].Value;
  end;
end;

function TCustomAdapter.GetText(const Index: Integer): string;
begin
  Result := GetName(Index);
end;

function TCustomAdapter.GetTextButtonDrawable(const Index: Integer): TListItemTextButton;
begin
  Result := TListItemTextButton(TListItem(FStrings.Objects[Index]).View.FindDrawable('button'));
end;

function TCustomAdapter.GetURI(Index: Integer): string;
var
  lMatch: TMatch;
begin
  TMonitor.Enter(FRegexMonitor);
  Result := '';
  lMatch := FUriRegex.Match(FStrings[Index]);
  if lMatch.Success then
  begin
    Result := lMatch.Groups[0].Value;
    Result := lMatch.Groups[1].Value;
  end;
  TMonitor.Exit(FRegexMonitor);
end;

procedure TCustomAdapter.ImagesLoaded;
var
  lPair: TPair<Integer, TBitmap>;
  lItem: TListItem;
  lBitmapDrawable: TListItemImage;
  lTextDrawable: TListItemText;
begin
  for lPair in FBitmaps do
  begin
    lItem := TListItem(FStrings.Objects[lPair.Key]);
    lBitmapDrawable := TListItemImage(lItem.View.FindDrawable('bitmap'));
    if Assigned(lBitmapDrawable) and (not Assigned(lBitmapDrawable.Bitmap)) then
    begin
      lBitmapDrawable.Bitmap := lPair.Value;
    end;

    lTextDrawable := TListItemText(lItem.View.FindDrawable('blurb'));
    if Assigned(lTextDrawable) then
    begin
      lTextDrawable.Text :=
        Format('%s is %dx%d and has ordinal number %d',
        [GetName(lPair.Key), lPair.Value.Width, lPair.Value.Height, lPair.Key]);
    end;

    MatchView(lItem);
  end;

  FParent.StopPullRefresh;
  ItemsResize;
  ItemsInvalidate;
end;

function TCustomAdapter.IndexOf(const AItem: TListItem): Integer;
begin
  Result := -1;
end;

procedure TCustomAdapter.MatchView(const pItem: TListItem);
var
  lBitmapDrawable: TListItemImage;
  lWidth: Single;
  lAspect: Extended;
  lTextDrawable: TListItemText;
  lBackDropImg: TListItemImage;
begin
  lBitmapDrawable := TListItemImage(pItem.View.FindDrawable('bitmap'));
  if Assigned(lBitmapDrawable) and (Assigned(lBitmapDrawable.Bitmap)) then
  begin
    lWidth := FParent.Width - FParent.ItemSpaces.Left - FParent.ItemSpaces.Right;
    lBitmapDrawable.Width := lWidth;
    lAspect := lWidth / lBitmapDrawable.Bitmap.Width;
    pItem.Height := Round(lBitmapDrawable.Bitmap.Height * lAspect + 0.5);

    lTextDrawable := TListItemText(pItem.View.FindDrawable('blurb'));
    lTextDrawable.Width := lWidth - 100;

    lBackDropImg := TListItemImage(pItem.View.FindDrawable('blackdrop'));
    lBackDropImg.Width := lWidth;
    lBackDropImg.PlaceOffset.Y := - 10;
  end;
end;

function TCustomAdapter.NextItem: Integer;
begin
  FSem.Acquire;
  if FExitRequested then
  begin
    // return -1
    Exit(-1);
  end;

  try
    // InterlokedIncrement(FIndex) >> Win32
    // Ele não exejiria Critical section
    FCS.Acquire;
    Result := FIndex;
    Inc(FIndex);
  finally
    FCS.Release;
  end;
end;

procedure TCustomAdapter.ResetView(const Item: TListItem);
var
  lBitmap: TListItemImage;
  lText: TListItemText;
  lBtn: TListItemTextButton;
begin
  if Item.View.Count = 0 then
  begin
    lBitmap := TListItemImage.Create(Item);
    lBitmap.Name := 'bitmap';
    lBitmap.OwnsBitmap := False;
    lBitmap.Bitmap := nil;
    lBitmap.Align := TListItemAlign.Trailing;
    lBitmap.ScalingMode := TImageScalingMode.StretchWithAspect;

    lBitmap := TListItemImage.Create(Item);
    lBitmap.Name := 'blackdrop';
    lBitmap.OwnsBitmap := False;
    lBitmap.Bitmap := FBackDropImage.BitMap;
    lBitmap.VertAlign := TListItemAlign.Trailing;
    lBitmap.Align := TListItemAlign.Trailing;
    lBitmap.ScalingMode := TImageScalingMode.Stretch;
    lBitmap.Opacity := 0.25;
    lBitmap.Height := 65;

    lText := TListItemText.Create(Item);
    lText.Name := 'title';
    lText.Text := GetName(Item.Index).ToUpper;
    lText.Height := 80;
    lText.Font.Size := 48;
    lText.TextColor := TAlphaColorRec.Bisque;
    lText.SelectedTextColor := TAlphaColorRec.White;
    lText.PlaceOffset.X := 10;
    lText.PlaceOffset.Y := 10;

    lText := TListItemText.Create(Item);
    lText.Name := 'blurb';
    lText.Text := GetId(Item.Index);
    lText.Font.Size := 16;
    lText.TextColor := TAlphaColorRec.White;
    lText.SelectedTextColor := TAlphaColorRec.White;
    lText.Align := TListItemAlign.Leading;
    lText.VertAlign := TListItemAlign.Trailing;
    lText.WordWrap := True;
    lText.Height := 60;
    lText.PlaceOffset.X := 10;

    lBtn := TListItemTextButton.Create(Item);
    lBtn.Name := 'button';
    lBtn.Text := '°°°';
    lBtn.Align := TListItemAlign.Trailing;
    lBtn.VertAlign := TListItemAlign.Trailing;
    lBtn.Width := 48;
    lBtn.Height := 16;
    lBtn.PlaceOffset.X := -10;
    lBtn.PlaceOffset.Y := lText.Height/2 -lBtn.Height/2 -lText.Height;
    lBtn.OnSelect := ButtonClicked;
    lBtn.TagObject := Item;

    AddItem(Item.Index);
  end else
    MatchView(Item);
end;

procedure TCustomAdapter.ResetViews(const Purposes: TListItemPurposes);
var
  i: Integer;
begin
  for i := 0 to FStrings.Count -1 do
  begin
    ResetView(TListItem(FStrings.Objects[i]));
  end;
  ItemsResize;
end;

procedure TCustomAdapter.SetOnButtonClicked(const Value: TNotifyEvent);
begin
  FOnButtonClicked := Value;
end;

procedure TCustomAdapter.StringListChange(Sender: TObject);
begin
  ItemsCouldHaveChanged;
  ItemsResize;
  ItemsInvalidate;
end;

procedure TCustomAdapter.StringListChanging(Sender: TObject);
begin
  ItemsMayChange;
end;

end.
