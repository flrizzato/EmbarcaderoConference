unit POO.Controller.Log.Facade;

interface

uses
  POO.Controller.Interfaces, POO.Model.Log.Factory;

Type
  TControllerLogFacade = class(TInterfacedObject, iControllerLogFacade)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iControllerLogFacade;
      function SalvarLog(Value : String) : iControllerLogFacade;
  end;

implementation

{ TControllerLogFacade }

constructor TControllerLogFacade.Create;
begin

end;

destructor TControllerLogFacade.Destroy;
begin

  inherited;
end;

class function TControllerLogFacade.New: iControllerLogFacade;
begin
  Result := Self.Create;
end;

function TControllerLogFacade.SalvarLog(Value: String): iControllerLogFacade;
begin
  TModelLogFactory.New
    .LogTXT(
      TModelLogFactory.New
        .LogEmail(
          TModelLogFactory.New
            .LogBD(
              TModelLogFactory.New
              .Log
            )
        )
    ).Salvar(Value);
end;

end.
