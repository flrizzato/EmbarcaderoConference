{

TMongoWire: mongoStream.pas

Copyright 2010-2016 Stijn Sanders
Made available under terms described in file "LICENSE"
https://github.com/stijnsanders/TMongoWire

}
unit mongoStream;

{$D-}
{$L-}

interface

uses Classes, mongoWire, bsonDoc;

type
  TMongoStream = class(TStream)
  private
    Fdb:TMongoWire;
    Fprefix:WideString;
    Fdata,Fchunk:IBSONDocument;
    Fsize,FchunkSize,FchunkIndex,FchunkPos:integer;
    procedure InitData;
  public
    constructor Create(db:TMongoWire;const prefix:WideString;id:OleVariant); overload;
    constructor Create(db:TMongoWire;const prefix:WideString;filequery:IBSONDocument); overload;
    class function Add(db:TMongoWire;prefix:WideString;stream:TStream;info:IBSONDocument):OleVariant; overload;
    class function Add(db:TMongoWire;const prefix,filepath:WideString):OleVariant; overload;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
    procedure SetSize(NewSize: Longint); override;
    function Write(const Buffer; Count: Longint): Longint; override;
    procedure SaveToStream(Stream: TStream);
    procedure SaveToFile(const FileName: string);
  end;

const
  //do not localize
  mongoStreamFilesSuffix='.files';
  mongoStreamChunksSuffix='.chunks';
  mongoStreamIDField='_id';
  mongoStreamLengthField='length';
  mongoStreamChunkSizeField='chunkSize';
  mongoStreamFilesIDField='files_id';
  mongoStreamNField='n';
  mongoStreamDataField='data';
  mongoStreamFileNameField='filename';
  mongoStreamUploadDateField='uploadDate';

implementation

uses SysUtils, Variants, mongoID;

const
  //do not localize
  mongoStreamDefaultPrefix='fs';
  mongoStreamDefaultChunkSize=$3FC00;//255KiB

{ TMongoStream }

constructor TMongoStream.Create(db: TMongoWire; const prefix: WideString;
  id: OleVariant);
begin
  inherited Create;
  Fdb:=db;//assert Fdb.Connected
  Fprefix:=prefix;
  if Fprefix='' then Fprefix:=mongoStreamDefaultPrefix;
  Fdata:=Fdb.Get(Fprefix+mongoStreamFilesSuffix,BSON([mongoStreamIDField,id]));
  InitData;
end;

constructor TMongoStream.Create(db: TMongoWire; const prefix: WideString;
  filequery: IBSONDocument);
begin
  inherited Create;
  Fdb:=db;//assert Fdb.Connected
  Fprefix:=prefix;
  if Fprefix='' then Fprefix:=mongoStreamDefaultPrefix;
  Fdata:=Fdb.Get(Fprefix+mongoStreamFilesSuffix,filequery);
  InitData;
end;

procedure TMongoStream.InitData;
var
  v:OleVariant;
begin
  Fsize:=Fdata[mongoStreamLengthField];
  v:=Fdata[mongoStreamChunkSizeField];
  if VarIsNumeric(v) then
    FchunkSize:=v
  else
    FchunkSize:=mongoStreamDefaultChunkSize;
  FchunkIndex:=0;
  Fchunk:=nil;
  //TODO: detect any change to data?
end;

function TMongoStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
var
  i:integer;
begin
  case Origin of
    soBeginning:Result:=Offset;
    soCurrent:Result:=FchunkIndex*FchunkSize+FchunkPos+Offset;
    soEnd:Result:=FSize-Offset;
    else
      raise EMongoException.Create('TMongoStream.Seek unsopported offset parameter');
  end;
  i:=FchunkIndex;
  FchunkIndex:=Result div FchunkSize;
  FchunkPos:=Result mod FchunkSize;
  if FchunkIndex<>i then Fchunk:=nil;
end;

function TMongoStream.Read(var Buffer; Count: Integer): Longint;
var
  v:OleVariant;
  p:PAnsiChar;
