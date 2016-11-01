unit fAppServer;
interface
uses
  WinApi.Windows, Winapi.ShellApi, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp, System.Actions,
  Vcl.ActnList, Vcl.Menus, Vcl.StdActns, aFormMDI, Vcl.Buttons, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList;

type
  TfrmAppServer = class(TFormMDI)
    spServer: TMainMenu;
    Arquivos1: TMenuItem;
    Push1: TMenuItem;
    ActionList1: TActionList;
    acPushServer: TAction;
    acPushSender: TAction;
    FileExit1: TFileExit;
    Exit1: TMenuItem;
    Sender1: TMenuItem;
    PushServer1: TMenuItem;
    Panel1: TPanel;
    spWinTileH: TSpeedButton;
    spTileV: TSpeedButton;
    spWinCloseAll: TSpeedButton;
    spServHT: TSpeedButton;
    spServRC: TSpeedButton;
    ImageList1: TImageList;
    N2: TMenuItem;
    procedure acPushServerExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acPushSenderExecute(Sender: TObject);
    procedure mnuWindow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAppServer: TfrmAppServer;

implementation
uses mServer, mSender;

{$R *.dfm}

procedure TfrmAppServer.acPushServerExecute(Sender: TObject);
begin
  TmdiServer.CreateSingle(Self, 100);
end;

procedure TfrmAppServer.acPushSenderExecute(Sender: TObject);
begin
  TmdiSender.CreateSingle(Self, 200);
end;

procedure TfrmAppServer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:= CloseAllMDI;
end;

procedure TfrmAppServer.mnuWindow(Sender: TObject);
begin
  case (Sender as TComponent).Tag of
    100:begin
          TileMode:=tbHorizontal;
          Tile;
        end;
    101:begin
          TileMode:=tbVertical;
          Tile;
        end;
    102:Next;
    103:CloseAllMdi;
  end;
end;

end.
