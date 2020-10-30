unit uMeuDataSet;

interface

uses
  FireDac.Comp.Client, System.Classes, uAtributos;

type
{$M+}
  TMeuDataSet = class(TFDMemTable)
  public
    procedure Post; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  uContextoAspecto, Aspect4D, Aspect4D.Impl, Vcl.Dialogs;

constructor TMeuDataSet.Create(AOwner: TComponent);
begin
  inherited;
  ContextoAspecto.Weaver.Proxify(Self);
end;

destructor TMeuDataSet.Destroy;
begin
  ContextoAspecto.Weaver.Unproxify(Self);
  inherited;
end;

procedure TMeuDataSet.Post;
begin
  inherited;
  ShowMessage('Chamei o post')
end;

end.