begin
  if Fchunk=nil then
    Fchunk:=Fdb.Get(Fprefix+mongoStreamChunksSuffix,BSON([
      mongoStreamFilesIDField,Fdata[mongoStreamIDField],
      mongoStreamNField,FchunkIndex
    ]));
  if FchunkPos+Count>FchunkSize then Result:=FchunkSize-FchunkPos else Result:=Count;
  if FchunkIndex*FchunkSize+FchunkPos+Result>Fsize then Result:=Fsize-FchunkIndex*FchunkSize-FchunkPos;
  if Result<>0 then
   begin
    v:=Fchunk[mongoStreamDataField];//assert var array of byte
    p:=VarArrayLock(v);
    try
      Move(p[FchunkPos],Buffer,Result);
    finally
      VarArrayUnlock(v);
    end;
    inc(FchunkPos,Result);
    if FchunkPos>=FchunkSize then
     begin
      Fchunk:=nil;
      FchunkPos:=0;
      inc(FchunkIndex);
     end;
   end;
end;

procedure TMongoStream.SaveToFile(const FileName: string);
var
  f:TFileStream;
begin
  f:=TFileStream.Create(FileName,fmCreate);
  try
    SaveToStream(f);
  finally
    f.Free;
  end;
end;

procedure TMongoStream.SaveToStream(Stream: TStream);
var
  i,s,p:integer;
  v:OleVariant;
  x:pointer;
begin
  p:=Fsize;
  for i:=0 to (Fsize div FchunkSize) do
   begin
    //TODO: reuse any Fchunk already fetched?
    if p<FchunkSize then s:=p else s:=FchunkSize;
    v:=Fdb.Get(Fprefix+mongoStreamChunksSuffix,BSON([
      mongoStreamFilesIDField,Fdata[mongoStreamIDField],
      mongoStreamNField,i
    ]))[mongoStreamDataField];
    x:=VarArrayLock(v);
    try
      Stream.Write(x^,s);
      //assert returns same value as s
    finally
      VarArrayUnlock(v);
    end;
    dec(p,s);
   end;
  //TODO: check md5 checksum?
end;

procedure TMongoStream.SetSize(NewSize: Integer);
begin
  //inherited;
  raise EMongoException.Create('TMongoStream is read-only');
end;

function TMongoStream.Write(const Buffer; Count: Integer): Longint;
begin
  raise EMongoException.Create('TMongoStream is read-only');
end;

class function TMongoStream.Add(db: TMongoWire; prefix: WideString;
  stream: TStream; info: IBSONDocument): OleVariant;
var
  i,l,chunkSize:integer;
  v:OleVariant;
  p:PAnsiChar;
begin
  if stream.Size>$80000000 then
    raise EMongoException.Create('TMongoStream.Add: max 2GB supported');
  if info=nil then
    raise EMongoException.Create('TMongoStream.Add: info document required');
  if stream=nil then
    raise EMongoException.Create('TMongoStream.Add: streal required');
  if VarIsNull(info[mongoStreamIDField]) then
   begin
    Result:=mongoObjectId;
    info[mongoStreamIDField]:=Result;
   end
  else
    Result:=info[mongoStreamIDField];
  info[mongoStreamLengthField]:=integer(stream.Size);
  v:=info[mongoStreamChunkSizeField];
  if VarIsNumeric(v) then
    chunkSize:=v
  else
   begin
    chunkSize:=mongoStreamDefaultChunkSize;
    info[mongoStreamChunkSizeField]:=chunkSize;
   end;
  info[mongoStreamUploadDateField]:=VarFromDateTime(Now);
  //TODO: 'md5'?
  //assert db.Connected
  if prefix='' then prefix:=mongoStreamDefaultPrefix;
  db.Insert(prefix+mongoStreamFilesSuffix,info);
  stream.Position:=0;//?
  v:=VarArrayCreate([0,chunkSize-1],varByte);
  l:=chunkSize;
  i:=0;
  while l<>0 do
   begin
    p:=VarArrayLock(v);
    try
      l:=stream.Read(p^,chunkSize);
    finally
      VarArrayUnlock(v);
    end;
    //assert l=chunkSize
    if l<>0 then
     begin
      if l<>chunkSize then VarArrayRedim(v,l-1);//assert last read from stream!
      db.Insert(prefix+mongoStreamChunksSuffix,BSON([
        mongoStreamFilesIDField,Result,
        mongoStreamNField,i,
        mongoStreamDataField,v
      ]));
      inc(i);
     end;
   end;
end;

class function TMongoStream.Add(db: TMongoWire; const prefix,
  filepath: WideString): OleVariant;
var
  f:TFileStream;
begin
  f:=TFileStream.Create(filepath,fmOpenRead);
  try
    Result:=Add(db,prefix,f,BSON([
      mongoStreamFileNameField,ExtractFileName(filepath)
      //'contentType'?
      //'metadata'?
    ]));
  finally
    f.Free;
  end;
end;

end.
