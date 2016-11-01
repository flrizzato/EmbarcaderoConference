{

TMongoWire: bsonDoc.pas

Copyright 2010-2016 Stijn Sanders
Made available under terms described in file "LICENSE"
https://github.com/stijnsanders/TMongoWire

}
unit bsonDoc;

{$WARN SYMBOL_PLATFORM OFF}
{$D-}
{$L-}

interface

uses
  ComObj, ActiveX, SysUtils, WinTypes;

const
  //bsonElement
  bsonDouble = $00000001;
  bsonString = $00000002;
  bsonEmbeddedDocument = $00000003;
  bsonArray = $00000004;
  bsonBinary = $00000005;
  bsonObjectID = $00000007;
  bsonBoolean = $00000008;
  bsonUTCDateTime = $00000009;
  bsonNULL = $0000000A;
  bsonRegEx = $0000000B;
  bsonJavaScriptCode = $0000000D;
  bsonSymbol = $0000000E;
  bsonJavaScriptCodeWithScope = $0000000F;
  bsonInt32 = $00000010;
  bsonTimestamp = $00000011;
  bsonInt64 = $00000012;
  bsonMinKey = $FFFFFFFF;
  bsonMaxKey = $0000007F;

  //bsonBinarySubType
  bsonBinaryGeneric = $00000000;
  bsonBinaryFunction = $00000001;
  bsonBinaryOldBinary = $00000002;
  bsonBinaryUUID = $00000003;
  bsonBinaryMD5 = $00000005;
  bsonBinaryUserDefined = $00000006;

  //special prefix with unassigned(?) unicode symbols from the Special range
  bsonJavaScriptCodePrefix:WideString=#$FFF1'bsonJavaScriptCode'#$FFF2;
  bsonRegExPrefix:WideString=#$FFF1'bsonRegEx'#$FFF2;
  bsonObjectIDPrefix:WideString='ObjectID("';
  bsonObjectIDSuffix:WideString='")';
  bsonObjectID_L=36;//=Length(bsonObjectIDPrefix)+24+Length(bsonObjectIDSuffix);

  //COM GUID's
  IID_IBSONDocument
    : TGUID = '{42534F4E-0000-0001-C000-000000000001}';
  CLASS_BSONDocument
    : TGUID = '{42534F4E-0000-0002-C000-000000000002}';
  IID_IBSONDocumentEnumerator
    : TGUID = '{42534F4E-0000-0003-C000-000000000003}';

type
  IBSONDocument = interface(IUnknown)
    ['{42534F4E-0000-0001-C000-000000000001}']
    function Get_Item(const Key: WideString): OleVariant; safecall;
    procedure Set_Item(const Key: WideString; Value: OleVariant); safecall;
    function ToVarArray:OleVariant; safecall;
    procedure Clear; safecall;
    property Item[const Key: WideString]: OleVariant read Get_Item write Set_Item; default;
  end;

  //TODO: ActiveX enumerator over elements

  //BSON document as interfaced object allows storage in a variant variable
  TBSONDocument = class(TInterfacedObject, IBSONDocument, IPersistStream)
  private
    FDirty:boolean;
    FElementIndex,FElementSize:integer;
    FElements:array of record
      SortIndex,LoadIndex:integer;
      Key:WideString;
      Value:OleVariant;
    end;
    FLoadIndex,FGotIndex,FGotSorted:integer;
    FGotMatch:boolean;
    function GetKeyIndex(const Key: WideString): boolean;
  protected
    function Get_Item(const Key: WideString): OleVariant; safecall;
    procedure Set_Item(const Key: WideString; Value: OleVariant); safecall;
    function GetClassID(out classID: TCLSID): HResult; stdcall;
    function IsDirty: HResult; stdcall;
    function GetSizeMax(out cbSize: Largeint): HResult; stdcall;
  public
    procedure AfterConstruction; override;
    destructor Destroy; override;
    function Load(const stm: IStream): HResult; stdcall;
    function Save(const stm: IStream; fClearDirty: BOOL): HResult; stdcall;
    function ToVarArray:OleVariant; safecall;
    procedure Clear; safecall;
    property Item[const Key: WideString]: OleVariant read Get_Item write Set_Item; default;
  end;

  EBSONException=class(Exception);

