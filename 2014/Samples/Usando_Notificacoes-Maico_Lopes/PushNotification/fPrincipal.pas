unit fPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.OpenSSL, REST.Backend.PushTypes, System.JSON,
  REST.Backend.KinveyPushDevice, System.PushNotification, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Backend.BindSource, REST.Backend.PushDevice,
  REST.Backend.KinveyProvider, FMX.Layouts, FMX.Memo, FMX.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    Label1: TLabel;
    Memo: TMemo;
    KinveyProvider: TKinveyProvider;
    PushEvents: TPushEvents;
    procedure PushEventsPushReceived(Sender: TObject; const AData: TPushData);
    procedure PushEventsDeviceTokenRequestFailed(Sender: TObject;
      const AErrorMessage: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.PushEventsDeviceTokenRequestFailed(Sender: TObject;
  const AErrorMessage: string);
begin
  Memo.Lines.Add(AErrorMessage);
end;

procedure TfrmPrincipal.PushEventsPushReceived(Sender: TObject; const AData: TPushData);
begin
  Memo.Lines.Add(AData.Message);
end;

end.
