unit wmPOS;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  Web.HTTPApp,
  Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker,
  Datasnap.DSServer,
  Web.WebFileDispatcher,
  Web.HTTPProd,
  Datasnap.DSAuth,
  Datasnap.DSProxyJavaScript,
  IPPeerServer,
  Datasnap.DSMetadata,
  Datasnap.DSServerMetadata,
  Datasnap.DSClientMetadata,
  Datasnap.DSCommonServer,
  Datasnap.DSHTTP,
  REST.JSON,
  uPOS;

type
  TMesa = class
    FMesa: integer;
    FStatus: boolean;
    FValor: Extended;
  public
    property mesa: integer read FMesa write FMesa;
    property status: boolean read FStatus write FStatus;
    property valor: Extended read FValor write FValor;
  end;

  TWebModule1 = class(TWebModule)
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSServer1: TDSServer;
    DSServerClass1: TDSServerClass;
    WebFileDispatcher1: TWebFileDispatcher;
    DSProxyGenerator1: TDSProxyGenerator;
    DSServerMetaDataProvider1: TDSServerMetaDataProvider;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure WebModuleDefaultAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: boolean);
    procedure WebFileDispatcher1BeforeDispatch(Sender: TObject; const AFileName: string; Request: TWebRequest; Response: TWebResponse; var Handled: boolean);
    procedure WebModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FServerFunctionInvokerAction: TWebActionItem;
    function Padc(str: string; len: integer): string;
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{$R *.dfm}

uses
  ServerMethodsUnit1,
  Web.WebReq;

procedure TWebModule1.DSServerClass1GetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := uPOS.TPOS;
end;

procedure TWebModule1.WebModuleDefaultAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: boolean);
var
  navs: string;
  trans: integer;
  mesa: integer;
  pos: TPOS;
  jsonMesa: string;
  mesaselecionada: TMesa;
  mensagemerro: string;
  valor: string;
