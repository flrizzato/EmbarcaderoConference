unit uDMDados;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, IPPeerClient,
  Data.DBXCommon, Data.DB, Data.SqlExpr;

type
  TDMDados = class(TDataModule)
    SQLConnection1: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMDados: TDMDados;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDMDados.DataModuleCreate(Sender: TObject);
begin
//10.211.55.5
//edesoftsa.no-ip.biz
end;

end.
