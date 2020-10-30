unit AqDrop.Core.Bindings;

interface

uses
  System.Classes,
  System.Rtti,
  Data.Bind.ObjectScope,
  AqDrop.Core.Collections.Intf;

type
  TAqSetListBindSource<T: class; I: IAqReadList<T>> = procedure(pSender: TBindSourceAdapter; pList: I);

  TAqBaseListBindSourceAdapter<T: class; I: IAqReadList<T>> = class(TBaseListBindSourceAdapter)
  strict private
    FList: I;
    FOnBeforeSetList: TAqSetListBindSource<T, I>;
    FOnAfterSetList: TAqSetListBindSource<T, I>;
  strict protected
    procedure CheckList;
    function GetObjectType: TRttiType; override;
    function GetCurrent: TObject; override;
    function GetCount: Int32; override;
    function GetCanActivate: Boolean; override;
    function SupportsNestedFields: Boolean; override;
    procedure AddFields; virtual;
    procedure DoOnBeforeSetList(pList: I); virtual;
    procedure DoOnAfterSetList; virtual;
    function GetCurrentObject: T;
  public
    constructor Create(AOwner: TComponent; pList: I); reintroduce; overload; virtual;
    procedure SetList(pList: I);
    property List: I read FList;
    property OnBeforeSetList: TAqSetListBindSource<T, I> read FOnBeforeSetList write FOnBeforeSetList;
    property OnAfterSetList: TAqSetListBindSource<T, I> read FOnAfterSetList write FOnAfterSetList;
    property CurrentObject: T read GetCurrentObject;
  end;

  TAqReadListBindSourceAdapter<T: class>  = class(TAqBaseListBindSourceAdapter<T, IAqReadList<T>>)
  strict protected
    function GetCanDelete: Boolean; override;
    function GetCanInsert: Boolean; override;
    function GetCanModify: Boolean; override;
    function GetCanApplyUpdates: Boolean; override;
    function GetCanCancelUpdates: Boolean; override;
  end;

  TAqListBindSourceAdapter<T: class>  = class(TAqBaseListBindSourceAdapter<T, IAqList<T>>)
  strict private
    FInstanceFactory: TBindSourceAdapterInstanceFactory;

    function GetItemInstanceFactory: TBindSourceAdapterInstanceFactory;
  strict protected
    function CreateItemInstance: T; virtual;
    procedure InitItemInstance(const pIntance: T); virtual;
    function DeleteAt(AIndex: Int32): Boolean;  override;
    function AppendAt: Int32; override;
    function InsertAt(AIndex: Int32): Int32; override;
    function GetCanDelete: Boolean; override;
    function GetCanInsert: Boolean; override;
    function GetCanModify: Boolean; override;
    function GetCanApplyUpdates: Boolean; override;
    function GetCanCancelUpdates: Boolean; override;
    procedure InternalCancelUpdates; override;
    procedure InternalApplyUpdates; override;
  public
    destructor Destroy; override;
  end;

resourcestring
  StrListIsNotAssigned = 'List is not Assigned';
  StrNewInstanceOfTypeObjectClassNameDoesNotMatchExpectedTypeTClassName =
    'New instance of type %s does not match expected type %s.';

implementation

uses
  AqDrop.Core.Exceptions;

{ TAqBaseListBindSourceAdapter<T, I> }

procedure TAqBaseListBindSourceAdapter<T, I>.AddFields;
var
  lType: TRttiType;
  lGetMemberObject: IGetMemberObject;
begin
  lType := GetObjectType;
  lGetMemberObject := TBindSourceAdapterGetMemberObject.Create(Self);
  AddFieldsToList(lType, Self, Self.Fields, lGetMemberObject);
  AddPropertiesToList(lType, Self, Self.Fields, lGetMemberObject);
end;

