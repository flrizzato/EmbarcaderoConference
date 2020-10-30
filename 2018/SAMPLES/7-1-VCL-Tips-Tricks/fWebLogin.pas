unit fWebLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.OleCtrls, SHDocVw,
  Web.HTTPApp, Web.HTTPProd, MSHTML, Vcl.StdCtrls, uEvent, Winapi.ActiveX;

type
  TfrmWebLogin = class(TForm)
    pgpHtml: TPageProducer;
    WebBrowser: TWebBrowser;
    Panel1: TPanel;
    btnInsereEventos: TButton;
    btnCarregarPagina: TButton;
    Label1: TLabel;
    edtUsuario: TEdit;
    procedure btnInsereEventosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCarregarPaginaClick(Sender: TObject);
  private
    FOnLoginClick: TBrowserEvent;
    FOnUsuarioChange: TBrowserEvent;
    FHtmlEdtUsuario: IHTMLInputElement;
    procedure CarregarMapa;
    procedure MontarEventoBtnLogin(lElement2: IHTMLElement2);
    procedure MontarEventoEdtLogin(lElement2: IHTMLElement2);
  public
    procedure LoginClick(Sender: TObject);
    procedure UsuarioChange(Sender: TObject);
  end;

var
  frmWebLogin: TfrmWebLogin;

implementation

{$R *.dfm}

procedure TfrmWebLogin.btnInsereEventosClick(Sender: TObject);
var
  lDocument : IHTMLDocument2;
  lElementCollection: IHTMLElementCollection;
  lBody, lElement : IHTMLElement;
  lElement2: IHTMLElement2;
  li: Integer;
begin
  lDocument := WebBrowser.Document as IHTMLDocument2;
  if lDocument <> nil then
  begin
    lBody := lDocument.body as IHTMLElement;
    lElementCollection := lBody.all as IHTMLElementCollection;
    for li := 0 to lElementCollection.length - 1 do
    begin
      lElement := lElementCollection.Item(li, '') as IHTMLElement;

      if (lElement.id = 'btnLogin') then
      begin
        MontarEventoBtnLogin(lElement as IHTMLElement2);
      end;

      if (lElement.id = 'edtUsuario') then
      begin
        FHtmlEdtUsuario := lElement as IHTMLInputElement;
        MontarEventoEdtLogin(lElement as IHTMLElement2);
      end
    end;
  end;
end;

procedure TfrmWebLogin.btnCarregarPaginaClick(Sender: TObject);
begin
  CarregarMapa;
end;

procedure TfrmWebLogin.CarregarMapa;
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
      pgpHtml.HTMLDoc.SaveToStream(lMemory);
      lMemory.Position := 0;
      (WebBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(lMemory)) ;
    finally
      lMemory.Free;
    end;
  end;
end;

procedure TfrmWebLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmWebLogin.LoginClick(Sender: TObject);
begin
  ShowMessage('Executando Login');
end;

procedure TfrmWebLogin.UsuarioChange(Sender: TObject);
begin
  if Assigned(FHtmlEdtUsuario) then
  begin
    edtUsuario.Text := FHtmlEdtUsuario.value;
  end;
end;

procedure TfrmWebLogin.MontarEventoEdtLogin(lElement2: IHTMLElement2);
begin
  if FOnUsuarioChange = nil then
  begin
    FOnUsuarioChange := TBrowserEvent.Create(Application);
    FOnUsuarioChange.OnEvent := UsuarioChange;
    lElement2.attachEvent('onkeyup', OleVariant(FOnUsuarioChange as IDispatch));
  end;
end;

procedure TfrmWebLogin.MontarEventoBtnLogin(lElement2: IHTMLElement2);
begin
  if FOnLoginClick = nil then
  begin
    FOnLoginClick := TBrowserEvent.Create(Application);
    FOnLoginClick.OnEvent := LoginClick;
    lElement2.attachEvent('onclick', OleVariant(FOnLoginClick as IDispatch));
  end;
end;

end.
