unit uFramework;

interface

type
  // Target (classe base para conexões DataSnap)
  TCustomRemoteServer = class abstract
    procedure Connect(); virtual; abstract;
  end;

  // Classe base para conexões a banco de dados
  TCustomConnection = class abstract
    procedure Open(); virtual; abstract;
  end;

  // Classe Concreta
  TSOAPConnection = class(TCustomRemoteServer)
    procedure Connect(); override;
  end;

  // Adaptee
  TSQLConnection = class(TCustomConnection)
    procedure Open(); override;
  end;

  // Adapter
  TDSProviderConnection = class(TCustomRemoteServer)
  strict private
    FConnection: TSQLConnection;
  public
    constructor Create(ASQLConnection: TSQLConnection);
    procedure Connect(); override;
  end;

implementation

{ TSOAPConnection }

procedure TSOAPConnection.Connect();
begin
  Writeln('Conectado no servidor SOAP');
end;

{ TDSProviderConnection }

procedure TDSProviderConnection.Connect();
begin
  // delegação polimórfica adaptada
  // transforma um Connect() em um Open()
  FConnection.Open();
end;

constructor TDSProviderConnection.Create(
  ASQLConnection: TSQLConnection);
begin
  self.FConnection := ASQLConnection;
end;

{ TSQLConnection }

procedure TSQLConnection.Open();
begin
  Writeln('Conectado no servidor DataSnap via SQLConnection');
end;

end.
