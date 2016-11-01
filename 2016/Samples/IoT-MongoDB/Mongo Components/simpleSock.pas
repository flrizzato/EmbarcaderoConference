unit simpleSock;

interface

uses SysUtils, Classes;

{$D-}
{$L-}

type
  PSocketAddress=^TSocketAddress;
  TSocketAddress=record
    family: word;
    port: word;
    data: array[0..11] of word;
  end;

  THostEntry=record
    h_name:PAnsiChar;
    h_aliases:^PAnsiChar;
    h_addrtype:word;
    h_length:word;
    h_addr:^PAnsiChar;
    //TODO: IPv6
  end;
  PHostEntry = ^THostEntry;

  TFDSet = record
    fd_count: cardinal;
    fd_array: array[0..63] of THandle;
  end;
  PFDSet = ^TFDSet;

  TTimeVal = record
    tv_sec: cardinal;
    tv_usec: cardinal;
  end;
  PTimeVal = ^TTimeVal;

const
  INVALID_SOCKET = THandle(not(0));
  AF_INET = 2;
  AF_INET6 = 23;
  SOCKET_ERROR = -1;
  SOCK_STREAM = 1;
  IPPROTO_IP = 0;
  SOMAXCONN = 5;
  SOL_SOCKET = $FFFF;
  SO_SNDTIMEO = $1005;
  SO_RCVTIMEO = $1006;
  SD_BOTH = 2;
  IPPROTO_TCP = 6;
  TCP_NODELAY = 1;

type
  TTcpSocket=class(TObject)
  private
    FSocket:THandle;
    FAddr:TSocketAddress;
    FConnected:boolean;
  protected
    constructor Create(family: word; ASocket:THandle); overload;
    function GetPort:word;
    function GetAddress:string;
    function GetHostName:string;
  public
    constructor Create(family: word= AF_INET); overload;
    destructor Destroy; override;
    procedure Connect(const Address:AnsiString;Port:word);
    procedure Disconnect;
    function ReceiveBuf(var Buf; BufSize: Integer): Integer;
    function SendBuf(const Buffer; Count: LongInt): LongInt;
    property Handle:THandle read FSocket;
    property Connected:boolean read FConnected;
    property Port:word read GetPort;
    property Address:string read GetAddress;
    property HostName:string read GetHostName;
  end;

  TTcpServer=class(TObject)
  private
    FFamily: word;
    FSocket: THandle;
  public
    constructor Create(family: word= AF_INET);
    destructor Destroy; override;
    procedure Bind(const Address:AnsiString;Port:word);
    procedure Listen;
    procedure WaitForConnection;
    function Accept:TTcpSocket;
    property Handle:THandle read FSocket;
  end;

  ETcpSocketError=class(Exception);

function WSAStartup(wVersionRequired: word; WSData: pointer): integer; stdcall;
function WSACleanup: integer; stdcall;
function WSAGetLastError: integer; stdcall;
function htons(hostshort: word): word; stdcall;
function inet_addr(cp: PAnsiChar): cardinal; stdcall;
function inet_ntoa(inaddr: cardinal): PAnsiChar; stdcall;
function gethostbyaddr(addr: pointer; len, Struct: integer): PHostEntry; stdcall;
function gethostbyname(name: PAnsiChar): PHostEntry; stdcall;
//TODO: getaddrinfo
function socket(af, Struct, protocol: integer): THandle; stdcall;
function setsockopt(s: THandle; level, optname: integer; optval: PAnsiChar;
  optlen: integer): integer; stdcall;
function listen(socket: THandle; backlog: integer): integer; stdcall;
function bind(s: THandle; var addr: TSocketAddress; namelen: integer): integer; stdcall;
function accept(s: THandle; addr: PSocketAddress; addrlen: PInteger): THandle; stdcall;
function connect(s: THandle; var name: TSocketAddress; namelen: integer): integer; stdcall;
function recv(s: THandle; var Buf; len, flags: integer): integer; stdcall;
function select(nfds: integer; readfds, writefds, exceptfds: PFDSet;
  timeout: PTimeVal): integer; stdcall;
