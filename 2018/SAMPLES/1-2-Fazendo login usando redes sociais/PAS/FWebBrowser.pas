unit FWebBrowser;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Controls.Presentation, System.Sensors, FGX.ProgressDialog,
  System.Sensors.Components, FMX.Layouts, FMX.TabControl,
  FMX.WebBrowser

  {$IFDEF ANDROID}
    ,Androidapi.JNI.GraphicsContentViewText
    ,Androidapi.JNI.App
    ,FMX.Platform.Android
    ,FMX.WebBrowser.Android
    ,Androidapi.Helpers
    ,Androidapi.JNI.JavaTypes
    ,Androidapi.JNI.Net
    ,Androidapi.JNIBridge
    ,Androidapi.JNI.Provider
    ,Androidapi.JNI.Location
    ,Androidapi.JNI.Os
  {$ENDIF ANDROID}

  ,IdURI, FMX.ListBox, FMX.SearchBox, FMX.ScrollBox, FMX.Memo,
  FMX.Gestures, FMX.Maps, FMX.Objects, System.ImageList, FMX.ImgList, IdContext, IdCustomHTTPServer, IdBaseComponent, IdComponent, IdCustomTCPServer, IdHTTPServer, FMX.Edit;

type
  TfrmWebBrowser = class(TForm)
    WebBrowser1: TWebBrowser;
    Layout1: TLayout;
    TabCtrlPrincipal: TTabControl;
    TabItemWelcome: TTabItem;
    GridPanelLayout5: TGridPanelLayout;
    ImageControl2: TImageControl;
    btnVoltar: TButton;
    StyleBook1: TStyleBook;
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure btnVoltarClick(Sender: TObject);
  private
    class function ActivityDialog: TfgActivityDialog; static;
    class var FActivityDialog: TfgActivityDialog;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWebBrowser    : TfrmWebBrowser;
  Atualiza_posicao : TStringList;

  iField    : Integer;
  FCompleto : Boolean;

implementation

{$R *.fmx}

uses fLogin, uDM;

{ TForm1 }

procedure TfrmWebBrowser.btnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmWebBrowser.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
 if Key = vkHardwareBack then
 begin
  // if not more to do in back button
   Key := 0; // Set Key = 0 if you want to prevent the default action
   close;
 end;
end;

class function TfrmWebBrowser.ActivityDialog: TfgActivityDialog;
begin
  if FActivityDialog = nil then
    FActivityDialog:= TfgActivityDialog.Create(nil);

  Result:= FActivityDialog;
end;

end.
