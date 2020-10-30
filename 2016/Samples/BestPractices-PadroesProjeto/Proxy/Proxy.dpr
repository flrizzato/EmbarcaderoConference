program Proxy;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  soap, socket: TCustomRemoteServer;
  prx: TConnectionBroker;
  cds1,cds2: TClientDataSet;
begin
  soap := TSOAPConnection.Create();
  socket := TSocketConnection.Create();
  prx := TConnectionBroker.Create(soap);
  cds1 := TClientDataSet.Create();
  cds2 := TClientDataSet.Create();
  cds1.RemoteServer := prx;
  cds2.RemoteServer := prx;
  prx.Connect();
  readln;
end.
