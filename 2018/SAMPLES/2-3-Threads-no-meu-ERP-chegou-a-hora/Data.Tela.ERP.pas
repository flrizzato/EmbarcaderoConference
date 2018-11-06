unit Data.Tela.ERP;

interface

uses
  System.SysUtils, System.Classes, REST.Client, FireDAC.Stan.Intf, System.JSON,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, IPPeerClient, Data.Bind.Components,
  Data.Bind.ObjectScope, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.DateUtils, REST.Json, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.DApt;

type
  TdmdTelaERP = class(TDataModule)
    memCotacao: TFDMemTable;
    memCotacaodescription: TStringField;
    memCotacaoperiod: TStringField;
    memCotacaounit: TStringField;
    memCotacaoname: TStringField;
    memCotacaodata: TDateTimeField;
    memCotacaovalor: TCurrencyField;
    RESTClient: TRESTClient;
    RESTResponse1: TRESTResponse;
    RESTRequest: TRESTRequest;
    FDConnection: TFDConnection;
    qryCliente: TFDQuery;
    qryCompras: TFDQuery;
    qryProjeto: TFDQuery;
  private
    { Private declarations }
  public
    procedure CarregaCotacoes;
    procedure CarregaClientes;
    procedure CarregaProjetos;
    procedure CarregaCompras;
  end;

var
  dmdTelaERP: TdmdTelaERP;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Classe.Cotacao;

{$R *.dfm}

{ TdmdTelaERP }

procedure TdmdTelaERP.CarregaClientes;
begin
  qryCliente.Close;
  qryCliente.Open;
end;

procedure TdmdTelaERP.CarregaCompras;
begin
  qryCompras.Close;
  qryCompras.Close;
end;

procedure TdmdTelaERP.CarregaCotacoes;
var
  lCotacao: TCotacao;
  lVal: TValor;
begin
  memCotacao.DisableControls;

  Sleep(5000);

  memCotacao.Open;
  RESTRequest.Execute;
  lCotacao := TJson.JsonToObject<TCotacao>(RESTResponse1.Content);
  if Assigned(lCotacao) then
  begin
    for lVal in lCotacao.values do
    begin
      memCotacao.Append;
      memCotacaodescription.AsString := lCotacao.description;
      memCotacaoperiod.AsString := lCotacao.period;
      memCotacaounit.AsString := lCotacao.&unit;
      memCotacaoname.AsString := lCotacao.name;
      memCotacaodata.AsDateTime := UnixToDateTime(lVal.x);
      memCotacaovalor.AsCurrency := lVal.y;
      memCotacao.Post;
    end;
  end else begin
    // mostra status: sem result
  end;

  memCotacao.EnableControls;
end;

procedure TdmdTelaERP.CarregaProjetos;
begin
  qryProjeto.Close;
  qryProjeto.Open;
end;

end.
