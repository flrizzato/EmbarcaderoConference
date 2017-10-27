unit udmAPP;

interface

uses
  System.SysUtils,
  System.Classes,
  IPPeerClient,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Client,
  REST.Types,
  REST.Json,
  REST.Response.Adapter,
  Data.DB,
  fmx.dialogs,
  Datasnap.DBClient,
  SimpleDS;

type
  TMesa = record
  strict private
    FMesa: integer;
    FStatus: Boolean;
    FValor: Extended;
  public
    property mesa: integer read FMesa write FMesa;
    property status: Boolean read FStatus write FStatus;
    property valor: Extended read FValor write FValor;
  end;

  TdmAPP = class(TDataModule)
    Client: TRESTClient;
    request: TRESTRequest;
    Response: TRESTResponse;
  private
    { Private declarations }
  public
  public
    function statusmesa(mesa: integer): TMesa;
    { Public declarations }
  end;

var
  dmAPP: TdmAPP;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TDataModule1 }

function TdmAPP.statusmesa(mesa: integer): TMesa;
var
  Json: string;
  DadosMesa: TMesa;
begin
  request.Method := rmGET;
  request.Resource := '/datasnap/rest/tpos/listamesas/' + mesa.ToString;
  request.Execute;
  //Json := Response.JSONText;
  //Json := Json.Substring(10, Json.Length);
  //Json := Copy(Json, 1, Json.Length - 1);
  //ShowMessage(json);
  //result := DadosMesa;
end;

end.