function send(s: THandle; var Buf; len, flags: integer): integer; stdcall;
function shutdown(s: THandle; how: integer): integer; stdcall;
function closesocket(s: THandle): integer; stdcall;
//function __WSAFDIsSet(s: THandle; var FDSet: TFDSet): Boolean; stdcall;

implementation

var
  WSAData:record // !!! also WSDATA
    wVersion:word;
    wHighVersion:word;
    szDescription:array[0..256] of AnsiChar;
    szSystemStatus:array[0..128] of AnsiChar;
    iMaxSockets:word;
    iMaxUdpDg:word;
    lpVendorInfo:PAnsiChar;
  end;

procedure RaiseLastWSAError;
begin
  raise ETcpSocketError.Create(SysErrorMessage(WSAGetLastError));
end;

procedure PrepareSockAddr(var addr: TSocketAddress; family, port: word;
  const host: AnsiString);
var
  e:PHostEntry;
  i:integer;
begin
  addr.family:=family;//AF_INET
  addr.port:=htons(port);
  for i:=0 to 11 do addr.data[i]:=0;
  if host<>'' then
    if char(host[1]) in ['0'..'9'] then
      PCardinal(@addr.data[0])^:=inet_addr(PAnsiChar(host))
    else
     begin
      //TODO: getaddrinfo
      e:=gethostbyname(PAnsiChar(host));
      if e=nil then RaiseLastWSAError;
      addr.family:=e.h_addrtype;
      Move(e.h_addr^[0],addr.data[0],e.h_length);
     end;
end;

{ TTcpSocket }

procedure TTcpSocket.Connect(const Address: AnsiString; Port: word);
begin
  PrepareSockAddr(FAddr,FAddr.family,Port,Address);
  if simpleSock.connect(FSocket,FAddr,SizeOf(TSocketAddress))=SOCKET_ERROR then
    RaiseLastWSAError
  else
    FConnected:=true;
end;

