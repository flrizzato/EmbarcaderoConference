//
// FireDACJSONReflect demo
// Copyright (c) 1995-2013 Embarcadero Technologies, Inc.

// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.
//
unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker, Datasnap.DSServer,
  Datasnap.DSAuth, IPPeerServer, Datasnap.DSCommonServer, Datasnap.DSHTTP;

type
  TWebModule1 = class(TWebModule)
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSServer1: TDSServer;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure DSHTTPWebDispatcher1HTTPTrace(Sender: TObject; AContext: TDSHTTPContext; ARequest: TDSHTTPRequest;
      AResponse: TDSHTTPResponse);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

uses
  ServerMethodsUnit1,
  Web.WebReq,
  DepartmentsServerFormU;

{$R *.dfm}

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := '<html><heading/><body>DataSnap Server</body></html>';
end;

procedure TWebModule1.DSHTTPWebDispatcher1HTTPTrace(Sender: TObject; AContext: TDSHTTPContext; ARequest: TDSHTTPRequest;
  AResponse: TDSHTTPResponse);
begin
  TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      DepartmentsServerForm.lblContaSession.Caption :=
        (StrToInt(DepartmentsServerForm.lblContaSession.Caption)+1).ToString;
    end
  );
end;

procedure TWebModule1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsUnit1.TServerMethods1;
end;

initialization
finalization
  Web.WebReq.FreeWebModules;

end.

