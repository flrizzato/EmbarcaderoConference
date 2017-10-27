unit Pedido;

interface

uses
  System.SysUtils,
  System.Classes,
  Datasnap.DSServer,
  Datasnap.DSAuth;

type
{$METHODINFO ON}
  TPedido = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function mesas:string;
  end;
{$METHODINFO OFF}

implementation

end.
