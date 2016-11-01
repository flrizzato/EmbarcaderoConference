{

TMongoWire: mongoAuth.pas

Copyright 2010-2016 Stijn Sanders
Made available under terms described in file "LICENSE"
https://github.com/stijnsanders/TMongoWire

}
unit mongoAuth;

{$D-}
{$L-}

interface

uses SysUtils, mongoWire;

function MD5Hash(x:UTF8String):UTF8String;

procedure MongoWireAuthenticate(MongoWire:TMongoWire;
  const UserName,Password:WideString);
procedure MongoWireLogout(MongoWire:TMongoWire);

type
  EMongoAuthenticationFailed=class(EMongoException);

implementation

uses
  bsonDoc;

function MD5Hash(x:UTF8String):UTF8String;
const
  roll1:array[0..3] of cardinal=(7,12,17,22);
  roll2:array[0..3] of cardinal=(5,9,14,20);
  roll3:array[0..3] of cardinal=(4,11,16,23);
  roll4:array[0..3] of cardinal=(6,10,15,21);
  base1:array[0..15] of cardinal=(
    $d76aa478,$e8c7b756,$242070db,$c1bdceee,
    $f57c0faf,$4787c62a,$a8304613,$fd469501,
    $698098d8,$8b44f7af,$ffff5bb1,$895cd7be,
    $6b901122,$fd987193,$a679438e,$49b40821);
  base2:array[0..15] of cardinal=(
    $f61e2562,$c040b340,$265e5a51,$e9b6c7aa,
    $d62f105d,$02441453,$d8a1e681,$e7d3fbc8,
    $21e1cde6,$c33707d6,$f4d50d87,$455a14ed,
    $a9e3e905,$fcefa3f8,$676f02d9,$8d2a4c8a);
  base3:array[0..15] of cardinal=(
    $fffa3942,$8771f681,$6d9d6122,$fde5380c,
    $a4beea44,$4bdecfa9,$f6bb4b60,$bebfbc70,
    $289b7ec6,$eaa127fa,$d4ef3085,$04881d05,
    $d9d4d039,$e6db99e5,$1fa27cf8,$c4ac5665);
  base4:array[0..15] of cardinal=(
    $f4292244,$432aff97,$ab9423a7,$fc93a039,
    $655b59c3,$8f0ccc92,$ffeff47d,$85845dd1,
    $6fa87e4f,$fe2ce6e0,$a3014314,$4e0811a1,
    $f7537e82,$bd3af235,$2ad7d2bb,$eb86d391);
  hex:array[0..15] of AnsiChar='0123456789abcdef';
var
  a:cardinal;
  dl,i,j,k,l:integer;
  d:array of cardinal;
  g,h:array[0..3] of cardinal;
{$IF not Declared(RawByteString)}
type
  RawByteString=AnsiString;
{$IFEND}
begin
  //based on http://www.ietf.org/rfc/rfc1321.txt
  a:=Length(RawByteString(x));
  dl:=a+9;
  if (dl and $3F)<>0 then dl:=(dl and $FFC0)+$40;
  i:=dl;
  dl:=dl shr 2;
  SetLength(d,dl);
  SetLength(x,i);
  j:=a+1;
  x[j]:=#$80;
  while j<i do
   begin
    inc(j);
    x[j]:=#0;
   end;
  Move(x[1],d[0],i);
  d[dl-2]:=a shl 3;
  h[0]:=$67452301;
  h[1]:=$efcdab89;
  h[2]:=$98badcfe;
  h[3]:=$10325476;
  i:=0;
  while i<dl do
   begin
    g:=h;
    j:=i;
    for k:=0 to 15 do
     begin
      l:=k*3;
      a:=h[l and 3]+
        ((h[(l+1) and 3] and h[(l+2) and 3]) or
        (not(h[(l+1) and 3]) and h[(l+3) and 3]))+
        d[j]+
        base1[k];
      h[l and 3]:=h[(l+1) and 3]+
        ((a shl roll1[k and 3]) or (a shr (32-roll1[k and 3])));
      inc(j);
     end;
    j:=1;
    for k:=0 to 15 do
     begin
      l:=k*3;
      a:=h[l and 3]+
        ((h[(l+3) and 3] and h[(l+1) and 3]) or
        (not(h[(l+3) and 3]) and h[(l+2) and 3]))+
        d[i or (j and $F)]+
        base2[k];
      h[l and 3]:=h[(l+1) and 3]+
        ((a shl roll2[k and 3]) or (a shr (32-roll2[k and 3])));
      inc(j,5);
     end;
    j:=5;
    for k:=0 to 15 do
     begin
      l:=k*3;
      a:=h[l and 3]+
        (h[(l+1) and 3] xor h[(l+2) and 3] xor h[(l+3) and 3])+
        d[i or (j and $F)]+
        base3[k];
      h[l and 3]:=h[(l+1) and 3]+
        ((a shl roll3[k and 3]) or (a shr (32-roll3[k and 3])));
      inc(j,3);
     end;
    j:=0;
    for k:=0 to 15 do
     begin
      l:=k*3;
      a:=h[l and 3]+
        (h[(l+2) and 3] xor (h[(l+1) and 3] or not h[(l+3) and 3]))+
        d[i or (j and $F)]+
        base4[k];
      h[l and 3]:=h[(l+1) and 3]+
        ((a shl roll4[k and 3]) or (a shr (32-roll4[k and 3])));
      inc(j,7);
     end;
    for k:=0 to 3 do inc(h[k],g[k]);
    inc(i,16);
   end;
  SetLength(Result,32);
  for k:=0 to 31 do
    Result[k+1]:=hex[h[k shr 3] shr ((k xor 1) shl 2) and $F];
end;

procedure MongoWireAuthenticate(MongoWire:TMongoWire;
  const UserName,Password:WideString);
var
  nonce:WideString;
begin
  nonce:=MongoWire.Get('$cmd',BSON(['getnonce',1]))['nonce'];
  if MongoWire.Get('$cmd',BSON([
    'authenticate',1,
    'nonce',nonce,
    'user',UserName,
    'key',MD5Hash(UTF8Encode(nonce+UserName+
      MD5Hash(UTF8Encode(UserName+':mongo:'+Password))))
  ]))['ok']<>1 then
    raise EMongoAuthenticationFailed.Create(
      'MongoWire: failed to authenticate as "'+UserName+'"');
end;

procedure MongoWireLogout(MongoWire:TMongoWire);
begin
  if MongoWire.Get('$cmd',BSON(['logout',1]))['ok']<>1 then
    raise EMongoException.Create('MongoWire: logout failed');
end;

end.
