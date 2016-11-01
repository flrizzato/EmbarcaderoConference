{

TMongoWire: bsonUtils.pas

Copyright 2010-2014 Stijn Sanders
Made available under terms described in file "LICENSE"
https://github.com/stijnsanders/TMongoWire

}
unit bsonUtils;

interface

uses SysUtils, bsonDoc;

function BsonToJson(Doc:IBSONDocument):WideString;
function JsonToBson(const jsonData:WideString):IBSONDocument;
procedure JsonIntoBson(const jsonData:WideString;doc:IBSONDocument); overload;
procedure JsonIntoBson(const jsonData:WideString; doc:IBSONDocument;
  var EndIndex:integer); overload;

type
  EJsonDecodeException=class(Exception);
  EJsonEncodeException=class(Exception);

implementation

uses Classes, Variants;

function BsonToJson(Doc:IBSONDocument):WideString;
  function EncodeStr(x:OleVariant):WideString;
  const
    resGrowStep=$100;
    hex:array[0..15] of WideChar=(
      '0','1','2','3','4','5','6','7',
      '8','9','A','B','C','D','E','F');
  var
    xx:WideString;
    i,j,k,l:integer;
    w:word;
  begin
    xx:=VarToWideStr(x);
    l:=Length(xx);
    SetLength(Result,l);
    i:=1;
    j:=0;
    k:=l;
    while i<=l do
     begin
      w:=word(xx[i]);
      case w of
        0..31,word('"'),word('\'),word('/'):
         begin
          if j+2>k then
           begin
            k:=((k div resGrowStep)+1)*resGrowStep;
            SetLength(Result,k);
           end;
          inc(j);
          Result[j]:='\';
          inc(j);
          case w of
            8:Result[j]:='b';
            9:Result[j]:='t';
            10:Result[j]:='n';
            12:Result[j]:='f';
            13:Result[j]:='r';
            word('"'),word('\'),word('/'):Result[j]:=xx[i];
            else
             begin
              Result[j]:='u';
              if j+4>k then
               begin
                k:=((k div resGrowStep)+1)*resGrowStep;
                SetLength(Result,k);
               end;
              inc(j);Result[j]:=hex[w shr 12];
              inc(j);Result[j]:=hex[w shr 8 and $F];
              inc(j);Result[j]:=hex[w shr 4 and $F];
              inc(j);Result[j]:=hex[w and $F];
             end;
          end;
         end;
        else
         begin
          if j>=k then
           begin
            k:=((k div resGrowStep)+1)*resGrowStep;
            SetLength(Result,k);
           end;
          inc(j);
          Result[j]:=WideChar(w);
         end;
      end;
      inc(i);
     end;
    SetLength(Result,j);
  end;
const
  stackGrowStep=$20;
var
  stack:array of record
    a:OleVariant;
    ai,al:integer;
    isDoc:boolean;
  end;
  stackLength,stackIndex:integer;
  function ExTrace:string;
  var
    i:integer;
  begin
    Result:='';
    i:=stackIndex;
    while i<>-1 do
     begin
      if stack[i].isDoc then
        Result:=' "'+VarToStr(stack[i].a[stack[i].ai-1,0])+'"'+Result
      else
        Result:=' #'+IntToStr(stack[i].ai-1)+Result;
      dec(i);
     end;
  end;
var
  firstItem:boolean;
  ods:char;
  v:OleVariant;
  vt:TVarType;
  uu:IUnknown;
  d:IBSONDocument;
begin
  //TODO: indent options?
  stackLength:=stackGrowStep;
  stackIndex:=0;
  SetLength(stack,stackLength);
  stack[stackIndex].a:=Doc.ToVarArray;
  stack[stackIndex].ai:=0;//VarArrayLowBound(
  stack[stackIndex].al:=VarArrayHighBound(stack[stackIndex].a,1)+1;
  stack[stackIndex].isDoc:=true;
  Result:='';//TODO: TStringBuilder

  {$if CompilerVersion >= 24}
  ods:= FormatSettings.DecimalSeparator;
  {$else}
  ods:=DecimalSeparator;
  {$ifend}

  try

    {$if CompilerVersion >= 24}
    FormatSettings.DecimalSeparator:='.';
    {$else}
    DecimalSeparator:='.';
    {$ifend}

    firstItem:=true;
    Result:=Result+'{';
    while stackIndex<>-1 do
     begin
      while (stack[stackIndex].ai<stack[stackIndex].al) do
       begin
        if firstItem then firstItem:=false else Result:=Result+',';
        if stack[stackIndex].isDoc then
         begin
          Result:=Result+'"'+EncodeStr(stack[stackIndex].a[stack[stackIndex].ai,0])+'":';
          v:=stack[stackIndex].a[stack[stackIndex].ai,1];
         end
        else
          v:=stack[stackIndex].a[stack[stackIndex].ai];
        inc(stack[stackIndex].ai);
        vt:=VarType(v);
        if (vt and varByRef)<>0 then
          raise EJsonEncodeException.Create('VarByRef: not implemented'+ExTrace);
        if (vt and varArray)=0 then
         begin
          //not an array, plain value
          //TODO: if (vt and varTypeMask)=varByte then BLOB?
          case vt and varTypeMask of
            varNull:Result:=Result+'null';
            varSmallint,varInteger,varShortInt,
            varByte,varWord,varLongWord,varInt64:
              Result:=Result+VarToWideStr(v);
            varSingle,varDouble,varCurrency:
              Result:=Result+FloatToStr(v);//?
            varDate://TODO:"yyyy-mm-dd hh:nn:ss.zzz"? $date?
              //Result:=Result+FloatToStr(VarToDateTime(v));//?
              Result:=Result+'"'+FormatDateTime(
                'yyyy-mm-dd"T"hh:nn:ss.zzz',VarToDateTime(v))+'"';
            varOleStr:
              Result:=Result+'"'+EncodeStr(VarToWideStr(v))+'"';
            varBoolean:
              if v then Result:=Result+'true' else Result:=Result+'false';
            varDispatch,varUnknown:
             begin
              uu:=IUnknown(v);
              if uu=nil then Result:=Result+'null'
              else
              if uu.QueryInterface(IBSONDocument,d)=S_OK then
               begin
                //push onto stack
                inc(stackIndex);
                if stackIndex=stackLength then
                 begin
                  inc(stackLength,stackGrowStep);
                  SetLength(stack,stackLength);
                 end;
                stack[stackIndex].a:=d.ToVarArray;
                stack[stackIndex].ai:=0;
                stack[stackIndex].al:=VarArrayHighBound(stack[stackIndex].a,1)+1;
                stack[stackIndex].isDoc:=true;
                Result:=Result+'{';
                firstItem:=true;
                d:=nil;
               end
              else
              //IRegExp2? IStream? IPersistStream?
                raise EJsonEncodeException.Create(
                  'No supported interface found on object'+ExTrace);
             end;
            else raise EJsonEncodeException.Create(
              'Unsupported variant type '+IntToHex(vt,4)+ExTrace);
          end;

         end
        else
         begin
          //start an array
          if VarArrayDimCount(v)>1 then
            raise EJsonEncodeException.Create(
              'VarArray: multi-dimensional arrays not supported'+ExTrace);//TODO:
          //push onto stack
          inc(stackIndex);
          if stackIndex=stackLength then
           begin
            inc(stackLength,stackGrowStep);
            SetLength(stack,stackLength);
           end;
          stack[stackIndex].a:=v;
          stack[stackIndex].ai:=VarArrayLowBound(v,1);
          stack[stackIndex].al:=VarArrayHighBound(v,1)+1;
          stack[stackIndex].isDoc:=false;
          Result:=Result+'[';
          firstItem:=true;
         end;

       end;
      while (stackIndex<>-1) and (stack[stackIndex].ai>=stack[stackIndex].al) do
       begin
        //pop from stack
        if stack[stackIndex].isDoc then
          Result:=Result+'}'
        else
          Result:=Result+']';
        VarClear(stack[stackIndex].a);
        dec(stackIndex);
        firstItem:=false;
       end;
     end;
  finally

    {$if CompilerVersion >= 24}
    FormatSettings.DecimalSeparator:=ods;
    {$else}
    DecimalSeparator:=ods;
    {$ifend}

  end;
end;

function JsonToBson(const jsonData:WideString):IBSONDocument;
begin
  Result:=BSON;
  JsonIntoBson(jsonData,Result);
end;

procedure JsonIntoBson(const jsonData:WideString;doc:IBSONDocument);
var
  i,l:integer;
begin
  JsonIntoBson(jsonData,doc,i);
  //check only whitespace left
  l:=Length(jsonData);
  while (i<=l) and (jsonData[i]<=' ') do inc(i);
  if (i<=l) then raise EJsonDecodeException.Create(
    'JSON with unexpected data past end #'+IntToStr(i));
end;

procedure JsonIntoBson(const jsonData:WideString; doc:IBSONDocument;
  var EndIndex:integer);
var
  i,l:integer;
  function SkipWhiteSpace:WideChar;
  begin
    while (i<=l) and (jsonData[i]<=' ') do inc(i);
    if i<=l then Result:=jsonData[i] else Result:=#0;
  end;
  function ExVicinity:WideString;
  const
    VicinityExtent=8;
  begin
    if i<=VicinityExtent then
      Result:=#13#10'(#'+IntToStr(i)+')"'+Copy(jsonData,1,i-1)+
        ' >>> '+jsonData[i]+' <<< '+Copy(jsonData,i+1,VicinityExtent)+'"'
    else
      Result:=#13#10'(#'+IntToStr(i)+')"...'+Copy(jsonData,i-VicinityExtent-1,VicinityExtent)+
        ' >>> '+jsonData[i]+' <<< '+Copy(jsonData,i+1,VicinityExtent)+'"';
  end;
  procedure Expect(c:WideChar;const msg:string);
  begin
    while (i<=l) and (jsonData[i]<=' ') do inc(i);
    if (i>l) or (jsonData[i]<>c) then
      raise EJsonDecodeException.Create(msg+ExVicinity);
    inc(i);
  end;
  procedure GetStringIndexes(var i1,i2:integer);
  begin
    inc(i);
    i1:=i;
    while (i<=l) and (jsonData[i]<>'"') do
     begin
      if jsonData[i]='\' then inc(i);//just skip all to skip any '"'
      inc(i);
     end;
    i2:=i;
    inc(i);
  end;
  function GetStringValue(i1,i2:integer):WideString;
  var
    ii,di,u,v,w:integer;
  begin
    //assert jsonData[i1-1]='"'
    //assert jsonData[i2]='"';
    SetLength(Result,i2-i1);
    ii:=1;
    di:=i1;
    while di<i2 do
     begin
      //assert ii<=Length(Result);
      if jsonData[di]='\' then
       begin
        inc(di);
        case char(jsonData[di]) of
          '"','\','/':Result[ii]:=jsonData[di];
          'b':Result[ii]:=#8;
          't':Result[ii]:=#9;
          'n':Result[ii]:=#10;
          'f':Result[ii]:=#12;
          'r':Result[ii]:=#13;
          'u':
           begin
            w:=0;
            for u:=0 to 3 do
             begin
              inc(di);
              v:=word(jsonData[di]);
              case v of
                $30..$39:w:=(w shl 4) or (v and $F);
                $41..$5A,$61..$7A:w:=(w shl 4) or ((v and $1F)+9);
                else raise EJsonDecodeException.Create(
                  'JSON Invalid espace sequence'+ExVicinity);
              end;
             end;
            Result[ii]:=WideChar(w);
           end;
          else raise EJsonDecodeException.Create(
            'JSON Unknown escape sequence'+ExVicinity);
        end;
       end
      else
        Result[ii]:=jsonData[di];
      inc(di);
      inc(ii);
     end;
    SetLength(Result,ii-1);
  end;
const
  stackGrowStep=$20;//not too much, not too little (?)
  arrGrowStep=$20;
var
  InObjectOrArray:boolean;
  k1,k2,v1,v2,a1,ai,al:integer;
  d:IBSONDocument;
  a:array of OleVariant;
  at:TVarType;
  procedure SetValue(v:OleVariant);
  begin
    if InObjectOrArray then
      d[GetStringValue(k1,k2)]:=v
    else
     begin
      if ai=al then
       begin
        inc(al,arrGrowStep);//not too much, not too little (?)
        SetLength(a,al);
       end;
      a[ai]:=v;
      //assert (VarType(v) and varArray)=0
      //detect same type elements array
      if at=varEmpty then at:=VarType(v) else
        case at of
          //TODO: what with signed/unsigned mixed?
          varSmallint://i2
            if not(VarType(v) in [varSmallint,
              varShortInt,varByte]) then at:=varVariant;
          varInteger://i4
            if not(VarType(v) in [varSmallint,
              varInteger,varShortInt,varByte,varWord]) then at:=varVariant;
          varWord:
            if not(VarType(v) in [varSmallint,
              varByte,varWord]) then at:=varVariant;
          varLongWord:
            if not(VarType(v) in [varSmallint,
              varShortInt,varByte,varWord,varLongWord]) then at:=varVariant;
          varInt64:
            if not(VarType(v) in [varSmallint,varInteger,varShortInt,
              varByte,varWord,varLongWord,varInt64]) then at:=varVariant;
          varVariant:;//Already creating an VarArray of variants
          //TODO: more?
          else if at<>VarType(v) then at:=varVariant;
        end;
      inc(ai);
     end;
  end;
  function GetArrayValue:OleVariant;
  var
    ii,jj:integer;
  begin
    if at=varEmpty then at:=varVariant;//empty array!
    Result:=VarArrayCreate([0,ai-a1-1],at);
    ii:=a1;
    jj:=0;
    while ii<ai do
     begin
      Result[jj]:=a[ii];
      VarClear(a[ii]);
      inc(ii);
      inc(jj);
     end;
    ai:=a1;
  end;
var
  firstItem,b:boolean;
  stack:array of record
    k1,k2:integer;
    d:IBSONDocument;
  end;
  stackIndex,stackSize:integer;
  ods:char;
  key:WideString;
  v:OleVariant;
  v64:int64;
begin
  //doc.Clear;? let caller decide.
  i:=1;
  l:=Length(jsonData);
  //object starts
  Expect('{','JSON doesn''t define an object, "{" expected.');
  stackSize:=0;
  stackIndex:=0;
  ai:=0;
  al:=0;
  InObjectOrArray:=true;
  firstItem:=true;

  {$if CompilerVersion >= 24}
  ods:= FormatSettings.DecimalSeparator;
  {$else}
  ods:=DecimalSeparator;
  {$ifend}

  try

    {$if CompilerVersion >= 24}
    FormatSettings.DecimalSeparator:='.';
    {$else}
    DecimalSeparator:='.';
    {$ifend}

    d:=doc;
    //main loop over key/values and nested objects/arrays
    while (i<=l) and (stackIndex<>-1) do
     begin
      if firstItem then firstItem:=false else
        Expect(',','JSON element not delimited by comma');
      if InObjectOrArray and (SkipWhiteSpace<>'}') then
       begin
        //key string
        {$IFDEF BSINUTILS_JSON_STRICT}
        Expect('"','JSON key string not enclosed in double quotes');
        GetStringIndexes(k1,k2);
        {$ELSE}
        if SkipWhiteSpace='"' then GetStringIndexes(k1,k2) else
         begin
          k1:=i;
          while (i<=l) and (jsonData[i]>' ') and
            (jsonData[i]<>':') and (jsonData[i]<>'"') do inc(i);
          k2:=i;
         end;
        {$ENDIF}
        Expect(':','JSON key, value not separated by colon');
       end;
      //value
      case char(SkipWhiteSpace) of
        '{','['://object or array
         begin
          b:=InObjectOrArray;
          if jsonData[i]='{' then
           begin
            //an object starts
            if InObjectOrArray then
             begin
              key:=GetStringValue(k1,k2);
              v:=d[key];//re-use existing?
              if not(VarType(v) in [varDispatch,varUnknown]) or
                (IUnknown(v).QueryInterface(IID_IBSONDocument,d)<>S_OK) then
               begin
                v:=BSON;
                d[key]:=v;
               end;
             end
            else
             begin
              //TODO: re-use BSON docs in array?
              if ai=al then
               begin
                inc(al,arrGrowStep);//not too much, not too little (?)
                SetLength(a,al);
               end;
              v:=BSON;
              a[ai]:=v;
              //detect same type elements array
              if at=varEmpty then at:=varUnknown else
                if at<>varUnknown then at:=varVariant;
              inc(ai);
             end;
            InObjectOrArray:=true;
           end
          else
            InObjectOrArray:=false;
          inc(i);
          //push onto stack
          if stackIndex=stackSize then
           begin
            inc(stackSize,stackGrowStep);
            SetLength(stack,stackSize);
           end;
          if b then //was InObjectOrArray?
           begin
            stack[stackIndex].k1:=k1;
            stack[stackIndex].k2:=k2;
            stack[stackIndex].d:=d;
           end
          else
           begin
            stack[stackIndex].k1:=a1;
            stack[stackIndex].k2:=at;
            stack[stackIndex].d:=nil;
           end;
          inc(stackIndex);
          firstItem:=true;
          if InObjectOrArray then
            d:=IUnknown(v) as IBSONDocument
          else
           begin
            a1:=ai;
            at:=varEmpty;//used to detect same type elements array
           end;
         end;

        '}',']':;//empty object or array, drop into close array below

        '"'://string
         begin
          GetStringIndexes(v1,v2);
          SetValue(GetStringValue(v1,v2));
         end;

        '0'..'9','-'://number
         begin
          b:=jsonData[i]='-';
          v1:=i;
          if b then inc(i);
          v64:=0;
          while (i<=l) and (char(jsonData[i]) in ['0'..'9']) do
           begin
            v64:=v64*10+(word(jsonData[i]) and $F);//TODO: detect overflow
            inc(i);
           end;
          if char(jsonData[i]) in ['.','e','E'] then
           begin
            //float
            inc(i);
            while (i<=l) and (char(jsonData[i]) in
              ['0'..'9','-','+','e','E']) do inc(i);
            //try except EConvertError?
            SetValue(StrToFloat(Copy(jsonData,v1,i-v1)));
           end
          else
           begin
            //integer
            if v64>=$80000000 then //int64
              if b then SetValue(-v64) else SetValue(v64)
            else if v64>=$80 then //int32
              if b then SetValue(-integer(v64)) else SetValue(integer(v64))
            else //int8
              if b then SetValue(-SmallInt(v64)) else SetValue(SmallInt(v64));
           end;
         end;

        't'://true
         begin
          inc(i);
          Expect('r','JSON true misspelled');
          Expect('u','JSON true misspelled');
          Expect('e','JSON true misspelled');
          SetValue(true);
         end;
        'f'://false
         begin
          inc(i);
          Expect('a','JSON false misspelled');
          Expect('l','JSON false misspelled');
          Expect('s','JSON false misspelled');
          Expect('e','JSON false misspelled');
          SetValue(false);
         end;
        'n'://null
         begin
          inc(i);
          Expect('u','JSON null misspelled');
          Expect('l','JSON null misspelled');
          Expect('l','JSON null misspelled');
          SetValue(Null);
         end;

        else raise EJsonDecodeException.Create(
          'JSON Unrecognized value type'+ExVicinity);
      end;
      if not firstItem then
       begin
        b:=true;
        while b do
         begin
          v:=Null;
          if InObjectOrArray then
            b:=SkipWhiteSpace='}'
          else
            if SkipWhiteSpace=']' then
              v:=GetArrayValue
            else
              b:=false;
          if b then
           begin
            inc(i);
            //pop from stack
            if stackIndex=0 then
             begin
              EndIndex:=i;
              dec(stackIndex);
              b:=false;
             end
            else
             begin
              dec(stackIndex);
              if stack[stackIndex].d=nil then
               begin
                a1:=stack[stackIndex].k1;
                at:=stack[stackIndex].k2;
                InObjectOrArray:=false;
               end
              else
               begin
                d:=stack[stackIndex].d;
                k1:=stack[stackIndex].k1;
                k2:=stack[stackIndex].k2;
                stack[stackIndex].d:=nil;
                InObjectOrArray:=true;
               end;
             end;
            //set array
            if not VarIsNull(v) then SetValue(v);
           end;
         end;
       end;
     end;
    if stackIndex<>-1 then raise EJsonDecodeException.Create(
      'JSON with '+IntToStr(stackIndex+1)+' objects or arrays not closed');
  finally

    {$if CompilerVersion >= 24}
    FormatSettings.DecimalSeparator:=ods;
    {$else}
    DecimalSeparator:=ods;
    {$ifend}

  end;
end;

end.
