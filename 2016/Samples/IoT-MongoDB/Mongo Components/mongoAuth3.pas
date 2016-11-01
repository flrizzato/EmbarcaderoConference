{

TMongoWire: mongoAuth3.pas

Copyright 2015 Stijn Sanders
Made available under terms described in file "LICENSE"
https://github.com/stijnsanders/TMongoWire

}
unit mongoAuth3;

{$D-}
{$L-}

interface

uses mongoWire;

procedure MongoWireAuthenticate(MongoWire: TMongoWire;
  const UserName, Password: WideString);
procedure MongoWireLogout(MongoWire: TMongoWire);

type
  EMongoAuthenticationFailed=class(EMongoException);

implementation

uses SysUtils, bsonDoc, Variants;

{$IF not Declared(RawByteString)}
type
  RawByteString=AnsiString;
{$IFEND}

function MD5Hash(x: RawByteString): RawByteString;
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
var
  a:cardinal;
  dl,i,j,k,l:integer;
  d:array of cardinal;
  g,h:array[0..3] of cardinal;
begin
  //based on http://www.ietf.org/rfc/rfc1321.txt
  a:=Length(x);
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
  SetLength(Result,16);
  for j:=0 to 15 do
    Result[j+1]:=AnsiChar(h[j shr 2] shr ((j and 3)*8));
end;

{
function SwapEndian32(Value: cardinal): cardinal; register; overload;
asm
  bswap eax
end;
}

function SwapEndian32(Value: cardinal): cardinal;
var
  x:array[0..3] of byte absolute Result;
  y:array[0..3] of byte absolute Value;
begin
  x[0]:=y[3];
  x[1]:=y[2];
  x[2]:=y[1];
  x[3]:=y[0];
end;


function SHA1Hash(x: RawByteString): RawByteString;
const
  hex:array[0..15] of AnsiChar='0123456789abcdef';
var
  a:cardinal;
  dl,i,j:integer;
  d:array of cardinal;
  e:array[0..79] of cardinal;
  g,h:array[0..4] of cardinal;
begin
  //based on http://www.ietf.org/rfc/rfc3174.txt
  a:=Length(x);
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
  d[dl-1]:=SwapEndian32(a shl 3);
  h[0]:=$67452301;
  h[1]:=$efcdab89;
  h[2]:=$98badcfe;
  h[3]:=$10325476;
  h[4]:=$c3d2e1f0;
  i:=0;
  while i<dl do
   begin
    j:=0;
    while j<16 do
     begin
      e[j]:=SwapEndian32(d[i]);
      inc(i);
      inc(j);
     end;
    while j<80 do
     begin
      a:=e[j-3] xor e[j-8] xor e[j-14] xor e[j-16];
      e[j]:=((a shl 1) or (a shr 31));
      inc(j);
     end;
    g:=h;
    j:=0;
    while j<20 do
     begin
      a:=((g[0] shl 5) or (g[0] shr 27))+
        ((g[1] and g[2]) or (not(g[1]) and g[3]))+
        g[4]+e[j]+$5a827999;
      g[4]:=g[3];
      g[3]:=g[2];
      g[2]:=((g[1] shl 30) or (g[1] shr 2));
      g[1]:=g[0];
      g[0]:=a;
      inc(j);
     end;
    while j<40 do
     begin
      a:=((g[0] shl 5) or (g[0] shr 27))+
        (g[1] xor g[2] xor g[3])+
        g[4]+e[j]+$6ed9eba1;
      g[4]:=g[3];
      g[3]:=g[2];
      g[2]:=((g[1] shl 30) or (g[1] shr 2));
      g[1]:=g[0];
      g[0]:=a;
      inc(j);
     end;
    while j<60 do
     begin
      a:=((g[0] shl 5) or (g[0] shr 27))+
        ((g[1] and g[2]) or (g[1] and g[3]) or (g[2] and g[3]))+
        g[4]+e[j]+$8f1bbcdc;
      g[4]:=g[3];
      g[3]:=g[2];
      g[2]:=((g[1] shl 30) or (g[1] shr 2));
      g[1]:=g[0];
      g[0]:=a;
      inc(j);
     end;
    while j<80 do
     begin
      a:=((g[0] shl 5) or (g[0] shr 27))+
        (g[1] xor g[2] xor g[3])+
        g[4]+e[j]+$ca62c1d6;
      g[4]:=g[3];
      g[3]:=g[2];
      g[2]:=((g[1] shl 30) or (g[1] shr 2));
      g[1]:=g[0];
      g[0]:=a;
      inc(j);
     end;
    for j:=0 to 4 do inc(h[j],g[j]);
   end;
  SetLength(Result,20);
  for j:=0 to 19 do
    Result[j+1]:=AnsiChar(h[j shr 2] shr ((3-(j and 3))*8));
