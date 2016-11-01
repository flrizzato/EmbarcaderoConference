unit uConexaoMongo;

interface

uses
  System.SysUtils, System.Classes, mongoWire, bsonDoc;

type
  TMongoConexao = class(TComponent)
    private
      FDatabase : String;
      FHost : String;
      FPorta : Integer;
      FAtivar : Boolean;
      procedure setAtivar(const Value: boolean);
    public
      FMongoWire:TMongoWire;
      constructor Create(AOwner: TComponent); override;
    published
      property Database : String read FDatabase write FDatabase;
      property Host : String read FHost write FHost;
      property Porta : Integer read FPorta write FPorta;
      property Ativar : Boolean read FAtivar write setAtivar;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mongo Components', [TMongoConexao]);
end;

constructor TMongoConexao.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDatabase := 'MeuBanco';
  FHost := 'localhost';
  FPorta := 27017;
end;

procedure TMongoConexao.setAtivar(const Value: boolean);
begin
  FMongoWire:=TMongoWire.Create(FDatabase);
  FMongoWire.Open(FHost,FPorta);
  FAtivar := Value;
end;

end.
