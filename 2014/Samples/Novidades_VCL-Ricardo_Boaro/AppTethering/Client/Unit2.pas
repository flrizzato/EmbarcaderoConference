unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  IPPeerServer, System.Tether.Manager, System.Tether.AppProfile, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation;

type
  TForm2 = class(TForm)
    ToolBar1: TToolBar;
    butPair: TButton;
    butAdd: TButton;
    TetheringManager1: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    Edit1: TEdit;
    butSend: TButton;
    procedure butPairClick(Sender: TObject);
    procedure TetheringManager1EndAutoConnect(Sender: TObject);
    procedure butAddClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.butPairClick(Sender: TObject);
begin
  TetheringManager1.AutoConnect(5000);
end;

procedure TForm2.butAddClick(Sender: TObject);
begin
  TetheringAppProfile1.RunRemoteAction(
    TetheringManager1.RemoteProfiles[0], 'Action1');
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  TetheringAppProfile1.SendString(
    TetheringManager1.RemoteProfiles[0], 'Text', Edit1.Text);
end;

procedure TForm2.TetheringManager1EndAutoConnect(Sender: TObject);
begin
  butPair.Text := 'Connected...';
  butSend.Enabled := True;
  butAdd.Enabled := True;
end;

end.