end;

function HMAC_SHA1(const Key, Msg: RawByteString): RawByteString;
const
  BlockSize=64;//SHA1
var
  k,h1,h2:UTF8String;
  i:integer;
begin
  //assert BlockSize=Length(HashFn('')) div 2
  if Length(Key)>BlockSize then k:=SHA1Hash(Key) else
   begin
    k:=Key;
    i:=Length(k);
    SetLength(k,BlockSize);
    while (i<BlockSize) do
     begin
      inc(i);
      k[i]:=#0;
     end;
   end;
  SetLength(h1,BlockSize);
  SetLength(h2,BlockSize);
  //TODO: speed-up by doing 32 bits at a time
  for i:=1 to BlockSize do byte(h1[i]):=byte(k[i]) xor $5C;
  for i:=1 to BlockSize do byte(h2[i]):=byte(k[i]) xor $36;
  Result:=SHA1Hash(h1+SHA1Hash(h2+Msg));
end;

function PBKDF2_HMAC_SHA1(const Password, Salt: RawByteString;
  Iterations, KeyLength: cardinal): RawByteString;
var
  i,j,k,c,l:cardinal;
  x,y:UTF8String;
const
  HashLength=20;//Length(SHA1Hash())
begin
  //assert HashLength:=Length(PRF('','')) div 2
  l:=KeyLength div HashLength;
  if (KeyLength mod HashLength)<>0 then inc(l);
  SetLength(Result,l*HashLength);
  i:=0;
  j:=0;
  while (i<KeyLength) do
   begin
    inc(j);
    x:=HMAC_SHA1(Password,Salt+
      AnsiChar(j shr 24)+AnsiChar((j shr 16) and $FF)+
      AnsiChar((j shr 8) and $FF)+AnsiChar(j and $FF));
    y:=x;
    c:=Iterations-1;
    while c<>0 do
     begin
      x:=HMAC_SHA1(Password,x);
      for k:=1 to Length(x) do
        byte(y[k]):=byte(y[k]) xor byte(x[k]);
      dec(c);
     end;
    for k:=1 to HashLength do
     begin
      inc(i);
      Result[i]:=y[k];
     end;
   end;
  SetLength(Result,KeyLength);
end;

const
  HexCodes:array[0..15] of AnsiChar='0123456789abcdef';

function HexEncode(const x: RawByteString): UTF8string;
var
  i,l:integer;
begin
  l:=Length(x);
  SetLength(Result,l*2);
  i:=0;
  while i<l do
   begin
    inc(i);
    Result[i*2-1]:=HexCodes[byte(x[i]) shr $4];
    Result[i*2  ]:=HexCodes[byte(x[i]) and $F];
   end;
end;

const
  Base64Codes:array[0..63] of AnsiChar=
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

function Base64Encode(const x: RawByteString): UTF8String;
var
  i,j,l:cardinal;
