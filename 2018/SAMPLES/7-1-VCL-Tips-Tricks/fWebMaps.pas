unit fWebMaps;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.OleCtrls, SHDocVw, Vcl.ComCtrls,
  MSHTML, uJsonMaps, uGoogleMapsclass, uEvent, Web.HTTPApp, Web.HTTPProd, ActiveX ;

type
  TfrmWebMaps = class(TForm)
    Panel1: TPanel;
    memPontos: TMemo;
    Panel2: TPanel;
    btnLocalizarPontos: TButton;
    btnAtualizar: TButton;
    btnCalcularRota: TButton;
    btnInfo: TButton;
    Panel3: TPanel;
    Splitter2: TSplitter;
    memRetorno: TMemo;
    memJson: TMemo;
    pnlInstrucoes: TPanel;
    Label1: TLabel;
    lbxInstrucoes: TListBox;
    Splitter1: TSplitter;
    Splitter3: TSplitter;
    StatusBar: TStatusBar;
    WebMapa: TWebBrowser;
    pgpHtml: TPageProducer;
    btnLimpaMarkers: TButton;
    procedure btnUrlClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnLocalizarPontosClick(Sender: TObject);
    procedure btnCalcularRotaClick(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure btnLimpaMarkersClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FBrowserEvent : TBrowserEvent;
    procedure ExecutarScript(sScript: String);
    procedure LocalizarPontos;
    procedure TracarRota;
    procedure ExibirInformacoes;
    function ListaElementos(pHTMLElementCollection: IHTMLElementCollection; pElementId: string = ''): string;
    procedure DecodificarJSonDeRetorno;
    { Private declarations }
  public
    procedure CarregarMapa;
    procedure RotaChange(Sender : TObject);
    { Public declarations }
  end;

var
  frmWebMaps: TfrmWebMaps;

implementation

{$R *.dfm}

procedure TfrmWebMaps.RotaChange(Sender: TObject);
begin
  ExibirInformacoes;
end;

procedure TfrmWebMaps.DecodificarJSonDeRetorno;
var
  lJsonMaps: TJsonMaps;
  lInstrucoes: string;
  lDirectionsStep: TDirectionsStep;
  lDirectionsLeg: TDirectionsLeg;
begin
  lJsonMaps := TJsonMaps.Create;
  memJson.Text := lJsonMaps.CaregarJson(memRetorno.Text);
  lbxInstrucoes.Clear;
  lJsonMaps.MontarInformacoesDeRota(memRetorno.Text);
  for lDirectionsLeg in lJsonMaps.DirectionsRoute.Legs do
  begin
    for lDirectionsStep in lDirectionsLeg.Steps do
    begin
      lInstrucoes := StringReplace(lDirectionsStep.Instructions, '<b>', '', [rfReplaceAll, rfIgnoreCase]);
      lInstrucoes := StringReplace(lInstrucoes, '</b>', '', [rfReplaceAll, rfIgnoreCase]);
      lbxInstrucoes.Items.Add(lInstrucoes);
    end;
  end;
end;

procedure TfrmWebMaps.btnAtualizarClick(Sender: TObject);
begin
  CarregarMapa;
end;

procedure TfrmWebMaps.btnCalcularRotaClick(Sender: TObject);
begin
  TracarRota;
end;

procedure TfrmWebMaps.btnInfoClick(Sender: TObject);
begin
  ExibirInformacoes;
end;

procedure TfrmWebMaps.btnLocalizarPontosClick(Sender: TObject);
begin
  LocalizarPontos;
end;

procedure TfrmWebMaps.btnUrlClick(Sender: TObject);
begin
  CarregarMapa;
end;

procedure TfrmWebMaps.btnLimpaMarkersClick(Sender: TObject);
begin
  ExecutarScript('LimparMarkers();');
end;

procedure TfrmWebMaps.CarregarMapa;
var
  lMemory: TMemoryStream;
begin
  WebMapa.Navigate('about:blank') ;
  while WebMapa.ReadyState < READYSTATE_INTERACTIVE do
  begin
    Application.ProcessMessages;
  end;

  if Assigned(WebMapa.Document) then
  begin
    lMemory := TMemoryStream.Create;
    try
      pgpHtml.HTMLDoc.SaveToStream(lMemory);
      lMemory.Seek(0, 0) ;
      (WebMapa.Document as IPersistStreamInit).Load(TStreamAdapter.Create(lMemory)) ;
    finally
      lMemory.Free;
    end;
  end;
end;

procedure TfrmWebMaps.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmWebMaps.FormShow(Sender: TObject);
begin
  CarregarMapa;
end;

procedure TfrmWebMaps.ExecutarScript(sScript: String);
var
  lHTMLWindow: IHTMLWindow2;
  lHtmlDocument: IHTMLDocument2;
begin
  lHtmlDocument := WebMapa.Document as IHTMLDocument2;

  lHTMLWindow := lHtmlDocument.parentWindow;
  lHTMLWindow.execScript(sScript, 'javascript');
end;

procedure TfrmWebMaps.LocalizarPontos;
var
  li: Integer;
begin
  for li := 0 to memPontos.Lines.Count - 1 do
  begin
    if trim(memPontos.Lines[li]) <> '' then
    begin
      ExecutarScript('LocalizarEndereco('+QuotedStr(trim(memPontos.Lines[li])) + ');');
    end;
  end;
end;

procedure TfrmWebMaps.TracarRota;
begin
  ExecutarScript('CalcularRota();');
  ExecutarScript('LimparMarkers();');
end;

procedure TfrmWebMaps.ExibirInformacoes;
var
  lDocument : IHTMLDocument2;
  lElementCollection: IHTMLElementCollection;
  lBody, lElement : IHTMLElement;
  lElement2: IHTMLElement2;
  li: Integer;
  lInput: IHTMLInputElement;
begin
  memRetorno.Clear;
  lDocument := WebMapa.Document as IHTMLDocument2;
  lBody := lDocument.body as IHTMLElement;
  lElementCollection := lBody.all as IHTMLElementCollection;
  for li := 0 to lElementCollection.length - 1 do
  begin
    lElement := lElementCollection.Item(li, '') as IHTMLElement;
    if (lElement.tagName = 'INPUT') and (lElement.id = 'edtRotas') then
    begin
      lInput := lElement as IHTMLInputElement;
      lElement2 := lElement as IHTMLElement2;
      if FBrowserEvent = nil then
      begin
        FBrowserEvent := TBrowserEvent.Create(Application);
        FBrowserEvent.OnEvent := RotaChange;
        lElement2.attachEvent('onclick', OleVariant(FBrowserEvent as IDispatch));
      end;
      memRetorno.Lines.Add(lInput.value);
      DecodificarJSonDeRetorno;
      Break;
    end
  end;
end;

function TfrmWebMaps.ListaElementos(pHTMLElementCollection: IHTMLElementCollection; pElementId : string): string;
var
  lElementsCount: Integer;
  lI: Integer;
  lListaAllElements: IHTMLElementCollection;
  lElement: IHTMLElement;
begin
  lListaAllElements := pHTMLElementCollection;
  lElementsCount := lListaAllElements.Length;
  Result := '';
  for lI := 0 to lElementsCount - 1 do
  begin
    lElement := lListaAllElements.Item(lI, '') as IHTMLElement;
    Result := Result + sLineBreak + lElement.innerText;
  end;
end;

end.
