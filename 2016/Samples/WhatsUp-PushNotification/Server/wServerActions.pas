unit wServerActions;
interface
uses System.SysUtils, System.Classes, Web.HTTPApp, Winapi.Windows,
  System.NetEncoding, VCL.Forms, aClasses, aConsts;

type
  TwmServerActions = class(TWebModule)
    procedure wmAppwaRegisterAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure wmServerActionslogAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure wmServerActionswaAliveAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    procedure DoLog(const Msg: string; Params: array of const);
    function DoRegister(const Content: string): string;
  public
  end;

var
  WebModuleClass: TComponentClass = TwmServerActions;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TwmServerActions.DoLog(const Msg: string; Params: array of const);
var
  Value: string;
begin
  Value:= Format(Msg, Params);
  if CurrentMessageQueueHandler > 0 then
    PostMessage(CurrentMessageQueueHandler, WM_LOG, 0, NativeInt(StrNew(PWideChar(Value))));
end;

function TwmServerActions.DoRegister(const Content: string): string;
begin
  if CurrentMessageQueueHandler > 0 then
    PostMessage(CurrentMessageQueueHandler, WM_REG, 0, NativeInt(StrNew(PWideChar(Content))));
end;

procedure TwmServerActions.wmServerActionslogAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);
begin
  DoLog('%s / %s [%s]', [Request.PathInfo, Request.Method, Request.RemoteIP]);
  DoLog(Request.Content, []);
  Handled:= false;
end;

procedure TwmServerActions.wmServerActionswaAliveAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);
begin
  Response.Content:= '<html><body><h1>Alive!</h1></body></html>';
end;

procedure TwmServerActions.wmAppwaRegisterAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  try
    DoRegister(Request.Content);
    Response.Content:= 'OK';
  except
    On E: Exception do
      Response.Content:= E.Message;
  end;
end;

end.
