unit AqDrop.Core.Helpers.TRttiType;

interface

uses
  System.Rtti, AqDrop.Core.Types;

type
  TAqRttiTypeHelper = class helper for TRttiType
  public
    function GetDataType: TAqDataType;
  end;

implementation

uses
  System.TypInfo, AqDrop.Core.Exceptions;

{ TAqRttiTypeHelper }

function TAqRttiTypeHelper.GetDataType: TAqDataType;
var
  lQualifiedName: string;
begin
  lQualifiedName := Self.QualifiedName;

  case Self.TypeKind of
    tkUnknown:
      Result := TAqDataType.adtUnknown;
    tkInteger:
      Result := TAqDataType.adtInt32;
    tkChar:
      Result := TAqDataType.adtAnsiChar;
    tkEnumeration:
      begin
        if lQualifiedName = 'System.Boolean' then
        begin
          Result := TAqDataType.adtBoolean;
        end else begin
          Result := TAqDataType.adtEnumerated;
        end;
      end;
    tkFloat:
      begin
        if lQualifiedName = 'System.TDateTime' then
        begin
          Result := TAqDataType.adtDatetime;
        end else if lQualifiedName = 'System.TDate' then
        begin
          Result := TAqDataType.adtDate;
        end else if lQualifiedName = 'System.TTime' then
        begin
          Result := TAqDataType.adtTime;
        end else if lQualifiedName = 'System.Currency' then
        begin
          Result := TAqDataType.adtCurrency;
        end else begin
          Result := TAqDataType.adtDouble;
        end;
      end;
    tkSet:
      Result := TAqDataType.adtSet;
    tkClass:
      Result := TAqDataType.adtClass;
    tkMethod:
      Result := TAqDataType.adtMethod;
    tkWChar:
      Result := TAqDataType.adtChar;
    tkLString:
      Result := TAqDataType.adtAnsiString;
    tkWString:
      Result := TAqDataType.adtWideString;
    tkVariant:
      Result := TAqDataType.adtVariant;
    tkRecord:
      Result := TAqDataType.adtRecord;
    tkInterface:
      Result := TAqDataType.adtInterface;
    tkInt64:
      Result := TAqDataType.adtInt64;
    tkUString:
      Result := TAqDataType.adtString;
  else
    raise EAqInternal.Create('Tipo inesperado em TAqRttiTypeHelper.GetTipoDado');
  end;
end;

end.
