unit LoginService;

interface

uses
  XData.Service.Common;

type
  [ServiceContract]
  ILoginService = interface(IInvokable)
  ['{9CFD59B2-A832-4F82-82BB-9A25FC93F305}']
    function Login(const User, Password: string): string;
  end;

implementation

end.
