unit U_DM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TDM = class(TDataModule)
    CDSConsCliente: TClientDataSet;
    CDSConsClienteID_Cliente: TIntegerField;
    CDSConsClienteNome: TStringField;
    CDSConsClienteData: TSQLTimeStampField;
    CDSConsClienteStatus: TStringField;
    CDSConsClienteLimite_Credito: TBCDField;
    CDSConsClienteTipo: TStringField;
    CDSConsClienteLATITUDE: TStringField;
    CDSConsClienteLONGITUDE: TStringField;
    CDSConsClienteBAIRRO: TStringField;
    CDSConsClienteCIDADE: TStringField;
    CDSConsClienteESTADO: TStringField;
    CDSConsClientelogradouro: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
