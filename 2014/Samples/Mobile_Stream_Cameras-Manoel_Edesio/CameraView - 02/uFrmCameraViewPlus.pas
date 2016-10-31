unit uFrmCameraViewPlus;

interface

uses
   System.SysUtils,
   System.Types,
   System.UITypes,
   System.IOUtils,
   System.Classes,
   System.Variants,

   FMX.Types,
   FMX.Controls,
   FMX.Forms,
   FMX.Graphics,
   FMX.Dialogs,
   FMX.StdCtrls,
   FMX.Edit,
   FMX.WebBrowser,

   FMX.Objects,
   FMX.Layouts,
   FMX.ListBox;

type
   TFrmCameraViewPlus = class(TForm)
      WBCamera: TWebBrowser;
      lytTop: TLayout;
      imgTop: TImage;
      lblTop: TLabel;
    btnUp: TButton;
    lytMove: TLayout;
    btnDown: TButton;
    btnLeft: TButton;
    btnRight: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
   private
    procedure AbrirCameraStream;
    procedure CameraLink(AWeb: TWebBrowser; AHost: string; APort: integer; AUser, APwd: string);
    procedure CameraMove(AHost: string; APort: integer; AUser, APwd: string; ADirection: integer);
      {Private declarations}
   public
      {Public declarations}
   end;

var
   FrmCameraViewPlus: TFrmCameraViewPlus;

implementation

{$R *.fmx}

procedure TFrmCameraViewPlus.AbrirCameraStream;
begin
   try
      CameraLink(WBCamera, 'edesoftsa.dyndns.biz', 9001, 'mobile', 'mobile');
   except
      on E: Exception do
      begin
         ShowMessage('CameraLink: ' + E.Message);
      end;
   end;
end;

procedure TFrmCameraViewPlus.btnDownClick(Sender: TObject);
begin
   CameraMove('edesoftsa.dyndns.biz', 9001, 'mobile', 'mobile', 2);
end;

procedure TFrmCameraViewPlus.btnLeftClick(Sender: TObject);
begin
   CameraMove('edesoftsa.dyndns.biz', 9001, 'mobile', 'mobile', 6);
end;

procedure TFrmCameraViewPlus.btnRightClick(Sender: TObject);
begin
   CameraMove('edesoftsa.dyndns.biz', 9001, 'mobile', 'mobile', 4);
end;

procedure TFrmCameraViewPlus.btnUpClick(Sender: TObject);
begin
   CameraMove('edesoftsa.dyndns.biz', 9001, 'mobile', 'mobile', 0);
end;

procedure TFrmCameraViewPlus.CameraLink(AWeb: TWebBrowser; AHost: string; APort: integer; AUser, APwd: string);
var
   User     : string;
   Pwd      : string;
   Link     : string;

   htmlPage : string;
   fileHtml : string;

   SL       : TStringList;
const
   CameraIP = 'CameraIP.html';
begin
   htmlPage :=
      '<html>' +
      '<script language="JavaScript" type="text/javascript">' +
      'function reload() {' +
      'setTimeout(''reloadImg("refresh")'',100)' +
      '};' +
      'function reloadImg(id) {' +
      'var obj = document.getElementById(id);' +
      'var date = new Date();' +
      'obj.src = "http://' + AHost + ':' + IntToStr(APort) + '/snapshot.cgi?user=' + AUser + '&pwd=' + APwd +
      '&t=" + Math.floor(date.getTime()/100);' +
      '}' +
      '</script>' +
      '<body>' +
      '<img src="http://' + AHost + ':' + IntToStr(APort) + '/snapshot.cgi?user=' + AUser + '&pwd=' + APwd +
      '&t=" name="refresh" id="refresh" width=100% height=90% onload=''reload(this)'' onerror=''reload(this)''>' +
      '</body>' +
      '</html>';

   SL := TStringList.Create;
   try
      SL.Text := htmlPage;

      {$IFDEF MSWINDOWS}
      fileHtml := ExtractFilePath(ParamStr(0)) + CameraIP;
      {$ENDIF}
      {$IFDEF ANDROID}

      fileHtml := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, CameraIP);

      {$ENDIF}
      {$IFDEF IOS}

      fileHtml := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, CameraIP);
      {$ENDIF}
      if FileExists(fileHtml) then
      begin
         try
            DeleteFile(fileHtml);
         except
            on E: Exception do
            begin

            end;
         end;
      end;

      SL.SaveToFile(fileHtml);
      Sleep(250);
   finally
      FreeAndNil(SL);
   end;

   Link := 'file://' + fileHtml;

   {$IFDEF MSWINDOWS}
   {$ELSE}
   AWeb.BeginUpdate;
   AWeb.Navigate(Link);
   AWeb.EndUpdate;
   {$ENDIF}
end;

procedure TFrmCameraViewPlus.CameraMove(AHost: string; APort: integer; AUser, APwd: string; ADirection: integer);
var
   Link: string;
   AWeb: TWebBrowser;
begin
   Link := 'http://' + AHost + ':' + IntToStr(APort) + '/decoder_control.cgi?command=' + IntToStr(ADirection) + '&user=' + AUser + '&pwd=' + APwd;

   {$IFDEF MSWINDOWS}
   ///
   {$ELSE}
   AWeb := TWebBrowser.Create(nil);
   try
      AWeb.BeginUpdate;
      AWeb.Navigate(Link);
      AWeb.EndUpdate;
   finally
      FreeAndNil(AWeb);
   end;
   {$ENDIF}
   Sleep(250);

   Link := 'http://' + AHost + ':' + IntToStr(APort) + '/decoder_control.cgi?command=' + IntToStr(ADirection + 1) + '&user=' + AUser + '&pwd=' + APwd;

   {$IFDEF MSWINDOWS}
   ///
   {$ELSE}
   AWeb := TWebBrowser.Create(nil);
   try
      AWeb.BeginUpdate;
      AWeb.Navigate(Link);
      AWeb.EndUpdate;
   finally
      FreeAndNil(AWeb);
   end;
   {$ENDIF}
end;

procedure TFrmCameraViewPlus.FormShow(Sender: TObject);
begin
   AbrirCameraStream;
end;

end.
