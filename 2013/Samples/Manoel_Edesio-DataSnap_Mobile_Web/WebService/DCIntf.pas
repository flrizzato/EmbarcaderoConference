{ Invokable interface IDC }

unit DCIntf;

interface

uses InvokeRegistry, Types, XSBuiltIns, uClasses, Classes;

type

  { Invokable interfaces must derive from IInvokable }
  IDC = interface(IInvokable)
  ['{45E2C5AD-4FAC-44A2-821F-00712759197E}']
    function Getcliente(Acliente:integer):TCliente;stdcall;
    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IDC));

end.
