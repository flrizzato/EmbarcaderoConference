unit HelloServerUnit;

interface

uses
  System.SysUtils,
  Sparkle.HttpSys.Server,
  Sparkle.HttpServer.Context,
  Sparkle.HttpServer.Module;

procedure StartHelloServer;
procedure StopHelloServer;

implementation

uses
  System.IOUtils;

var
  HelloServer: THttpSysServer;

procedure StartHelloServer;
begin
  if HelloServer <> nil then Exit;

  HelloServer := THttpSysServer.Create;

  HelloServer.AddModule(TAnonymousServerModule.Create(
    'http://+:80/tms/hello',
    procedure(const C: THttpServerContext)
    begin
      C.Response.StatusCode := 200;
      C.Response.ContentType := 'text/html';
      C.Response.Close(TEncoding.UTF8.GetBytes('<h1>Hello, World!</h1>'));
    end
  ));

  HelloServer.AddModule(TAnonymousServerModule.Create(
    'https://+:443/tms/hello',
    procedure(const C: THttpServerContext)
    begin
      C.Response.StatusCode := 200;
      C.Response.ContentType := 'text/html';
      C.Response.Close(TEncoding.UTF8.GetBytes('<h1>Hello, Secure World!</h1>'));
    end
  ));

  HelloServer.Start;
end;

procedure StopHelloServer;
begin
  FreeAndNil(HelloServer);
end;

initialization
  HelloServer := nil;
finalization
  StopHelloServer;
end.
