unit ServerMethodsUnit;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth;

type
  TServerMethodsFiltro = class(TDSServerModule)
  private
  public
    function HoraServidor:String;
  end;

implementation

{$R *.dfm}

{ TServerMethodsFiltro }

function TServerMethodsFiltro.HoraServidor: String;
begin
  Result := TimeToStr(Time);
end;

end.

