unit AqDrop.Core.Helpers.TRttiObject;

interface

uses
  System.Rtti,
  System.SysUtils,
  AqDrop.Core.Collections.Intf;

type
  TAqRttiObjectHelper = class helper for TRttiObject
  strict private
    procedure ForEachAttribute<T: TCustomAttribute>(const pProcessing: TFunc<T, Boolean>);
  public
    function GetAttribute<T: TCustomAttribute>(out pAttribute: T; const pIncidence: UInt32 = 0): Boolean;
    function GetAttributes<T: TCustomAttribute>(out pAttributes: IAqResultList<T>): Boolean; overload;
  end;

implementation

uses
  AqDrop.Core.Collections;

{ TAqRttiObjectHelper }

function TAqRttiObjectHelper.GetAttribute<T>(out pAttribute: T; const pIncidence: UInt32): Boolean;
var
  lResult: Boolean;
  lAttribute: T;
  lActualIndex: UInt32;
begin
  lResult := False;
  lActualIndex := 0;

  ForEachAttribute<T>(
    function(pProcessingAttribute: T): Boolean
    begin
      Result := lActualIndex <> pIncidence;
      if not Result then
      begin
        lResult := True;
        lAttribute := pProcessingAttribute;
      end;

      Inc(lActualIndex);
    end);

  Result := lResult;

  if Result then
  begin
    pAttribute := lAttribute;
  end;
end;

function TAqRttiObjectHelper.GetAttributes<T>(out pAttributes: IAqResultList<T>): Boolean;
var
  lResult: Boolean;
  lList: TAqResultList<T>;
begin
  lResult := False;
  lList := nil;

  try
    ForEachAttribute<T>(
      function(pProcessingAttribute: T): Boolean
      begin
        Result := True;

        if not lResult then
        begin
          lList := TAqResultList<T>.Create;
        end;

        lResult := True;
        lList.Add(pProcessingAttribute);
      end);
  except
    lList.Free;
    raise;
  end;

  Result := lResult;

  if Result then
  begin
    pAttributes := lList;
  end;
end;

procedure TAqRttiObjectHelper.ForEachAttribute<T>(const pProcessing: TFunc<T, Boolean>);
var
  lAttributes: TArray<TCustomAttribute>;
  lAttributesCount: Int32;
  lI: Int32;
begin
  lAttributes := GetAttributes;
  lAttributesCount := Length(lAttributes);
  lI := 0;

  while lI < lAttributesCount do
  begin
    if lAttributes[lI].InheritsFrom(T) and not pProcessing(T(lAttributes[lI])) then
    begin
      lAttributesCount := 0;
    end else begin
      Inc(lI);
    end;
  end;
end;

end.

