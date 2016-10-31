unit ServiceModule;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs;

type
  THelloServer = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceShutdown(Sender: TService);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  HelloServer: THelloServer;

implementation

uses
  HelloServerUnit;

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  HelloServer.Controller(CtrlCode);
end;

function THelloServer.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure THelloServer.ServiceShutdown(Sender: TService);
begin
  StopHelloServer;
end;

procedure THelloServer.ServiceStart(Sender: TService; var Started: Boolean);
begin
  StartHelloServer;
end;

procedure THelloServer.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  StopHelloServer;
end;

end.
