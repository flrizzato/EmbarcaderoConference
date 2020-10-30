unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth, System.JSON;

type
{$METHODINFO ON}
  TServerMethods1 = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function UpdateProcessarChatBot(AData: TJSONObject): TJSONObject;
  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils, FormUnit1;

function TServerMethods1.UpdateProcessarChatBot(AData: TJSONObject): TJSONObject;
var
oResult : TJSONObject;
oParameters : TJSONObject;
begin
  oResult := TJSONObject(TJSONObject(AData.ToJSON).GetValue('result'));
  oParameters := TJSONObject(oResult.GetValue('parameters'));

  Form2.Memo1.Lines.Add(TJSONString(oParameters.GetValue('nome')).Value);
  Form2.Memo1.Lines.Add('-------------------------------');

  Result := TJSONObject.Create;
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;
end.

