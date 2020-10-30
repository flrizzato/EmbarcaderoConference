unit NotaService;

interface

uses
  XData.Server.Module,
  XData.Service.Common;

type
  [ServiceContract]
  INotaService = interface(IInvokable)
    ['{0DAF857A-EB46-44EB-8EF2-1E444520B627}']
    [HttpGet] procedure Registrar(Nota: Integer; out Media: double; out Total: Integer);
  end;

  [ServiceImplementation]
  TNotaService = class(TInterfacedObject, INotaService)
    procedure Registrar(Nota: Integer; out Media: double; out Total: Integer);
  end;

implementation

var
  SomaNotas: Integer;
  TotalNotas: Integer;


{ TNotaService }

procedure TNotaService.Registrar(Nota: Integer; out Media: double;
  out Total: Integer);
begin
  Inc(SomaNotas, Nota);
  Inc(TotalNotas);
  Media := SomaNotas / TotalNotas;
  Total := TotalNotas;
end;

initialization
  RegisterServiceType(TypeInfo(INotaService));
  RegisterServiceType(TNotaService);

end.