{
  BSON document builder
  pass an array of key/value-pairs,
  use value '[' to start an embedded document,
  and key ']' to close it.
  example:
    MongoWireQuery1.Query('mydb1.orders',BSON([
      'confirmed',false,
      '$orderby','[',
        'created',-1,
      ']'
    ]);
}
function BSON: IBSONDocument; overload;
function BSON(x: array of OleVariant): IBSONDocument; overload;
function BSON(x: OleVariant): IBSONDocument; overload;

type
  IBSONDocumentEnumerator = interface(IUnknown)
    ['{42534F4E-0000-0003-C000-000000000003}']
    procedure SetStream(const stm: IStream); stdcall;
    procedure Add(pos: int64); stdcall;
    function GetCount: integer; stdcall;
    function Next(const doc: IBSONDocument): boolean; stdcall;
    procedure Skip(n: integer); safecall;
    procedure Reset; safecall;
    property Count: integer read GetCount;
  end;

  TBSONDocumentEnumerator = class(TInterfacedObject,
    IBSONDocumentEnumerator)//IPersistStream?
  private
    FData:IStream;
    FPos:array of int64;
    FPosIndex,FPosSize,FPosCurrent:integer;
  public
    procedure AfterConstruction; override;
    destructor Destroy; override;
    procedure SetStream(const stm: IStream); stdcall;
    function GetCount: integer; stdcall;
    procedure Add(pos: int64); stdcall;
    //Save?Dirty?
    function Next(const doc: IBSONDocument): boolean; stdcall;
    procedure Skip(n: integer); safecall;
    procedure Reset; safecall;
  end;

function BSONEnum: IBSONDocumentEnumerator; overload;
function BSONEnum(const v:OleVariant): IBSONDocumentEnumerator; overload;

implementation

uses
  Classes,
  {$IFDEF BSON_SUPPORT_REGEX}
  VBScript_RegExp_55_TLB,
  {$ENDIF}
  Variants;

const
  BSONArrayBaseIndex=0;//1?
  BSONDetectVarArrayType=true;

procedure TBSONDocument.AfterConstruction;
begin
  inherited;
  FDirty:=false;
  FElementIndex:=0;
  FElementSize:=0;
  FGotIndex:=0;
  FGotSorted:=0;
  FGotMatch:=false;
  FLoadIndex:=0;
end;

destructor TBSONDocument.Destroy;
var
  i:integer;
begin
  for i:=0 to FElementIndex-1 do VarClear(FElements[i].Value);
  inherited;
end;

function TBSONDocument.GetSizeMax(out cbSize: Largeint): HResult;
begin
  //TODO: calculate total size
  raise EInvalidOperation.Create('Not implemented');
end;

function TBSONDocument.GetKeyIndex(const Key: WideString):boolean;
var
  a,b,c,d,x:integer;
begin
  //case sensitivity?
  //check last getindex, speeds up set right after get
  if FGotMatch and (CompareStr(Key,FElements[FGotIndex].Key)=0) then
   begin
    //assert FGotIndex=FSorted[FGotSorted];
    Result:=true;
   end
  else
   begin
    a:=0;
    b:=FElementIndex-1;
    d:=FElementIndex;
    FGotMatch:=false;//default
    while b>=a do
     begin
      c:=(a+b) div 2;
      d:=FElements[c].SortIndex;
      //if c=a? c=b?
      x:=CompareStr(Key,FElements[d].Key);
      if x=0 then
       begin
        a:=c;
        b:=c-1;
        FGotMatch:=true;
       end
      else
        if x<0 then
          if b=c then dec(b) else b:=c
        else
          if a=c then inc(a) else a:=c;
     end;
    FGotSorted:=a;
    FGotIndex:=d;
    Result:=FGotMatch;
   end;
end;

function TBSONDocument.Get_Item(const Key: WideString): OleVariant;
begin
  if GetKeyIndex(Key) and (FElements[FGotIndex].LoadIndex=FLoadIndex) then
    Result:=FElements[FGotIndex].Value
  else
    Result:=Null;
end;

procedure TBSONDocument.Set_Item(const Key: WideString; Value: OleVariant);
var
  i:integer;
const
  GrowStep=$20;//not too much, not too little (?)
begin
  //if ((VarType(Value) and varArray)<>0) and (VarArrayDimCount(v)>1) then
  //  raise EBSONException.Create('VarArray: multi-dimensional arrays not supported');
  if not GetKeyIndex(Key) then
   begin
    if FElementIndex=FElementSize then
     begin
      inc(FElementSize,GrowStep);
      SetLength(FElements,FElementSize);
     end;
    for i:=FElementIndex-1 downto FGotSorted do
      FElements[i+1].SortIndex:=FElements[i].SortIndex;
    FGotIndex:=FElementIndex;
    inc(FElementIndex);
    FElements[FGotSorted].SortIndex:=FGotIndex;
    FElements[FGotIndex].Key:=Key;
   end;
  FElements[FGotIndex].Value:=Value;
  FElements[FGotIndex].LoadIndex:=FLoadIndex;
  //TODO: if VarType(Value)=varEmpty then drop element
  FDirty:=true;
end;

function TBSONDocument.IsDirty: HResult;
begin
  if FDirty then Result:=S_OK else Result:=S_FALSE; 
end;

function TBSONDocument.Load(const stm: IStream): HResult;
var
  i,lstart,ltotal,ltmax:integer;
  procedure stmRead(p:pointer;s:integer);
  var
    l:integer;
  begin
    OleCheck(stm.Read(p,s,@l));
    if l<>s then
      raise EBSONException.Create('Unexpected end of stream');
    inc(ltotal,s);
    if ltotal>ltmax then
      raise EBSONException.Create('More BSON data than declared');
  end;
var //outside of stmReadCString to recycle memory
  ss:AnsiString;
  sx,sl:integer;
  function stmReadCString: WideString;
  var
    c:AnsiChar;
  begin
    sx:=0;
    stmRead(@c,1);
    while c<>#0 do
     begin
      if sx=sl then
       begin
        inc(sl,$100);//grow in steps
        SetLength(ss,sl);
       end;
      inc(sx);
      ss[sx]:=c;
      stmRead(@c,1);
     end;
    Result:=UTF8Decode(Copy(ss,1,sx));
  end;
  function stmReadString: WideString;
  var
    l:integer;
    s:AnsiString;
  begin
    stmRead(@l,4);
    if l<2 then s:='' else
     begin
      SetLength(s,l-1);
      stmRead(@s[1],l-1);
     end;
    //read closing null
    l:=0;
    stmRead(@l,1);
    if l<>0 then
      raise EBSONException.Create('BSON string incorrectly terminated at offset '+IntToHex(lstart,8));
    Result:=UTF8Decode(s);
  end;
  {$IFDEF BSON_SUPPORT_REGEX}
  function stmReadRegEx: IRegExp2;
  var
    i:integer;
    s:string;
  begin
    Result:=CoRegExp.Create;
    REsult.Pattern:=stmReadCString;
    s:=stmReadCString;
    for i:=1 to Length(s)-1 do
      case s[i] of
        'i','I':Result.IgnoreCase:=true;
        'm','M':Result.Multiline:=true;
        'g','G':Result.Global:=true;
        //'x','X':;//verbose
        //'l','L':;//locale
        //'s','S':;//dotall
        //'u','U':;//unicode
        else raise EBSONException.Create('Unsupported regex option "'+s+'" at offset '+IntToHex(lstart,8));
      end;
  end;
  {$ENDIF}
  function stmReadBSONDocument(ReuseDoc:boolean; var vv:OleVariant): boolean;
  var
    p1,p2:Uint64;
    d:TBSONDocument;
    dd:IBSONDocument;
  begin
    OleCheck(stm.Seek(0,soFromCurrent,p1));
    if ReuseDoc and (VarType(FElements[FGotIndex].Value)=varUnknown) and
      (IUnknown(FElements[FGotIndex].Value).QueryInterface(IID_IBSONDocument,dd)=S_OK) then
     begin
      FElements[FGotIndex].LoadIndex:=FLoadIndex;
      (dd as IPersistStream).Load(stm);
      Result:=true;
     end
    else
     begin
      d:=TBSONDocument.Create;
      try
        d.Load(stm);
        vv:=(d as IBSONDocument);
      except //not finally!
        d.Free;
        raise;
      end;
      Result:=false;
     end;
    OleCheck(stm.Seek(0,soFromCurrent,p2));
    inc(ltotal,p2-p1);
  end;
  function stmReadBSONDocArray(const v:OleVariant): boolean;
  var
    e:IBSONDocumentEnumerator;
    p:Uint64;
    l:integer;
    n:WideString;
  begin
    if (VarType(v)=varUnknown) and
      (IUnknown(v).QueryInterface(IID_IBSONDocumentEnumerator,e)=S_OK) then
     begin
      FElements[FGotIndex].LoadIndex:=FLoadIndex;
      e.SetStream(stm);
      repeat
        OleCheck(stm.Seek(0,soFromCurrent,p));
        e.Add(p);
        stmRead(@l,4);
        dec(l,4);
        OleCheck(stm.Seek(l,soFromCurrent,p));
        inc(ltotal,l);
        l:=0;
        stmRead(@l,1);
        if l=0 then n:='' else
         begin
          if l<>bsonEmbeddedDocument then
            raise EBSONException.Create('Can''t mix documents and non-documents with IBSONDocumentEnumerator');
          n:=stmReadCString;
          //assert n=IntToStr(e.Count);
         end;
      until n='';
      Result:=true;
     end
    else
      Result:=false;
  end;
var
  j:integer;
  v:OleVariant;
  k:WideString;
  o:array[0..15] of byte;
  ii:int64 absolute o;
  dd:double absolute o;
  pp:pointer absolute o;
  gg:TGUID absolute o;
  vindex:integer;
  vstack:array of record
    vkey:WideString;
    vv:array of OleVariant;
    vl,vi,vlength,vstart:integer;
    vt:TVarType;
  end;
const
  hex:array[0..15] of char='0123456789abcdef';
  vstackValuesGrowStep=$100;
begin
  stm._AddRef;
  try
    inc(FLoadIndex);
    sl:=0;
    ltotal:=0;
    lstart:=0;
    ltmax:=4;
    stmRead(@ltMax,4);
    vindex:=-1;
    SetLength(vstack,0);

    while ltotal<ltmax do
     begin
      i:=0;
      lstart:=ltotal;
      stmRead(@i,1);
      if i=0 then //end of document
       begin
        if vindex=-1 then
         begin
          if ltotal<>ltmax then
            raise EBSONException.Create('Less BSON data than declared');
         end
        else
         begin
          if ltotal-vstack[vindex].vstart>vstack[vindex].vlength then
            raise EBSONException.Create('More BSON array data than declared at offset '+IntToHex(lstart,8));
          SetLength(vstack[vindex].vv,vstack[vindex].vi);
          //create variant array of variant (from pascal array of variant)
          v:=VarArrayCreate([BSONArrayBaseIndex,vstack[vindex].vi-1+BSONArrayBaseIndex],vstack[vindex].vt);
          for j:=0 to vstack[vindex].vi-1 do v[j]:=vstack[vindex].vv[j];
          //store item
          if vindex=0 then
            Set_Item(vstack[vindex].vkey,v)
          else
           begin
            i:=vindex-1;
            if vstack[i].vi=vstack[i].vl then
             begin
              inc(vstack[i].vl,vstackValuesGrowStep);//grow in steps
              SetLength(vstack[i].vv,vstack[i].vl);
             end;
            vstack[i].vv[vstack[i].vi]:=v;
            inc(vstack[i].vi);
           end;
          //pop from array stack
          SetLength(vstack[vindex].vv,0);
          dec(vindex);
          //SetLength(vstack,vindex);
         end;
       end
      else
       begin
        k:=stmReadCString;
        v:=Null;//VarClear
        //TODO: store value somewhere?
        case i of
          bsonDouble:
           begin
            stmRead(@dd,8);
            v:=dd;
           end;
          bsonString:
            v:=stmReadString;
          bsonEmbeddedDocument:
            if (vindex=0) and GetKeyIndex(vstack[vindex].vkey) and
              stmReadBSONDocArray(FElements[FGotIndex].Value) then
              vindex:=-2 //see below
            else
              if stmReadBSONDocument((vindex=-1) and GetKeyIndex(k),v) then
                vindex:=-2;//see below
          bsonArray:
           begin
            //push onto array stack
            inc(vindex);
            SetLength(vstack,vindex+1);
            vstack[vindex].vkey:=k;
            vstack[vindex].vi:=-1;
            vstack[vindex].vl:=0;
            vstack[vindex].vstart:=ltotal;
            vstack[vindex].vt:=varVariant;//default, see BSONDetectVarArrayType below
            stmRead(@vstack[vindex].vlength,4);//array document length
           end;
          bsonBinary:
           begin
            stmRead(@i,4);
            stmRead(@o[11],1);
            //TODO: store value somewhere?
            case o[11] of
              bsonBinaryGeneric,bsonBinaryOldBinary,bsonBinaryUserDefined:
               begin
                //
                v:=VarArrayCreate([BSONArrayBaseIndex,i-1+BSONArrayBaseIndex],varByte);
                pp:=VarArrayLock(v);
                try
                  stmRead(pp,i);
                finally
                  VarArrayUnlock(v);
                end;
               end;
              bsonBinaryFunction:
               begin
                //TODO
                raise EInvalidOperation.Create('Not Implemented');
               end;
              bsonBinaryUUID:
               begin
                if i<>16 then
                  raise EBSONException.Create('Unexpected UUID length ('+
                    IntToStr(i)+') at offset '+IntToHex(lstart,8));
                stmRead(@gg,16);
                //TODO try to rig into varStrArg
                v:=GUIDToString(gg);
               end;
              bsonBinaryMD5:
               begin
                //TODO
                raise EInvalidOperation.Create('Not Implemented');
               end;
              else
                raise EBSONException.Create('Unknown BSON binary type '+
                  IntToHex(o[11],2)+' at offset '+IntToHex(lstart,8));
            end;
           end;
          bsonObjectID:
           begin
            stmRead(@o[0],12);
            v:=bsonObjectIDPrefix+
              hex[o[00] shr 4]+hex[o[00] and $F]+
              hex[o[01] shr 4]+hex[o[01] and $F]+
              hex[o[02] shr 4]+hex[o[02] and $F]+
              hex[o[03] shr 4]+hex[o[03] and $F]+
              hex[o[04] shr 4]+hex[o[04] and $F]+
              hex[o[05] shr 4]+hex[o[05] and $F]+
              hex[o[06] shr 4]+hex[o[06] and $F]+
              hex[o[07] shr 4]+hex[o[07] and $F]+
              hex[o[08] shr 4]+hex[o[08] and $F]+
              hex[o[09] shr 4]+hex[o[09] and $F]+
              hex[o[10] shr 4]+hex[o[10] and $F]+
              hex[o[11] shr 4]+hex[o[11] and $F]+
              bsonObjectIDSuffix;
           end;
          bsonBoolean:
           begin
            i:=0;
            stmRead(@i,1);
            v:=boolean(i<>0);
           end;
          bsonUTCDateTime:
           begin
            stmRead(@ii,8);
            v:=VarFromDateTime(ii/MSecsPerDay+UnixDateDelta);
           end;
          bsonNULL:;//v:=Null;
          bsonRegEx:
            {$IFDEF BSON_SUPPORT_REGEX}
            v:=stmReadRegEx;
            {$ELSE}
            v:=bsonRegExPrefix+'/'+stmReadCString+'/'+stmReadCString;
            {$ENDIF}
          bsonJavaScriptCode:
            v:=bsonJavaScriptCodePrefix+stmReadString;//TODO: find active script interface?
          bsonSymbol:
            v:=stmReadString;//?
          bsonJavaScriptCodeWithScope:
           begin
            //TODO
            raise EInvalidOperation.Create('Not Implemented');
           end;
          bsonInt32:
           begin
            stmRead(@i,4);
            v:=i;
           end;
          bsonTimestamp:
           begin
            stmRead(@ii,8);
            v:=ii;//convert?
           end;
          bsonInt64:
           begin
            stmRead(@ii,8);
            v:=ii;
           end;
          else
            raise EBSONException.Create('Unknown BSON element type '+
              IntToHex(i,2)+' at offset '+IntToHex(lstart,8));
        end;
        if vindex=-1 then
          Set_Item(k,v) //add the element
        else if vindex=-2 then
          vindex:=-1 //see stmReadBSONDocument,stmReadBSONDocument above
        else
          if vstack[vindex].vi=-1 then
            vstack[vindex].vi:=0 //just starting
          else
           begin
            if vstack[vindex].vi=vstack[vindex].vl then
             begin
              inc(vstack[vindex].vl,vstackValuesGrowStep);//grow in steps
              SetLength(vstack[vindex].vv,vstack[vindex].vl);
             end;
            if k<>IntToStr(vstack[vindex].vi) then
              raise EBSONException.Create('Unexpected BSON array index key: "'+k+'"<>"'+
                IntToStr(vstack[vindex].vi)+'" at offset '+IntToHex(lstart,8));
            vstack[vindex].vv[vstack[vindex].vi]:=v;
            if BSONDetectVarArrayType then
              if vstack[vindex].vi=0 then vstack[vindex].vt:=VarType(v) else
                if (vstack[vindex].vt<>varVariant) and (vstack[vindex].vt<>VarType(v)) then
                  vstack[vindex].vt:=varVariant;
            inc(vstack[vindex].vi);
           end;
       end;
     end;
  finally
    stm._Release;
  end;
  FDirty:=false;
  Result:=S_OK;
  //TODO: try except Result:=E_?
end;

function TBSONDocument.Save(const stm: IStream;
  fClearDirty: BOOL): HResult;
var
  lstart,lx:UInt64;
  ltotal,li,xi:integer;
  procedure stmWrite(p:pointer;s:integer);
  var
    l:integer;
  begin
    OleCheck(stm.Write(p,s,@l));
    if l<>s then raise EBSONException.Create('Failed to write data to stream');
    inc(ltotal,s);
  end;
  procedure stmWriteCString(const s:WideString);
  var
    sx:UTF8String;
    sl:integer;
  begin
    sx:=UTF8Encode(s);
    sl:=Length(sx);
    //sx:=sx+#0;
    if sl=0 then
      stmWrite(@sl,1)
    else
      stmWrite(@sx[1],sl+1);
  end;
  procedure stmWriteString(const s:WideString);
  var
    sx:UTF8String;
    sl:integer;
  begin
    sx:=UTF8Encode(s);
    sl:=Length(sx);
    inc(sl);
    stmWrite(@sl,4);
    //sx:=sx+#0;
    if sl=1 then
     begin
      sl:=0;
      stmWrite(@sl,1);
     end
    else
      stmWrite(@sx[1],sl);
  end;
var
  uu:IUnknown;
  key:WideString;
  function TryWriteBSONDocument:boolean;
  var
    i:integer;
    ii,jj:Uint64;
    di:IBSONDocument;
  begin
    Result:=uu.QueryInterface(IID_IBSONDocument,di)=S_OK;
    if Result then
     begin
      i:=bsonEmbeddedDocument;
      stmWrite(@i,1);
      stmWriteCString(key);
      OleCheck(stm.Seek(0,soFromCurrent,ii));
      OleCheck((di as IPersistStream).Save(stm,fClearDirty));
      OleCheck(stm.Seek(0,soFromCurrent,jj));
      inc(ltotal,jj-ii);
     end;
  end;
  function TryWriteBSONDocumentEnumerator:boolean;
  var
    di:IBSONDocumentEnumerator;
  begin
    Result:=uu.QueryInterface(IID_IBSONDocumentEnumerator,di)=S_OK;
    if Result then
     begin
      raise EBSONException.Create('Save IBSONDocumentEnumerator not implemented');
      //TODO: write documents (were any dirty?)
     end;
  end;
  {$IFDEF BSON_SUPPORT_REGEX}
  function TryWriteRegExp:boolean;
  var
    i:integer;
    w:WideString;
    r:IRegExp2;
  begin
    Result:=uu.QueryInterface(IID_IRegExp2,r)=S_OK;
    if Result then
     begin
      i:=bsonRegEx;
      stmWrite(@i,1);
      stmWriteCString(key);
      stmWriteCString(r.Pattern);
      w:='';
      if r.Global then w:=w+'g';
      if r.IgnoreCase then w:=w+'i';
      if r.Multiline then w:=w+'m';
      //TODO: other regex flags
      stmWriteCString(w);
     end;
  end;
  {$ENDIF}
  function TryWriteStream:boolean;
  const
    dSize=$10000;
    IID_IStream:TGUID='{0000000C-0000-0000-C000-000000000046}';
  var
    i,j:integer;
    ii,jj:Uint64;
    ss:IStream;
    d:array[0..dSize-1] of byte;
  begin
    Result:=uu.QueryInterface(IID_IStream,ss)=S_OK;
    if Result then
     begin
      i:=bsonBinary;
      stmWrite(@i,1);
      stmWriteCString(key);
      //seek end to know full size
      OleCheck(ss.Seek(0,soFromEnd,ii));
      //TODO: check less than 2GB
      //seek start for copying
      OleCheck(ss.Seek(0,soFromBeginning,jj));
      stmWrite(@ii,4);
      i:=bsonBinaryGeneric;
      stmWrite(@i,1);
      inc(ltotal,ii);
      while ii<>0 do
       begin
        OleCheck(ss.Read(@d[0],dSize,@i));
        if i=0 then raise EBSONException.Create('Failed to read from IStream');
        OleCheck(stm.Write(@d[0],i,@j));
        if i<>j then raise EBSONException.Create('Failed to write data to stream');
        dec(ii,i);
       end;
     end;
  end;
  function TryWritePersistStream:boolean;
  const
    IID_IPersistStream:TGUID='{00000109-0000-0000-C000-000000000046}';
  var
    i,j:integer;
    ii,jj:Uint64;
    ps:IPersistStream;
  begin
    Result:=uu.QueryInterface(IID_IPersistStream,ps)=S_OK;
    if Result then
     begin
      i:=bsonBinary;
      stmWrite(@i,1);
      stmWriteCString(key);
      OleCheck(stm.Seek(0,soFromCurrent,ii));
      i:=0;//fill in later
      stmWrite(@i,4);
      i:=bsonBinaryGeneric;
      stmWrite(@i,1);
      ps.Save(stm,false);
      //fill in length
      OleCheck(stm.Seek(0,soFromCurrent,jj));
      i:=jj-ii-5;
      OleCheck(stm.Seek(0,soFromBeginning,ii));
      OleCheck(stm.Write(@i,4,@j));
      //assert j=4
      OleCheck(stm.Seek(0,soFromBeginning,jj));
     end;
  end;
  function StartsWith(const a,b:WideString):boolean;
  var
    i,l1,l2:integer;
  begin
    i:=1;
    l1:=Length(a);
    l2:=Length(b);
    while (i<=l1) and (i<=l2) and (a[i]=b[i]) do inc(i);
    Result:=i=l2+1;
  end;
var
  vt:TVarType;
  w:WideString;
  i,j,wl:integer;
  v:OleVariant;
  o:array[0..15] of byte;
  ii:int64 absolute o;
  gg:TGUID absolute o;
  dd:double absolute o;
  pp:pointer absolute o;
  bb:byte;
  IsArray:boolean;
  vindex:integer;
  vstack:array of record
    vv:OleVariant;
    vstart,vi,v1,v2:integer;
  end;
begin
  stm._AddRef;
  try
    OleCheck(stm.Seek(0,soFromCurrent,lstart));
    ltotal:=0;
    i:=0;//write now, fill in later
    stmWrite(@i,4);

    vindex:=-1;
    xi:=0;
    while (xi<FElementIndex) and (FElements[xi].LoadIndex<>FLoadIndex) do inc(xi);
    while (xi<FElementIndex) or (vindex>=0) do
     begin
      if vindex=-1 then
       begin
        key:=FElements[xi].Key;
        v:=FElements[xi].Value;
        inc(xi);
        while (xi<FElementIndex) and (FElements[xi].LoadIndex<>FLoadIndex) do inc(xi);
       end
      else
       begin
        key:=IntToStr(vstack[vindex].vi-vstack[vindex].v1);
        v:=vstack[vindex].vv[vstack[vindex].vi];
        inc(vstack[vindex].vi);
       end;

      vt:=VarType(v);
      IsArray:=(vt and varArray)<>0;
      if IsArray then
        if VarArrayDimCount(v)>1 then
          raise EInvalidOperation.Create('VarArray: multi-dimensional arrays not supported');//TODO:
      if (vt and varByRef)<>0 then
        raise EInvalidOperation.Create('VarByRef: not implemented');//TODO: arrays!!!

      if IsArray and ((vt and varTypeMask)=varByte) then
       begin
        i:=bsonBinary;
        stmWrite(@i,1);
        stmWriteCString(key);
        j:=VarArrayHighBound(v,1)-VarArrayLowBound(v,1)+1;
        stmWrite(@j,4);
        i:=bsonBinaryGeneric;
        stmWrite(@i,1);
        pp:=VarArrayLock(v);
        try
          stmWrite(pp,j);
        finally
          VarArrayUnlock(v);
        end;
       end
      else
      if IsArray then
       begin
        //push onto array stack
        inc(vindex);
        SetLength(vstack,vindex+1);
        vstack[vindex].vv:=v;
        vstack[vindex].v1:=VarArrayLowBound(v,1);
        vstack[vindex].v2:=VarArrayHighBound(v,1);
        vstack[vindex].vi:=vstack[vindex].v1;
        i:=bsonArray;
        stmWrite(@i,1);
        stmWriteCString(key);
        vstack[vindex].vstart:=ltotal;
        i:=0;
        stmWrite(@i,4);//don't know total length now, filled in later
       end
      else
       begin

        //TODO: re-use stored bson type? if any?
        case vt and varTypeMask of
          //varEmpty?
          varNull:
           begin
            {
            i:=bsonNULL;
            stmWrite(@i,1);
            stmWriteCString(key);
            }
           end;
          varSmallint,varInteger,varShortInt,varByte,varWord,varLongWord:
           begin
            i:=bsonInt32;
            stmWrite(@i,1);
            stmWriteCString(key);
            i:=v;
            stmWrite(@i,4);
           end;
          varInt64:
           begin
            i:=bsonInt64;
            stmWrite(@i,1);
            stmWriteCString(key);
            ii:=v;
            stmWrite(@ii,8);
            //TODO: detect bsonTimestamp?
           end;
          varSingle,varDouble,varCurrency:
           begin
            i:=bsonDouble;
            stmWrite(@i,1);
            stmWriteCString(key);
            dd:=v;
            stmWrite(@dd,8);
           end;
          varDate:
           begin
            i:=bsonUTCDateTime;
            stmWrite(@i,1);
            stmWriteCString(key);
            ii:=Round((VarToDateTime(v)-UnixDateDelta)*MSecsPerDay);
            stmWrite(@ii,8);
           end;
          varOleStr:
           begin
            //detect GUID //TODO try to rig varStrArg
            w:=VarToWideStr(v);
            wl:=Length(w);
            if (wl=38) and (w[1]='{') and (w[38]='}')
              and (w[10]='-') and (w[15]='-')
              and (w[20]='-') and (w[25]='-') then //and the other are hex digits?
             begin
              //assume UUID
              gg:=StringToGUID(w);
              i:=bsonBinary;
              stmWrite(@i,1);
              stmWriteCString(key);
              i:=16;//SizeOf(TGUID);
              stmWrite(@i,4);
              i:=bsonBinaryUUID;
              stmWrite(@i,1);
              stmWrite(@gg,16);
             end
            else
            //detect objectID
            if (wl=bsonObjectID_L) and StartsWith(w,bsonObjectIDPrefix) then //and the other are hex digits?
             begin
              i:=bsonObjectID;
              stmWrite(@i,1);
              stmWriteCString(key);
              j:=Length(bsonObjectIDPrefix)+1;
              for i:=0 to 11 do
               begin
                bb:=byte(AnsiChar(w[j+i*2]));
                if (bb and $F0)=$30 then o[i]:=bb shl 4 else o[i]:=(9+bb) shl 4;
                bb:=byte(AnsiChar(w[j+i*2+1]));
                if (bb and $F0)=$30 then inc(o[i],bb and $F) else inc(o[i],(9+bb) and $F);
               end;
              stmWrite(@o[0],12);
             end
            else
            //detect javascript
            if StartsWith(w,bsonJavaScriptCodePrefix) then
             begin
              i:=bsonJavaScriptCode;
              stmWrite(@i,1);
              stmWriteCString(key);
              stmWriteString(Copy(w,Length(bsonJavaScriptCodePrefix)+1,Length(w)-Length(bsonJavaScriptCodePrefix)));
             end
            else
            //detect regex
            if StartsWith(w,bsonRegExPrefix) then
             begin
              i:=bsonRegEx;
              stmWrite(@i,1);
              stmWriteCString(key);
              i:=Length(bsonRegExPrefix)+1;
              if (i<=Length(w)) and (w[i]='/') then inc(i);//TODO: support alternate regex delimiter?
              j:=i;
              while (j<=Length(w)) and (w[i]<>'/') do inc(j);
              stmWriteCString(Copy(w,i,j-i));
              stmWriteCString(Copy(w,j+1,Length(w)-j));
             end
            else
             begin
              i:=bsonString;
              stmWrite(@i,1);
              stmWriteCString(key);
              stmWriteString(w);
             end;
            //TODO: bsonJavaScriptCodeWithScope, bsonSymbol ?
           end;
          //TODO varStrArg as bsonBinaryUUID
          varBoolean:
           begin
            i:=bsonBoolean;
            stmWrite(@i,1);
            stmWriteCString(key);
            if v then i:=1 else i:=0;
            stmWrite(@i,1);
           end;
          //varVariant://TODO
          varDispatch,varUnknown:
           begin
            uu:=IUnknown(v);
            if uu<>nil then
            if not TryWriteBSONDocument then
            if not TryWriteBSONDocumentEnumerator then
            {$IFDEF BSON_SUPPORT_REGEX}
            if not TryWriteRegExp then
            {$ENDIF}
            if not TryWriteStream then
            if not TryWritePersistStream then
              raise EBSONException.Create('No supported interface found on object "'+key+'"');
           end;
          else raise EBSONException.Create('Unsupported variant type '+IntToHex(vt,4)+' "'+key+'"');
        end;
       end;

      while (vindex>=0) and (vstack[vindex].vi>vstack[vindex].v2) do
       begin
        //terminator
        i:=0;
        stmWrite(@i,1);
        //write total length
        OleCheck(stm.Seek(lstart+vstack[vindex].vstart,soFromBeginning,lx));
        i:=ltotal-vstack[vindex].vstart;
        OleCheck(stm.Write(@i,4,@li));
        //return to end position
        OleCheck(stm.Seek(lstart+ltotal,soFromBeginning,lx));
        //pop from array stack
        vstack[vindex].vv:=Null;
        dec(vindex);
        //SetLength(vstack,vindex);
       end;

     end;
    //terminator
    i:=0;
    stmWrite(@i,1);

    //write total length
    OleCheck(stm.Seek(lstart,soFromBeginning,lx));
    OleCheck(stm.Write(@ltotal,4,@li));
    //assert(li=4);

    //return to end position
    OleCheck(stm.Seek(ltotal-4,soFromCurrent,lx));
    //assert(lx=lstart+ltotal);

  finally
    stm._Release;
  end;
  if fClearDirty then FDirty:=false;
  Result:=S_OK;
  //TODO: try except Result:=E_?
end;

function TBSONDocument.GetClassID(out classID: TCLSID): HResult;
begin
  classID:=CLASS_BSONDocument;
  Result:=S_OK;
end;

procedure TBSONDocument.Clear;
var
  i:integer;
  uu:IUnknown;
  d:IBSONDocument;
  e:IBSONDocumentEnumerator;
begin
  FDirty:=false;
  for i:=0 to FElementIndex-1 do
    if VarType(FElements[i].Value)=varUnknown then
     begin
      uu:=IUnknown(FElements[i].Value);
      if uu.QueryInterface(IID_IBSONDocument,d)=S_OK then
        d.Clear
      else
      if uu.QueryInterface(IID_IBSONDocumentEnumerator,e)=S_OK then
        e.SetStream(nil)
      else
        VarClear(FElements[i].Value);
     end
    else
      VarClear(FElements[i].Value);
  FGotMatch:=false;
end;

function TBSONDocument.ToVarArray: OleVariant;
var
  i,l:integer;
begin
  l:=0;
  for i:=0 to FElementIndex-1 do
    if FElements[i].LoadIndex=FLoadIndex then inc(l);
      //and not(VarIsNull(FElements[i].Value))?
  Result:=VarArrayCreate([0,l-1,0,1],varVariant);
  l:=0;
  for i:=0 to FElementIndex-1 do
    if FElements[i].LoadIndex=FLoadIndex then
     begin
      Result[l,0]:=FElements[i].Key;
      Result[l,1]:=FElements[i].Value;
      inc(l);
     end;
end;

function BSON:IBSONDocument; //overload;
begin
  Result:=TBSONDocument.Create as IBSONDocument;
end;

function BSON(x:array of OleVariant):IBSONDocument; //overload;
var
  i,di,l:integer;
  d:array of IBSONDocument;
  key:WideString;
const
  GrowStep=8;
begin
  i:=0;
  l:=Length(x);
  di:=0;
  SetLength(d,8);
  d[di]:=TBSONDocument.Create as IBSONDocument;
  while i<l do
   begin
    //key
    key:=VarToStr(x[i]);
    if key=']' then
     begin
      //pop from stack
      d[di]:=nil;
      dec(di);
     end
    else
     begin
      if key='[' then raise Exception.Create('BSON builder: embedded document needs key at index '+IntToStr(i)); 
      //value
      inc(i);
      if (VarType(x[i])=varOleStr) and (x[i]='[') then
       begin
        //push on stack
        inc(di);
        if di=Length(d) then SetLength(d,di+GrowStep);
        d[di]:=TBSONDocument.Create as IBSONDocument;
        d[di-1].Item[key]:=d[di];
       end
      else
        if i<l then
          d[di].Item[key]:=x[i]
        else
          raise Exception.Create('BSON builder: last key is missing value');
     end;
    inc(i);
   end;
  //if di>0 then raise Exception.Create('BSON builder: '+IntToStr(di)+' closing brackets missing');?
  Result:=d[0];
  //TODO: Result.FIsDirty:=false?
end;

function BSON(x: OleVariant): IBSONDocument; overload;
begin
  Result:=IUnknown(x) as IBSONDocument;
end;

{ TBSONDocumentEnumerator }

procedure TBSONDocumentEnumerator.AfterConstruction;
begin
  inherited;
  FData:=nil;
  FPosIndex:=0;
  FPosSize:=0;
  FPosCurrent:=0;
end;

destructor TBSONDocumentEnumerator.Destroy;
begin
  FData:=nil;
  SetLength(FPos,0);
  inherited;
end;

procedure TBSONDocumentEnumerator.SetStream(const stm: IStream);
begin
  FData:=stm;
  FPosIndex:=0;
  FPosCurrent:=0;
end;

procedure TBSONDocumentEnumerator.Add(pos: int64);
begin
  if FPosIndex=FPosSize then
   begin
    inc(FPosSize,128);//grow
    SetLength(FPos,FPosSize);
   end;
  FPos[FPosIndex]:=pos;
  inc(FPosIndex);
end;

function TBSONDocumentEnumerator.GetCount: integer;
begin
  Result:=FPosIndex;
end;

function TBSONDocumentEnumerator.Next(const doc: IBSONDocument): boolean;
var
  p,q:Uint64;
begin
  //TODO: detect dirty (deep!), then update into stream??
  if (FPosCurrent<0) or (FPosCurrent>=FPosIndex) then Result:=false else
   begin
    OleCheck(FData.Seek(0,soFromCurrent,q));//keep
    OleCheck(FData.Seek(FPos[FPosCurrent],soFromBeginning,p));//set
    (doc as IPersistStream).Load(FData);
    OleCheck(FData.Seek(q,soFromBeginning,p));//restore
    inc(FPosCurrent);
    Result:=true;
   end;
end;

procedure TBSONDocumentEnumerator.Reset;
begin
  FPosCurrent:=0;
end;

procedure TBSONDocumentEnumerator.Skip(n: integer);
begin
  if (FPosCurrent+n>FPosIndex) or (FPosCurrent+n<0) then
    raise EBSONException.Create('IBSONDocumentEnumerator.Skip can''t skip past count');
  inc(FPosCurrent,n);
end;

function BSONEnum:IBSONDocumentEnumerator;
begin
  Result:=TBSONDocumentEnumerator.Create;
end;

function BSONEnum(const v:OleVariant): IBSONDocumentEnumerator; overload;
begin
  if not((VarType(v)=varUnknown) and
    (IUnknown(v).QueryInterface(IID_IBSONDocumentEnumerator,Result)=S_OK)) then
    raise EBSONException.Create('Value is not IBSONDocumentEnumerator');
end;

end.
