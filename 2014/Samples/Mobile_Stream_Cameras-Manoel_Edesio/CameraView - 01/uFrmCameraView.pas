unit uFrmCameraView;

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
   TfrmCameraView = class(TForm)
      WBCamera: TWebBrowser;
      imgBG: TImage;
      lytTop: TLayout;
      btnMensagem: TButton;
      imgMensagem: TImage;
      btnTop: TButton;
      imgTop: TImage;
      lblTop: TLabel;
      lytNaveg: TLayout;
    btnDown: TButton;
    btnLeft: TButton;
    btnRight: TButton;
    btnUp: TButton;
    procedure FormCreate(Sender: TObject);
   private
      procedure AbrirCameraStream;

      procedure ViewCameraLink(AWeb: TWebBrowser; AHost: string; APort: integer; AUser, APwd: string;ADirection:integer);
      {Private declarations}
   public
      {Public declarations}
   end;

var
   frmCameraView: TfrmCameraView;

implementation

{$R *.fmx}


procedure TfrmCameraView.AbrirCameraStream;
begin
   try
      ViewCameraLink(WBCamera, 'edesoftsa.dyndns.biz', 9001, 'mobile', 'mobile',0);
   except
      on E: Exception do
      begin
         ShowMessage('CameraLink: ' + E.Message);
      end;
   end;
end;

procedure TfrmCameraView.FormCreate(Sender: TObject);
begin
   AbrirCameraStream;
end;

procedure TfrmCameraView.ViewCameraLink(AWeb: TWebBrowser; AHost: string; APort: integer; AUser, APwd: string;ADirection:integer);
var
   Link     : string;
   htmlPage : string;
   fileHtml : string;
   SL       : TStringList;
const
   CameraIP = 'CameraIP.html';
begin

   Link := 'http://' + AHost + ':' + IntToStr(APort) + '/decoder_control.cgi?command=' + IntToStr(ADirection) + '&user=' + AUser + '&pwd=' + APwd;

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
               ShowMessage('Mensagem: ' + sLineBreak + E.Message + sLineBreak + 'Arquivo: ' + sLineBreak + fileHtml);
            end;
         end;
      end;

      SL.SaveToFile(fileHtml);
      Sleep(250);
   finally
      FreeAndNil(SL);
   end;

   Link := 'file://' + fileHtml;

   AWeb.BeginUpdate;
   AWeb.Navigate(Link);
   AWeb.EndUpdate;
end;

end.