begin
  l:=Length(x);
  i:=(l div 3);
  if (l mod 3)<>0 then inc(i);
  SetLength(Result,i*4);
  i:=1;
  j:=0;
  while (i+2<=l) do
   begin
    inc(j);Result[j]:=Base64Codes[  byte(x[i  ]) shr 2];
    inc(j);Result[j]:=Base64Codes[((byte(x[i  ]) and $03) shl 4)
                                or (byte(x[i+1]) shr 4)];
    inc(j);Result[j]:=Base64Codes[((byte(x[i+1]) and $0F) shl 2)
                                or (byte(x[i+2]) shr 6)];
    inc(j);Result[j]:=Base64Codes[  byte(x[i+2]) and $3F];
    inc(i,3);
   end;
  if i=l then
   begin
    inc(j);Result[j]:=Base64Codes[  byte(x[i  ]) shr 2];
    inc(j);Result[j]:=Base64Codes[((byte(x[i  ]) and $03) shl 4)];
    inc(j);Result[j]:='=';
    inc(j);Result[j]:='=';
   end
  else if i+1=l then
   begin
    inc(j);Result[j]:=Base64Codes[  byte(x[i  ]) shr 2];
    inc(j);Result[j]:=Base64Codes[((byte(x[i  ]) and $03) shl 4)
                                or (byte(x[i+1]) shr 4)];
    inc(j);Result[j]:=Base64Codes[((byte(x[i+1]) and $0F) shl 2)];
    inc(j);Result[j]:='=';
   end;
end;

function Base64Decode(const x: UTF8String): RawByteString;
var
  i,j,k,l,m:cardinal;
  n:array[0..3] of byte;
begin
  l:=Length(x);
  if l<4 then Result:='' else
   begin
    k:=(Length(x) div 4)*3;
    SetLength(Result,k);
    if x[l]='=' then begin dec(k); dec(l); end;
    if x[l]='=' then begin dec(k); dec(l); end;
    i:=0;
    j:=0;
    while i<l do
     begin
      m:=0;
      while m<>4 do
       begin
        if i=l then n[m]:=0 else
         begin
          inc(i);
          n[m]:=0;
          while (n[m]<64) and (x[i]<>Base64Codes[n[m]]) do inc(n[m]);
         end;
        inc(m);
       end;
      inc(j);Result[j]:=AnsiChar((n[0] shl 2) or (n[1] shr 4));
      inc(j);Result[j]:=AnsiChar((n[1] shl 4) or (n[2] shr 2));
      inc(j);Result[j]:=AnsiChar((n[2] shl 6) or (n[3]      ));
     end;
    SetLength(Result,k);
   end;
end;

function BuildNonce: RawByteString;
var
  x:packed record g1,g2:TGUID; end;
begin
  if CreateGUID(x.g1)<>S_OK then RaiseLastOSError;
  if CreateGUID(x.g2)<>S_OK then RaiseLastOSError;
  SetLength(Result,24);
  Move(x,Result[1],24);
end;

procedure MongoWireAuthenticate(MongoWire: TMongoWire;
  const UserName, Password: WideString);
var
  nonce,m1,m2,m3,m4,r,s,t,u:Utf8String;
  v:OleVariant;
  i,j,k,l:integer;
  p:PAnsiChar;
  b:IBSONDocument;
const
  ErrMsg='MongoWire: failed to authenticate as "%s"';