procedure TAqBaseListBindSourceAdapter<T, I>.CheckList;
begin
  if not Assigned(FList) then
  begin
    raise EAqInternal.Create(StrListIsNotAssigned);
  end;
end;

constructor TAqBaseListBindSourceAdapter<T, I>.Create(AOwner: TComponent; pList: I);
begin
  Create(AOwner);
  SetList(pList);
end;

procedure TAqBaseListBindSourceAdapter<T, I>.DoOnAfterSetList;
begin
  if Assigned(FOnAfterSetList) then
  begin
    FOnAfterSetList(Self, FList);
  end;
end;

procedure TAqBaseListBindSourceAdapter<T, I>.DoOnBeforeSetList(pList: I);
begin
  if Assigned(FOnBeforeSetList) then
  begin
    FOnBeforeSetList(Self, pList);
  end;
end;

function TAqBaseListBindSourceAdapter<T, I>.GetCanActivate: Boolean;
begin
  Result := Assigned(FList);
end;

function TAqBaseListBindSourceAdapter<T, I>.GetCount: Int32;
begin
  if Assigned(FList) then
  begin
    Result := FList.Count;
  end else begin
    Result := 0;
  end;
end;

function TAqBaseListBindSourceAdapter<T, I>.GetCurrent: TObject;
begin
  Result := GetCurrentObject;
end;

function TAqBaseListBindSourceAdapter<T, I>.GetCurrentObject: T;
var
  lIndex: Int32;
begin
  lIndex := ItemIndex + ItemIndexOffset;
  if Assigned(FList) and (lIndex >= 0) and (lIndex < FList.Count) then
  begin
    Result := FList.Items[lIndex];
  end else begin
    Result := nil;
  end;
end;

function TAqBaseListBindSourceAdapter<T, I>.GetObjectType: TRttiType;
begin
  Result := TRttiContext.Create.GetType(T.ClassInfo);
end;

procedure TAqBaseListBindSourceAdapter<T, I>.SetList(pList: I);
begin
  DoOnBeforeSetList(pList);

  Active := False;
  if Assigned(FList) then
  begin
    ClearFields;
  end;

  FList := pList;

  if Assigned(FList) then
  begin
    AddFields;
  end;

  DoOnAfterSetList;
end;

function TAqBaseListBindSourceAdapter<T, I>.SupportsNestedFields: Boolean;
begin
  Result := True;
end;

{ TAqReadListBindSourceAdapter<T> }

function TAqReadListBindSourceAdapter<T>.GetCanApplyUpdates: Boolean;
begin
  Result := False;
end;

function TAqReadListBindSourceAdapter<T>.GetCanCancelUpdates: Boolean;
begin
  Result := False;
end;

function TAqReadListBindSourceAdapter<T>.GetCanDelete: Boolean;
begin
  Result := False;
end;

function TAqReadListBindSourceAdapter<T>.GetCanInsert: Boolean;
begin
  Result := False;
end;

function TAqReadListBindSourceAdapter<T>.GetCanModify: Boolean;
begin
  Result := False;
end;

{ TAqListBindSourceAdapter<T> }

function TAqListBindSourceAdapter<T>.AppendAt: Int32;
var
  lNewItem: T;
  lIndex: Int32;
  lHandled: Boolean;
  lAppended: Boolean;
begin
  CheckList;

  DoListAppend(lHandled, lAppended);
  if lHandled then
  begin
    if lAppended then
    begin
      Result := List.Count - 1;
    end else begin
      Result := -1;
    end;
  end else begin
    Result := -1;
    lNewItem := CreateItemInstance;
    if Assigned(lNewItem) then
    begin
      InitItemInstance(lNewItem);
      List.Add(lNewItem);
      Result := List.Count - 1;
    end;
  end;
end;

function TAqListBindSourceAdapter<T>.CreateItemInstance: T;
var
  lObject: TObject;