constructor TTcpSocket.Create(family: word);
begin
  inherited Create;
  FConnected:=false;
  FillChar(FAddr,SizeOf(TSocketAddress),#0);
  FAddr.family:=family;//AF_INET
  FSocket:=socket(family,SOCK_STREAM,IPPROTO_IP);
  if FSocket=INVALID_SOCKET then RaiseLastWSAError;
end;

constructor TTcpSocket.Create(family: word; ASocket: THandle);
var
  i:integer;
begin
  inherited Create;
  FAddr.family:=family;
  FSocket:=ASocket;
  if FSocket=INVALID_SOCKET then RaiseLastWSAError;
  i:=1;
  if setsockopt(FSocket,IPPROTO_TCP,TCP_NODELAY,@i,4)<>0 then
    RaiseLastWSAError;
  FConnected:=true;//?
end;

destructor TTcpSocket.Destroy;
begin
  //Disconnect;?
  closesocket(FSocket);
  inherited;
end;

procedure TTcpSocket.Disconnect;
begin
  if FConnected then
   begin
    FConnected:=false;
    shutdown(FSocket,SD_BOTH);
   end;
end;

function TTcpSocket.GetPort: word;
begin
  Result:=FAddr.port;
end;

function TTcpSocket.GetAddress: string;
begin
  Result:=inet_ntoa(PCardinal(@FAddr.data[0])^);
end;

function TTcpSocket.GetHostName: string;
var
  e:PHostEntry;
  i:integer;
begin
  e:=gethostbyaddr(@FAddr.data[0],SizeOf(TSocketAddress),FAddr.family);
  if e=nil then
    //inet_ntop?
    if FAddr.family=AF_INET6 then
     begin
      i:=3;
      if FAddr.data[i]=0 then Result:=':' else
        Result:=Result+IntToHex(FAddr.data[i],4)+':';
      while (i<10) do
       begin
        while (i<10) and (FAddr.data[i]=0) do inc(i);
        if i=10 then Result:=Result+':' else
          Result:=Result+':'+IntToHex(FAddr.data[i],4);
        inc(i);
       end;
     end
    else
      Result:=inet_ntoa(PCardinal(@FAddr.data[0])^)
  else
    Result:=e.h_name;
end;

function TTcpSocket.ReceiveBuf(var Buf; BufSize: Integer): Integer;
begin
  Result:=recv(FSocket,Buf,BufSize,0);
  if Result=SOCKET_ERROR then
   begin
    Disconnect;
    RaiseLastWSAError;
   end;
end;

function TTcpSocket.SendBuf(const Buffer; Count: LongInt): LongInt;
var
  p:pointer;
begin
  p:=@Buffer;
  Result:=send(FSocket,p^,Count,0);
  if Result=SOCKET_ERROR then
   begin
    Disconnect;
    RaiseLastWSAError;
   end;
end;

{ TTcpServer }

constructor TTcpServer.Create(family: word);
begin
  inherited Create;
  FFamily:=family;//AF_INET
  FSocket:=socket(FFamily,SOCK_STREAM,IPPROTO_IP);
end;

destructor TTcpServer.Destroy;
begin
  closesocket(FSocket);
  inherited;
end;

procedure TTcpServer.Bind(const Address: AnsiString; Port: word);
var
  a:TSocketAddress;
begin
  if FSocket=INVALID_SOCKET then RaiseLastWSAError;
  PrepareSockAddr(a,FFamily,Port,Address);
  if simpleSock.bind(FSocket,a,SizeOf(TSocketAddress))=SOCKET_ERROR then
    RaiseLastWSAError;
end;

procedure TTcpServer.Listen;
begin
  //call bind first!
  if simpleSock.listen(FSocket,SOMAXCONN)=SOCKET_ERROR then
    RaiseLastWSAError;
end;

procedure TTcpServer.WaitForConnection;
var
  r,x:TFDSet;
begin
  r.fd_count:=1;
  r.fd_array[0]:=FSocket;
  x.fd_count:=1;
  x.fd_array[0]:=FSocket;
  if select(FSocket+1,@r,nil,@x,nil)=SOCKET_ERROR then RaiseLastWSAError;
  if x.fd_count=1 then //if __WSAFDIsSet(FSocket,x) then
    raise ETcpSocketError.Create('Socket in error state');//?
  if r.fd_count=0 then //if not __WSAFDIsSet(FSocket,r) then
    raise ETcpSocketError.Create('Select without error nor result');//??
end;

function TTcpServer.Accept: TTcpSocket;
var
  a:TSocketAddress;
  l:integer;
begin
  l:=SizeOf(TSocketAddress);
  FillChar(a,l,#0);
  Result:=TTcpSocket.Create(FFamily,simpleSock.accept(FSocket,@a,@l));
  Result.FAddr:=a;
end;

const
  winsockdll='wsock32.dll';

function WSAStartup; external winsockdll;
function WSACleanup; external winsockdll;
function WSAGetLastError; external winsockdll;
function htons; external winsockdll;
function inet_addr; external winsockdll;
function inet_ntoa; external winsockdll;
function gethostbyaddr; external winsockdll;
function gethostbyname; external winsockdll;
function socket; external winsockdll;
function setsockopt; external winsockdll;
function listen; external winsockdll;
function bind; external winsockdll;
function accept; external winsockdll;
function connect; external winsockdll;
function recv; external winsockdll;
function select; external winsockdll;
function send; external winsockdll;
function shutdown; external winsockdll;
function closesocket; external winsockdll;
//function __WSAFDIsSet; external winsockdll;

initialization
  WSAStartup($0101,@WSAData);
finalization
  WSACleanup;
end.

