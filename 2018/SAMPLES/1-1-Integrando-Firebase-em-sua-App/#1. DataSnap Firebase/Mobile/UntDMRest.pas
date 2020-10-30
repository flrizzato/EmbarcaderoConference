unit UntDMRest;

interface

uses
  System.SysUtils,
  System.Classes,

  IPPeerClient,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  Data.DB,
  Data.Bind.Components,
  Data.Bind.ObjectScope,

  REST.Response.Adapter,
  REST.Client,

  Constantes;

type
  TUDMRest = class(TDataModule)
    rstClient: TRESTClient;
    rstRequest: TRESTRequest;
    rstResponse: TRESTResponse;
    rstAdapt: TRESTResponseDataSetAdapter;
    memDados: TFDMemTable;
    FDMemTable1: TFDMemTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UDMRest: TUDMRest;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TUDMRest }

end.
