unit AqDrop.Core.Types;

interface

{$I 'AqDrop.Core.Defines.inc'}

type

{$IFNDEF AQMOBILE}
  TAqAnsiCharSet = set of AnsiChar;
{$ENDIF}

  TAqDataType = (
    adtUnknown,
    adtBoolean,
    adtEnumerated,
    adtUInt8,
    adtInt8,
    adtUInt16,
    adtInt16,
    adtUInt32,
    adtInt32,
    adtUInt64,
    adtInt64,
    adtCurrency,
    adtDouble,
    adtSingle,
    adtDatetime,
    adtDate,
    adtTime,
    adtAnsiChar,
    adtChar,
    adtAnsiString,
    adtString,
    adtWideString,
    adtSet,
    adtClass,
    adtMethod,
    adtVariant,
    adtRecord,
    adtInterface);


const
  adtIntTypes = [adtUInt8..adtInt64];

implementation

end.
