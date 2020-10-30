program Adapter;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  con: TSQLConnection;
  soap: TCustomRemoteServer;
  adap: TDSProviderConnection;
begin
  soap := TSOAPConnection.Create();
  soap.Connect();
  con := TSQLConnection.Create();
  adap := TDSProviderConnection.Create(con);
  adap.Connect();
  readln;
end.