begin
  //https://tools.ietf.org/html/rfc5802

  //TODO: unsername, password: unicode normalize 'form KC'
  //TODO: strprep https://tools.ietf.org/html/rfc4013
  nonce:=Base64Encode(BuildNonce);

  //client-first message
  m1:='n='+UTF8Encode(
    StringReplace(
    StringReplace(
      UserName
      ,'=','=3D',[rfReplaceAll])
      ,',','=2C',[rfReplaceAll])
      )+',r='+nonce;
  t:='n,,'+m1;
  l:=Length(t);
  v:=VarArrayCreate([0,l-1],varByte);
  p:=VarArrayLock(v);
  try
    Move(t[1],p^,l);
  finally
    VarArrayUnlock(v);
  end;

  b:=MongoWire.Get('$cmd',BSON([
    'saslStart',1,
    'mechanism','SCRAM-SHA-1',//TODO: full-fledged SASL
    'payload',v
  ]));
  if VarIsNull(b['conversationId']) then
    raise EMongoAuthenticationFailed.CreateFmt(ErrMsg,[UserName]);
  //assert b['done']=false

  //server-first message
  v:=b['payload'];
  l:=VarArrayHighBound(v,1)-VarArrayLowBound(v,1)+1;
  p:=VarArrayLock(v);
  try
    SetLength(m2,l);
    Move(p^,m2[1],l);
  finally
    VarArrayUnlock(v);
  end;

  r:='';//default
  s:='';//default
  k:=0;//default
  i:=1;
  while (i<=l) do
    if m2[i+1]<>'=' then i:=l else
     begin
      j:=i+2;
      while (j<l) and (m2[j]<>',') do inc(j);
      //assert m2[i]='=';
      case m2[i] of
        'r'://combined nonces
          r:=Copy(m2,i+2,j-i-2);
        's'://salt
          s:=Copy(m2,i+2,j-i-2);
        'i'://iteration count
         begin
          //StrToInt?
          k:=0;
          inc(i);//'='
          while i<j do
           begin
            inc(i);
            k:=k*10+(byte(m2[i]) and $F);
           end;
         end;
        //else raise?
      end;
      i:=j+1;
     end;

  if (r='') or (s='') or (k=0) then
    raise EMongoAuthenticationFailed.CreateFmt(ErrMsg,[UserName]);
  if Copy(r,1,Length(nonce))<>nonce then
    raise EMongoAuthenticationFailed.CreateFmt(ErrMsg,[UserName]);
  //TODO: store server nonce, enforce unicity


  //calculate client proof
  m3:='c=biws'//'c='+Base64Encode('n,,')
    +',r='+r;
  s:=PBKDF2_HMAC_SHA1(HexEncode(MD5Hash(
    UTF8Encode(UserName+':mongo:'+Password))),Base64Decode(s),k,20);
  t:=HMAC_SHA1(s,'Client Key');
  u:=m1+','+m2+','+m3;
  r:=HMAC_SHA1(SHA1Hash(t),u);
  for i:=1 to Length(t) do byte(t[i]):=byte(t[i]) xor byte(r[i]);

  //client-final message
  m3:=m3+',p='+Base64Encode(t);

  l:=Length(m3);
  v:=VarArrayCreate([0,l-1],varByte);
  p:=VarArrayLock(v);
  try
    Move(m3[1],p^,l);
  finally
    VarArrayUnlock(v);
  end;

  b:=MongoWire.Get('$cmd',BSON([
    'saslContinue',1,
    'payload',v,
    'conversationId',b['conversationId']
  ]));

  if VarIsNull(b['conversationId']) then
    raise EMongoAuthenticationFailed.CreateFmt(ErrMsg,[UserName]);

  //server-final message
  v:=b['payload'];
  l:=VarArrayHighBound(v,1)-VarArrayLowBound(v,1)+1;
  p:=VarArrayLock(v);
  try
    SetLength(t,l);
    Move(p^,t[1],l);
  finally
    VarArrayUnlock(v);
  end;

  m4:='v='+Base64Encode(HMAC_SHA1(HMAC_SHA1(s,'Server Key'),u));
  if t<>m4 then
    raise EMongoAuthenticationFailed.CreateFmt(ErrMsg,[UserName]);

  if b['done']<>true then
   begin
    b:=MongoWire.Get('$cmd',BSON([
      'saslContinue',1,
      'payload',VarArrayCreate([0,-1],varByte),
      'conversationId',b['conversationId']
    ]));
    //assert b['ok']=1
    //assert b['done']=true
    //assert b['payload'] is an empty byte vararray
   end;
end;

procedure MongoWireLogout(MongoWire: TMongoWire);
begin
  if MongoWire.Get('admin.$cmd',BSON(['logout',1]))['ok']<>1 then
    raise EMongoException.Create('MongoWire: logout failed');
end;

end.
