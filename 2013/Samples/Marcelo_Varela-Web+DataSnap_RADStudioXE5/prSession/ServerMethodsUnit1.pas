unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth;

type
  TServerMethods1 = class(TDSServerModule)
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    procedure SetValue(AValue: string);
    function GetValue: string;
  end;

implementation

{$R *.dfm}

uses System.StrUtils, Datasnap.DSSession;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GetValue: string;
var
  session: TDSSession;
begin
  session := TDSSessionManager.GetThreadSession;
  Result := session.GetData('myKey');
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

procedure TServerMethods1.SetValue(AValue: string);
var
  session: TDSSession;
begin
  session := TDSSessionManager.GetThreadSession;
  session.PutData('myKey', AValue);
end;

end.

