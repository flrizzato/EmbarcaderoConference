unit Unt_Nucleo;

interface

uses
  System.SysUtils,
  System.Classes,
  IPPeerClient,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Client,
  REST.Json.Types;

type

  TSummary = class(TObject)
  private
    FTotal_count: Integer;
  public
    property total_count: Integer read FTotal_count write FTotal_count;
  end;

  TItemAmigo = class(TObject)

  end;

  TAmigos = class(TObject)
  private
    FData   : TArray<TItemAmigo>;
    FSummary: TSummary;
  published
    property Amigos: TArray<TItemAmigo> read FData write FData;
  end;

  TRespostaFacebook = class(TObject)
  private
    FId     : string;
    FName   : string;
    FFriends: TAmigos;
  published
    property ID     : string read FId write FId;
    property Name   : string read FName write FName;
    property Friends: TAmigos read FFriends write FFriends;
  end;

  TdmNucleo = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
  private
    { Private declarations }
  public
    procedure ProcessarLista(const AAccessToken: string; out AQuantidade: Integer);
  end;

var
  dmNucleo: TdmNucleo;

implementation

uses
  REST.Json,
  System.Json;

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TDataModule1 }

procedure TdmNucleo.ProcessarLista(const AAccessToken: string; out AQuantidade: Integer);
var
  oResposta    : TJSONObject;
  oRespostaFace: TRespostaFacebook;
begin
  Self.RESTRequest1.Params.ParameterByName('access_token').Value := AAccessToken;

  Self.RESTRequest1.Execute;

  if (Self.RESTResponse1.StatusCode = 200) then
  begin
    oRespostaFace := TJson.JsonToObject<TRespostaFacebook>(TJSONObject(Self.RESTResponse1.JSONValue));

    if (Self.RESTResponse1.JSONValue is TJSONObject) then
    begin
      oResposta := TJSONObject(Self.RESTResponse1.JSONValue);
      AQuantidade := TJSONNumber(TJSONObject(oResposta.Get('summary').JSONValue).Get('total_count').JSONValue).AsInt;
    end;
  end
  else
  begin
    raise Exception.Create('Erro na requisição HTTP');
  end;
end;

end.