begin
  CheckList;
  Result := nil;
  Assert(GetItemInstanceFactory.CanConstructInstance);
  if GetItemInstanceFactory.CanConstructInstance then
  begin
    lObject := GetItemInstanceFactory.ConstructInstance;
    try
      if not (lObject is T) then
      begin
        raise EAqInternal.CreateFmt(StrNewInstanceOfTypeObjectClassNameDoesNotMatchExpectedTypeTClassName,
          [lObject.QualifiedClassName, T.QualifiedClassName]);
      end;
      Result := lObject as T;
    except
      lObject.Free;
      raise;
    end;
  end;
end;

function TAqListBindSourceAdapter<T>.DeleteAt(AIndex: Int32): Boolean;
var
  lHandled: Boolean;
begin
  CheckList;

  DoListDelete(AIndex, lHandled, Result);

  if not lHandled then
  begin
    Result := (AIndex >= 0) and (AIndex < List.Count);
    if Result then
    begin
      List.Delete(AIndex);
    end;
  end;
end;

destructor TAqListBindSourceAdapter<T>.Destroy;
begin
  FInstanceFactory.Free;

  inherited;
end;

function TAqListBindSourceAdapter<T>.GetCanApplyUpdates: Boolean;
var
  lHasUpdates: Boolean;
begin
  Result := (loptAllowApplyUpdates in Options) and Assigned(OnApplyUpdates);
  if Result and Assigned(OnHasUpdates) then
  begin
    lHasUpdates := False;
    OnHasUpdates(Self, lHasUpdates);
    Result := lHasUpdates;
  end;
end;

function TAqListBindSourceAdapter<T>.GetCanCancelUpdates: Boolean;
var
  lHasUpdates: Boolean;
begin
  Result := (loptAllowCancelUpdates in Options) and Assigned(OnCancelUpdates);
  if Result and Assigned(OnHasUpdates) then
  begin
    lHasUpdates := False;
    OnHasUpdates(Self, lHasUpdates);
    Result := lHasUpdates;
  end;
end;

function TAqListBindSourceAdapter<T>.GetCanDelete: Boolean;
begin
  Result := loptAllowDelete in Options;
end;

function TAqListBindSourceAdapter<T>.GetCanInsert: Boolean;
begin
  Result := (loptAllowInsert in Options);
  if Result then
  begin
    Result := Assigned(OnCreateItemInstance) or GetItemInstanceFactory.CheckConstructor;
  end;
end;

function TAqListBindSourceAdapter<T>.GetCanModify: Boolean;
begin
  Result := (loptAllowModify in Options);
end;

function TAqListBindSourceAdapter<T>.GetItemInstanceFactory: TBindSourceAdapterInstanceFactory;
begin
  if not Assigned(FInstanceFactory) then
  begin
    FInstanceFactory := TBindSourceAdapterInstanceFactory.Create(GetObjectType);
  end;

  Result := FInstanceFactory;
end;

procedure TAqListBindSourceAdapter<T>.InitItemInstance(const pIntance: T);
begin
  DoInitItemInstance(pIntance);
end;

function TAqListBindSourceAdapter<T>.InsertAt(AIndex: Int32): Int32;
var
  lNewItem: T;
  lHandled: Boolean;
begin
  DoListInsert(AIndex, lHandled, Result);
  if not lHandled then
  begin
    Result := -1;
    lNewItem := CreateItemInstance;
    if Assigned(lNewItem) then
    begin
      InitItemInstance(lNewItem);
      List.Insert(AIndex, lNewItem);
      Result := AIndex;
    end;
  end;
end;

procedure TAqListBindSourceAdapter<T>.InternalApplyUpdates;
begin
  if Assigned(OnApplyUpdates) then
  begin
    OnApplyUpdates(Self);
  end;
end;

procedure TAqListBindSourceAdapter<T>.InternalCancelUpdates;
begin
  if Assigned(OnCancelUpdates) then
  begin
    OnCancelUpdates(Self);
  end;
end;

end.
