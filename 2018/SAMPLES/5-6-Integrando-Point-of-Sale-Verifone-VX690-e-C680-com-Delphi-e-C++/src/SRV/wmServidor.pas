unit wmServidor;

interface

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  System.NetEncoding,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Rest.Json,
  // System.uJson,
  // Data.DB.Helper,
  System.Json,
  System.IOUtils,
  System.types;

type
  TItensPedido = class
    fRowId: integer;
    fcodigo: integer;
    fdescricao: string;
    fqtd: integer;
    funitario: extended;
    ftotal: extended;

    property RowId: integer read fRowId write fRowId;
    property codigo: integer read fcodigo write fcodigo;
    property descricao: string read fdescricao write fdescricao;
    property qtd: integer read fqtd write fqtd;
    property unitario: extended read funitario write funitario;
    property total: extended read ftotal write ftotal;
  end;

  TwbmServidor = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure wbmServidorwaiVendaAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure wbmServidorwaiPOSAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure wbmServidorwaiimprimeAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    procedure loga(log: string; arq: string = 'log.txt');
    { Private declarations }
  public
    { Public declarations }
  end;

const
  dirapp = 'C:\Users\myuser\Dropbox\EC2018\bin';

var
  WebModuleClass: TComponentClass = TwbmServidor;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

procedure TwbmServidor.loga(log: string; arq: string = 'log.txt');
var
  arquivo: string;
  tsllog: TStringList;
begin
  arquivo := IncludeTrailingPathDelimiter(dirapp) + arq;
  tsllog := TStringList.Create();
  if fileExists(arquivo) then
    tsllog.LoadFromFile(arquivo);
  tsllog.Add(log);
  tsllog.SaveToFile(arquivo);
end;

procedure TwbmServidor.wbmServidorwaiimprimeAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  pedido: TStringList;
  ItensPedido: TJSONArray;
  I: integer;
  navs: TStringList;
  linha: string;
  p: integer;
  itens: TItensPedido;
begin
  try
    linha := '';
    if Request.QueryFields.Values['RESPAG'] = 'APROVADO' then
    begin
      pedido := TStringList.Create();
      pedido.LoadFromFile(IncludeTrailingPathDelimiter(dirapp) + 'ped.pos');
      { convert String to JSON }
      ItensPedido := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(pedido[2]), 0) as TJSONArray;

      navs := TStringList.Create();
             // 000 0000000000000000000000000  000  000,00
      navs.Add('           Pedido de venda                ');
      navs.Add('------------------------------------------');
      navs.Add('cod descricao                  qtd   total');
      navs.Add('------------------------------------------');

      for I := 0 to ItensPedido.Count - 1 do
      begin
        loga(ItensPedido.Items[I].ToJSON);
        itens := TJson.JsonToObject<TItensPedido>(ItensPedido.Items[I].ToJSON);

        linha := '';
        linha := linha + itens.codigo.ToString().PadLeft(3) + ' ';
        linha := linha + itens.descricao.PadRight(26) + ' ';
        linha := linha + FOrmatFloat('#0', itens.qtd).PadLeft(3) + ' ';
        linha := linha + FOrmatFloat('#0.00', itens.total).PadLeft(7);
        navs.Add(linha);
      end;
      navs.Add(('TOTAL:' + pedido[3]).PadLeft(42));
      navs.Add('------------------------------------------');

      linha := '';

      for p := 0 to navs.Count - 1 do
        linha := linha + '<PRINTER>' + navs[p] + '<BR></PRINTER>';

      for p := 0 to 5 do
        linha := linha + '<PRINTER><BR></PRINTER>';
    end;
  except
    on e: exception do
      loga(e.Message);
  end;

  linha := linha + '<POST>';

  TFile.Delete(IncludeTrailingPathDelimiter(dirapp) + 'ped.pos');

  Response.Content := linha;

end;

procedure TwbmServidor.wbmServidorwaiPOSAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  navs: string;
  pedido: TStringList;
  valor: string;
begin
  if fileExists(IncludeTrailingPathDelimiter(dirapp) + 'ped.txt') then
  begin
    TFile.Move(IncludeTrailingPathDelimiter(dirapp) + 'ped.txt', IncludeTrailingPathDelimiter(dirapp) + 'ped.pos');

    pedido := TStringList.Create();
    pedido.LoadFromFile(IncludeTrailingPathDelimiter(dirapp) + 'ped.pos');

    valor := StringReplace(pedido[3], ',', '', [rfReplaceAll]);
    valor := StringReplace(valor, '.', '', [rfReplaceAll]);

    navs := navs + '<PAY>';
    navs := navs + 'IPTEF=172.20.10.7;';
    navs := navs + 'PORTATEF=4096;';
    navs := navs + 'CODLOJA=00000000;';
    navs := navs + 'TIPO=3;';
    navs := navs + 'PAGRET=RESPAG;';
    navs := navs + 'BIN=BINCARTAO;';
    navs := navs + 'TIPOCAR=TPOCAR;';
    navs := navs + 'NPAR=1;';
    navs := navs + 'VALOR=' + valor + ';';
    navs := navs + '</PAY>';
    navs := navs + '<POST RESOURCE=/Servidor.cgi/imprime>';
  end
  else
  begin
    navs := '<console><BR>';
    navs := navs + '<BR>    Aguardando pedido';
    navs := navs + '<BR>   Digite no aplicativo';
    navs := navs + '</console>';
    navs := navs + '<post TIMEOUT=150>';
  end;

  Response.Content := navs;
end;

procedure TwbmServidor.wbmServidorwaiVendaAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  numero: string;
  forma: string;
  json_vendas: string;
  valor_total: extended;
begin
  // venda
  try
    numero := Request.ContentFields.Values['numero'];
    forma := Request.ContentFields.Values['forma'];
    json_vendas := TNetEncoding.html.Decode(Request.ContentFields.Values['vendas']);
    valor_total := StrToFloat(Request.ContentFields.Values['valor_total']);

    loga(numero, 'ped.$$$');
    loga(forma, 'ped.$$$');
    loga(json_vendas, 'ped.$$$');
    loga(FOrmatFloat('#######0.00', valor_total), 'ped.$$$');

    TFile.Move(IncludeTrailingPathDelimiter(dirapp)+'ped.$$$',IncludeTrailingPathDelimiter(dirapp)+'ped.txt');

  except
    on e: exception do
    begin
      loga(e.Message);
    end;
  end;
end;

procedure TwbmServidor.WebModule1DefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := '<html>' + '<head><title>Servidor EC2018</title></head>' + '<body>Utilize os dispositivos para acesso</body>' + '</html>';
end;

end.
