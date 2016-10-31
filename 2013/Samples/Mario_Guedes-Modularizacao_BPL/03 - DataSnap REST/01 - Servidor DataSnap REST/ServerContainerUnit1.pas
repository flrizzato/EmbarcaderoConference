unit ServerContainerUnit1;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSHTTPCommon, Datasnap.DSHTTP,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSAuth, IPPeerServer, Datasnap.DSReflect;

type

  /// <summary>
  /// http://www.andreanolanusse.com/pt/registrando-datasnap-server-class-em-tempo-de-execucao-no-delphi/
  /// </summary>
  TSimpleServerClass = class(TDSServerClass)
  private
    FPersistentClass: TPersistentClass;
  protected
    function GetDSClass: TDSClass; override;
  public
    constructor Create(AOwner: TComponent; AServer: TDSCustomServer;
      AClass: TPersistentClass; ALifeCycle: String); reintroduce; overload;
  end;

  TServerContainer1 = class(TDataModule)
    DSServer1: TDSServer;
    DSHTTPService1: TDSHTTPService;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  ServerContainer1: TServerContainer1;

implementation

uses Winapi.Windows;

{$R *.dfm}

procedure TServerContainer1.DataModuleCreate(Sender: TObject);
var
  rLocalizador: TSearchRec;
  iAchou      : Integer;
  hPlugIn     : NativeUInt;
  _classes    : function: TArray<TPersistentClass>;
  oClasse     : TPersistentClass;
begin
  iAchou := FindFirst('.\*.bpl', 0, rLocalizador);
  while (iAchou = 0) do
  begin
    hPlugIn := LoadPackage('.\' + rLocalizador.Name);

    _classes := GetProcAddress(hPlugIn, 'ClassesRemotas');

    for oClasse in _classes do
    begin
      TSimpleServerClass.Create(Self, Self.DSServer1, oClasse, 'Invocation');
    end;

    iAchou := FindNext(rLocalizador);
  end;
  System.SysUtils.FindClose(rLocalizador);

  Self.DSServer1.Start;
end;

{ TSimpleServerClass }

constructor TSimpleServerClass.Create(AOwner: TComponent;
  AServer: TDSCustomServer; AClass: TPersistentClass; ALifeCycle: String);
begin
  inherited Create(AOwner);
  FPersistentClass := AClass;
  Self.Server := AServer;
  Self.LifeCycle := ALifeCycle;
end;

function TSimpleServerClass.GetDSClass: TDSClass;
begin
  Result := TDSClass.Create(FPersistentClass, False);
end;

end.
