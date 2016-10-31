
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit SharedApplication;

{$IFDEF FPC}
{$mode delphi}
{$modeswitch objectivec1}
{$ENDIF}

interface

uses
  SysUtils, Classes, FMX_Types
{$IFDEF FPC}
  , iPhoneAll
{$ENDIF}
  ;

type
  TiOSIconBadge = class(TFmxObject)
  private
    function GetNumber: Integer;
    procedure SetNumber(const Value: Integer);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property Number : Integer read GetNumber write SetNumber;
  end;

  TiOSEmail = class(TFmxObject)
  private
    FBody: String;
    FSubject: String;
    FRecipient: String;
    procedure SetBody(const Value: String);
    procedure SetRecipient(const Value: String);
    procedure SetSubject(const Value: String);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure Send;
  published
    { Published declarations }
    property Recipient : String read FRecipient write SetRecipient;
    property Subject : String read FSubject write SetSubject;
    property Body : String read FBody write SetBody;
  end;

  TiOSMap = class(TFmxObject)
  private
    FLocationB: String;
    FLocationA: String;
    procedure SetLocationA(const Value: String);
    procedure SetLocationB(const Value: String);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure GetMapOfLocationA;
    procedure GetDirectionsFromAtoB;
  published
    { Published declarations }
    property LocationA : String read FLocationA write SetLocationA;
    property LocationB : String read FLocationB write SetLocationB;
  end;

  TiOSURL = class(TFmxObject)
  private
    FURL: String;
    procedure SetURL(const Value: String);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure Open;
  published
    { Published declarations }
    property URL : String read FURL write SetURL;
  end;

  TiOSPhone = class(TFmxObject)
  private
    FNumber: String;
    procedure SetNumber(const Value: String);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure Dial;
  published
    { Published declarations }
    property Number : String read FNumber write SetNumber;
  end;

procedure Register;

implementation

{ TiOSIconBadge }

function TiOSIconBadge.GetNumber: Integer;
var
  Number : Integer;
begin
  Number := -1;
{$IFDEF FPC}
  Number := UIApplication.sharedApplication.applicationIconBadgeNumber;
{$ENDIF}
  Result := Number;
end;

procedure TiOSIconBadge.SetNumber(const Value: Integer);
begin
{$IFDEF FPC}
  UIApplication.sharedApplication.setApplicationIconBadgeNumber(Value);
{$ENDIF}
end;

{ TiOSEmail }

procedure TiOSEmail.SetBody(const Value: String);
begin
  FBody := Value;
end;

procedure TiOSEmail.SetRecipient(const Value: String);
begin
  FRecipient := Value;
end;

procedure TiOSEmail.SetSubject(const Value: String);
begin
  FSubject := Value;
end;

procedure TiOSEmail.Send;
{$IFDEF FPC}
var
  URL : NSString;
{$ENDIF}
begin
{$IFDEF FPC}
  URL := NSSTR(PChar('mailto:'+FRecipient+'?subject='+FSubject+'&body='+FBody));
  URL := URL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding);

  UIApplication.sharedApplication.openUrl(NSURL.URLWithString(URL));
{$ENDIF}
end;

{ TiOSMap }

procedure TiOSMap.SetLocationA(const Value: String);
begin
  FLocationA := Value;
end;

procedure TiOSMap.SetLocationB(const Value: String);
begin
  FLocationB := Value;
end;

procedure TiOSMap.GetDirectionsFromAtoB;
{$IFDEF FPC}
var
  URLString : String;
  URL : NSString;
{$ENDIF}
begin
{$IFDEF FPC}
  URLString := 'http://maps.google.com/maps?saddr='+FLocationA+'&daddr='+FLocationB;
  URL := NSSTR(PChar(URLString));
  URL := URL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding);
  UIApplication.sharedApplication.openUrl(NSURL.URLWithString(URL));
{$ENDIF}
end;

procedure TiOSMap.GetMapOfLocationA;
{$IFDEF FPC}
var
  Location : String;
  URL : NSString;
{$ENDIF}
begin
{$IFDEF FPC}
  Location := 'http://maps.google.com/maps?q='+FLocationA;
  URL := NSSTR(PChar(Location));
  URL := URL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding);
  UIApplication.sharedApplication.openUrl(NSURL.URLWithString(URL));
{$ENDIF}
end;

{ TiOSURL }

procedure TiOSURL.Open;
begin
  {$IFDEF FPC}
  UIApplication.sharedApplication.openUrl(NSUrl.URLWithString(NSSTR(PChar(FURL))));
  {$ENDIF}
end;

procedure TiOSURL.SetURL(const Value: String);
begin
  FURL := Value;
end;

{ TiOSPhone }

procedure TiOSPhone.Dial;
begin
{$IFDEF FPC}
  UIApplication.sharedApplication.openUrl(NSUrl.URLWithString(NSSTR(PChar(String('tel://'+FNumber)))));
{$ENDIF}
end;

procedure TiOSPhone.SetNumber(const Value: String);
begin
  FNumber := Value;
end;

procedure Register;
begin
  RegisterComponents('iOS', [TiOSIconBadge, TiOSEmail, TiOSMap, TiOSURL, TiOSPhone]);
end;

end.

