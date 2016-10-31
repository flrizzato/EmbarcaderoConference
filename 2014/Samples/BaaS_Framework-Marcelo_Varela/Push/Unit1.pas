unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.OpenSSL, REST.Backend.KinveyProvider, REST.Backend.PushTypes,
  System.JSON, REST.Backend.KinveyPushDevice, System.PushNotification,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Backend.BindSource,
  REST.Backend.PushDevice, FMX.Layouts, FMX.ListBox, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView, FMX.Memo, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, FMX.Notification, FMX.Objects;

type
  TForm1 = class(TForm)
    KinveyProvider1: TKinveyProvider;
    PushEvents1: TPushEvents;
    ToolBar1: TToolBar;
    Memo1: TMemo;
    NotificationCenter1: TNotificationCenter;
    Text1: TText;
    procedure PushEvents1PushReceived(Sender: TObject; const AData: TPushData);
    procedure PushEvents1DeviceRegistered(Sender: TObject);
    procedure PushEvents1DeviceTokenReceived(Sender: TObject);
    procedure PushEvents1DeviceTokenRequestFailed(Sender: TObject;
      const AErrorMessage: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

procedure TForm1.PushEvents1DeviceRegistered(Sender: TObject);
begin
  Memo1.Lines.Add('Device Registered');
  Memo1.Lines.Add('===========================');
end;

procedure TForm1.PushEvents1DeviceTokenReceived(Sender: TObject);
begin
  Memo1.Lines.Add('Device Token Received');
  Memo1.Lines.Add('===========================');
end;

procedure TForm1.PushEvents1DeviceTokenRequestFailed(Sender: TObject;
  const AErrorMessage: string);
begin
  Memo1.Lines.Add('Device Token Request Failed');
  Memo1.Lines.Add(AErrorMessage);
  Memo1.Lines.Add('===========================');
end;

procedure TForm1.PushEvents1PushReceived(Sender: TObject;
  const AData: TPushData);
var
  Notification: TNotification;
begin
  Memo1.Lines.Add('Device push received');
  Memo1.Lines.Add(AData.Message);
  Memo1.Lines.Add('===========================');

  if NotificationCenter1.Supported then
  begin
    Notification := NotificationCenter1.CreateNotification;
    try
      Notification.Name := 'PushNotification';
      Notification.AlertBody := AData.Message;
      Notification.FireDate := Now;
      NotificationCenter1.ScheduleNotification(Notification);
    finally
      Notification.DisposeOf;
    end;
  end;
end;

end.
