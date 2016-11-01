unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, IPPeerClient,
  REST.Backend.KinveyProvider, REST.Backend.PushTypes, System.JSON,
  REST.Backend.KinveyPushDevice, System.PushNotification, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Backend.BindSource, REST.Backend.PushDevice,
  FMX.ScrollBox, FMX.Memo, FMX.Layouts, FMX.ListBox;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    KinveyProvider1: TKinveyProvider;
    PushEvents1: TPushEvents;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure PushEvents1DeviceRegistered(Sender: TObject);
    procedure PushEvents1DeviceTokenReceived(Sender: TObject);
    procedure PushEvents1DeviceTokenRequestFailed(Sender: TObject;
      const AErrorMessage: string);
    procedure PushEvents1PushReceived(Sender: TObject; const AData: TPushData);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Label1.Text := DateTimeToStr(Now);
end;

procedure TForm1.PushEvents1DeviceRegistered(Sender: TObject);
begin
  ListBox1.Items.Add('Device Registered');
end;

procedure TForm1.PushEvents1DeviceTokenReceived(Sender: TObject);
begin
  ListBox1.Items.Add('Device Token Received');
end;

procedure TForm1.PushEvents1DeviceTokenRequestFailed(Sender: TObject;
  const AErrorMessage: string);
begin
  ListBox1.Items.Add('Device Token Request Failed');
end;

procedure TForm1.PushEvents1PushReceived(Sender: TObject;
  const AData: TPushData);
begin
  ListBox1.Items.Add('Push Received: ' + AData.Message);
end;

end.
