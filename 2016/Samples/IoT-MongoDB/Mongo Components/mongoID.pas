{

TMongoWire: mongoID.pas

Copyright 2010-2014 Stijn Sanders
Made available under terms described in file "LICENSE"
https://github.com/stijnsanders/TMongoWire

}
unit mongoID;

{$D-}
{$L-}

interface

function mongoObjectId:string;

implementation

uses Windows, SysUtils, bsonDoc, Registry;

var
  mongoObjectID_MachineID,mongoObjectID_Counter:integer;

function mongoObjectId:string;
var
  st:TSystemTime;
  a,b,c,d:integer;
const
  hex:array[0..15] of char='0123456789abcdef';
begin
  //juse one way of generating mongoDB objectID's
  GetSystemTime(st);
  a:=(((Round(EncodeDate(st.wYear,st.wMonth,st.wDay))-UnixDateDelta)*24+st.wHour)*60+st.wMinute)*60+st.wSecond;
  b:=mongoObjectID_MachineID; //see initialization
  c:=GetCurrentThreadId;//GetCurrentProcessId;
  d:=InterlockedIncrement(mongoObjectID_Counter);
  Result:=
    bsonObjectIDPrefix+
    hex[(a shr 28) and $F]+hex[(a shr 24) and $F]+
    hex[(a shr 20) and $F]+hex[(a shr 16) and $F]+
    hex[(a shr 12) and $F]+hex[(a shr  8) and $F]+
    hex[(a shr  4) and $F]+hex[(a       ) and $F]+

    hex[(b shr 20) and $F]+hex[(b shr 16) and $F]+
    hex[(b shr 12) and $F]+hex[(b shr  8) and $F]+
    hex[(b shr  4) and $F]+hex[(b       ) and $F]+

    hex[(c shr 12) and $F]+hex[(c shr  8) and $F]+
    hex[(c shr  4) and $F]+hex[(c       ) and $F]+

    hex[(d shr 20) and $F]+hex[(d shr 16) and $F]+
    hex[(d shr 12) and $F]+hex[(d shr  8) and $F]+
    hex[(d shr  4) and $F]+hex[(d       ) and $F]+

    bsonObjectIDSuffix;
end;

procedure InitMongoObjectID;
const 
  KEY_WOW64_64KEY = $0100;
var
  r:TRegistry;
  s:string;
  i,l:integer;
begin
  //render a number out of the host name
  r:=TRegistry.Create(KEY_READ or KEY_WOW64_64KEY);
  try
    r.RootKey:=HKEY_LOCAL_MACHINE;
    if r.OpenKey('\Software\Microsoft\Cryptography',false) then
      s:=r.ReadString('MachineGuid')
    else
      s:='';
  finally
    r.Free;
  end;
  if s='' then
   begin
    l:=MAX_PATH;
    SetLength(s,l);
    if GetComputerName(PChar(s),cardinal(l)) then SetLength(s,l) else
      s:=GetEnvironmentVariable('COMPUTERNAME');
    mongoObjectID_MachineID:=$10101;
    for i:=1 to Length(s) do
      case s[i] of
        '0'..'9':
          mongoObjectID_MachineID:=(mongoObjectID_MachineID*36+
            (byte(s[i]) and $0F)) and $FFFFFF;
        'A'..'Z','a'..'z':
          mongoObjectID_MachineID:=(mongoObjectID_MachineID*36+
            (byte(s[i]) and $1F)+9) and $FFFFFF;
        //else ignore
      end;
   end
  else
    mongoObjectID_MachineID:=StrToInt('$'+Copy(s,1,6));
  mongoObjectID_Counter:=GetTickCount;//0?
end;

initialization
  InitMongoObjectID;
end.
