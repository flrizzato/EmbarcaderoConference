unit WebModuleUnit1;

interface

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPApp;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  navs: string;
  trans: integer;
begin
  trans := StrToIntDef(Request.QueryFields.Values['trans'], 0);

  case trans of
    1:
      begin
        navs := navs + '<GET TYPE=HIDDEN NAME=trans VALUE=0>';
        navs := navs + '<PAGAMENTO IPTEF=172.16.40.175 PORTATEF=4096 CODLOJA=00000000 TERMID=00190988 TIPO=2 VALOR=100 PAGRET=RESPAG BIN=BINCARTAO TIPOCAR=TPOCAR REDEADQ=RDADQ NSU=NSUAUT NSUSITEF=NSUSIT  AUT=CAUT NPAR=1>';
        navs := navs + '<POST>';
      end;
    2:
      begin
        navs := navs + '<GET TYPE=HIDDEN NAME=trans VALUE=0>';
        navs := navs + '<PAGAMENTO IPTEF=172.16.40.175 PORTATEF=4096 CODLOJA=00000000 TERMID=00190988 TIPO=3 VALOR=500 PAGRET=RESPAG BIN=BINCARTAO TIPOCAR=TPOCAR REDEADQ=RDADQ NSU=NSUAUT NSUSITEF=NSUSIT  AUT=CAUT NPAR=1>';
        navs := navs + '<POST>';
      end;
  else
    begin
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
  end;
  Response.Content := navs;
end;

end.