begin
  trans := StrToIntDef(Request.QueryFields.Values['trans'], 0);
  mesa := StrToIntDef(Request.QueryFields.Values['mesa'], 0);
  valor := Request.QueryFields.Values['valor'];

  if (trans = 3) and ((mesa < 0) or (mesa > 10)) then
  begin
    trans := 4;
    navs := navs + '<TONE type=ERROR>';
    mensagemerro := 'Mesa inexistente!';
  end
  else if (trans = 3) and ((mesa > 0) and (mesa <= 10)) then
  begin
    pos := TPOS.Create(nil);
    jsonMesa := pos.StatusMesa(mesa);
    mesaselecionada := TMesa.Create;
    mesaselecionada := TJson.JsonToObject<TMesa>(jsonMesa);
    valor := FormatFloat('#,0.00', mesaselecionada.valor);
    valor := valor.Replace(',', '');

    if (not mesaselecionada.FStatus) then // mesa sem consumo
    begin
      trans := 4;
      mensagemerro := 'Mesa sem movimento!';
      navs := navs + '<TONE type=ERROR>';
    end;
  end;

  case trans of
    1:
      begin
        navs := navs + '<GET TYPE=HIDDEN NAME=trans VALUE=9>';
        navs := navs + '<GET TYPE=HIDDEN NAME=mesa VALUE=' + mesa.ToString() + '>';

        navs := navs + '<PAGAMENTO IPTEF=172.16.40.175 PORTATEF=4096 CODLOJA=00000000 TERMID=00190988 TIPO=2 VALOR=' + valor + ' PAGRET=RESPAG BIN=BINCARTAO TIPOCAR=TPOCAR REDEADQ=RDADQ NSU=NSUAUT NSUSITEF=NSUSIT  AUT=CAUT NPAR=1>';
        navs := navs + '<POST>';
      end;
    2:
      begin
        navs := navs + '<GET TYPE=HIDDEN NAME=trans VALUE=9>';
        navs := navs + '<GET TYPE=HIDDEN NAME=mesa VALUE=' + mesa.ToString() + '>';

        navs := navs + '<PAGAMENTO IPTEF=172.16.40.175 PORTATEF=4096 CODLOJA=00000000 TERMID=00190988 TIPO=3 VALOR=' + valor + ' PAGRET=RESPAG BIN=BINCARTAO TIPOCAR=TPOCAR REDEADQ=RDADQ NSU=NSUAUT NSUSITEF=NSUSIT  AUT=CAUT NPAR=1>';
        //navs := navs + '<PAGAMENTO IPTEF=201.21.195.214 PORTATEF=4096 CODLOJA=00000000 TERMID=00190988 TIPO=3 VALOR=' + valor + ' PAGRET=RESPAG BIN=BINCARTAO TIPOCAR=TPOCAR REDEADQ=RDADQ NSU=NSUAUT NSUSITEF=NSUSIT  AUT=CAUT NPAR=1>';
        navs := navs + '<POST>';
      end;
    3:
      begin
        navs := navs + '<GET TYPE=HIDDEN NAME=mesa VALUE=' + mesa.ToString() + '>';
        navs := navs + '<GET TYPE=HIDDEN NAME=valor VALUE=' + valor + '>';

        navs := navs + '<CONSOLE><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br> Clique na forma de pagamento</CONSOLE>';
        navs := navs + '<CONLOGO NAME=ec.bmp x=10 y=0>';
        navs := navs + '<CONLOGO NAME=debito.bmp x=35 y=100>';
        navs := navs + '<RECTANGLE NAME=1 X=35 Y=100 WIDTH=221 HEIGHT=35 VISIBLE=0>';
        navs := navs + '<CONLOGO NAME=credito.bmp x=35 y=180>';
        navs := navs + '<RECTANGLE NAME=2 X=35 Y=180 WIDTH=221 HEIGHT=35 VISIBLE=0>';
        navs := navs + '<CAPTURE NAME=trans>';
        navs := navs + '   <GET TYPE=TOUCH>';
        navs := navs + '   <GET TYPE=FIELD LIN=40 COL=9 SIZE=1 NOENTER=1>';
        navs := navs + '</CAPTURE>';
        navs := navs + '<POST>';
      end;
    4:
      begin
        navs := navs + '<GET TYPE=HIDDEN NAME=trans VALUE=0>';
        navs := navs + '<CONSOLE><br><br><br<br><br><br><br><br>' + Padc(mensagemerro, 30);
        navs := navs + '<br><br>' + Padc('pressione algo', 30) + '</CONSOLE>';
        navs := navs + '<CONLOGO NAME=ec.bmp x=10 y=0>';
        navs := navs + '<CONLOGO NAME=mesa1.bmp x=35 y=0>';
        navs := navs + '<GET TYPE=ANYKEY>';
        navs := navs + '<POST>';
      end;
    9:
      begin
        pos.PagamentoMesa(mesa);

        navs := navs + '<GET TYPE=HIDDEN NAME=trans VALUE=0>';
        navs := navs + '<POST>';

      end
  else
    navs := navs + '<GET TYPE=HIDDEN NAME=trans VALUE=3>';
    navs := navs + '<CONSOLE><br><br><br<br><br><br><br><br>' + Padc('Digite o numero da mesa:', 30) + '</console>';
    navs := navs + '<CONLOGO NAME=ec.bmp x=10 y=0>';
    navs := navs + '<CONLOGO NAME=mesa1.bmp x=35 y=0>';
    navs := navs + '<GET TYPE=FIELD NAME=mesa LIN=9 COL=14 MASK=99 LABEL=Numero da Mesa  NOENTER=1 ZL>';
    navs := navs + '<POST>';
  end;

  Response.Content := navs;
end;

function TWebModule1.Padc(str: string; len: integer): string;
var
  pad: integer;
begin
  pad := trunc(len / 2);
  pad := pad - trunc(str.Length / 2);
  result := StringOfChar(' ', pad) + str + StringOfChar(' ', pad)
end;

procedure TWebModule1.WebFileDispatcher1BeforeDispatch(Sender: TObject; const AFileName: string; Request: TWebRequest; Response: TWebResponse; var Handled: boolean);
var
  D1, D2: TDateTime;
begin
  Handled := False;
  if SameFileName(ExtractFileName(AFileName), 'serverfunctions.js') then
    if not FileExists(AFileName) or (FileAge(AFileName, D1) and FileAge(WebApplicationFileName, D2) and (D1 < D2)) then
    begin
      DSProxyGenerator1.TargetDirectory := ExtractFilePath(AFileName);
      DSProxyGenerator1.TargetUnitName := ExtractFileName(AFileName);
      DSProxyGenerator1.Write;
    end;
end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  FServerFunctionInvokerAction := ActionByName('ServerFunctionInvokerAction');
end;

initialization

finalization

Web.WebReq.FreeWebModules;

end.
