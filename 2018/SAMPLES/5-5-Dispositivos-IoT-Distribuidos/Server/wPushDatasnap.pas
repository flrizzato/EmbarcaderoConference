unit wPushDatasnap;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker, Datasnap.DSServer,
  Datasnap.DSAuth, IPPeerServer, Datasnap.DSCommonServer, Datasnap.DSHTTP;

type
  TwmPushServer = class(TWebModule)
    DSPushServer: TDSServer;
    DSPushServerClass: TDSServerClass;
    DSRESTWebDispatcher1: TDSRESTWebDispatcher;
    procedure DSPushServerClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TwmPushServer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}


{$R *.dfm}

uses aPushMethods, Web.WebReq;

procedure TwmPushServer.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content :=
    '<html>' +
    '<head><title>DataSnap Server</title></head>' +
    '<body>DataSnap Server</body>' +
    '</html>';
end;

procedure TwmPushServer.DSPushServerClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := aPushMethods.TPushMethods;
end;

initialization
finalization
  Web.WebReq.FreeWebModules;

end.

