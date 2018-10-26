unit fTranslate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Web.HTTPApp,
  Web.HTTPProd, Vcl.ExtCtrls, Vcl.StdCtrls, Winapi.ActiveX, MSHTML,
  uGoogleTranslateClass, System.Net.URLClient;

type
  TfrmTranslate = class(TForm)
    memSource: TMemo;
    memDest: TMemo;
    Panel1: TPanel;
    btnTraduzir: TButton;
    btnFalar: TButton;
    Splitter1: TSplitter;
    pgcAudio: TPageProducer;
    Panel2: TPanel;
    WebBrowser: TWebBrowser;
    procedure btnTraduzirClick(Sender: TObject);
    procedure btnFalarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure CarregarPagina;
    procedure ExecutarScript(sScript: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTranslate: TfrmTranslate;

implementation

{$R *.dfm}

procedure TfrmTranslate.btnTraduzirClick(Sender: TObject);
begin
  memDest.Text := TTranslate.Translate(memSource.Text,TGoogleLanguages.Portuguese,TGoogleLanguages.English);
end;

procedure TfrmTranslate.btnFalarClick(Sender: TObject);
var
  lArquivo : String;
begin
  lArquivo := 'C:\Muka\Delphi\Conference 2018\Exemplo Palestra\Win32\Debug\Teste.mp3';
  ExecutarScript('document.getElementById("Fala").src = "";');
  DeleteFile(lArquivo);
  TTranslate.GerarMp3(memSource.Text,TGoogleLanguages.Portuguese);
  ExecutarScript('document.getElementById("Fala").src = "file:///'+TURI.URLEncode(lArquivo)+'";'+sLineBreak+
                 'document.getElementById("Fala").load();'+sLineBreak+
                 'document.getElementById("Fala").play();');
end;

procedure TfrmTranslate.CarregarPagina;
var
  lMemory: TMemoryStream;
begin
  WebBrowser.Navigate('about:blank') ;
  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
  begin
    Application.ProcessMessages;
  end;

  if Assigned(WebBrowser.Document) then
  begin
    lMemory := TMemoryStream.Create;
    try
      pgcAudio.HTMLDoc.SaveToStream(lMemory);
      lMemory.Position := 0;
      (WebBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(lMemory)) ;
    finally
      lMemory.Free;
    end;
  end;
end;

procedure TfrmTranslate.ExecutarScript(sScript: String);
var
  lHTMLWindow: IHTMLWindow2;
  lHtmlDocument: IHTMLDocument2;
begin
  lHtmlDocument := WebBrowser.Document as IHTMLDocument2;

  lHTMLWindow := lHtmlDocument.parentWindow;
  lHTMLWindow.execScript(sScript, 'javascript');
end;

procedure TfrmTranslate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmTranslate.FormShow(Sender: TObject);
begin
  CarregarPagina;
end;

end.
