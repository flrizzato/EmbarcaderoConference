// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost:8080/wsdl/IDelphiConference
//  >Import : http://localhost:8080/wsdl/IDelphiConference>0
// Version  : 1.0
// (12/10/2014 13:48:39 - - $Rev: 69934 $)
// ************************************************************************ //

unit untIDelphiConference;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"[]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  TCliente             = class;                 { "urn:untDelphiConferenceIntf"[GblCplx] }



  // ************************************************************************ //
  // XML       : TCliente, global, <complexType>
  // Namespace : urn:untDelphiConferenceIntf
  // ************************************************************************ //
  TCliente = class(TRemotable)
  private
    FNome: string;
    FDataNascimento: string;
    FSexo: string;
    FCidade: string;
  published
    property Nome:           string  read FNome write FNome;
    property DataNascimento: string  read FDataNascimento write FDataNascimento;
    property Sexo:           string  read FSexo write FSexo;
    property Cidade:         string  read FCidade write FCidade;
  end;


  // ************************************************************************ //
  // Namespace : urn:untDelphiConferenceIntf-IDelphiConference
  // soapAction: urn:untDelphiConferenceIntf-IDelphiConference#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : IDelphiConferencebinding
  // service   : IDelphiConferenceservice
  // port      : IDelphiConferencePort
  // URL       : http://localhost:8080/soap/IDelphiConference
  // ************************************************************************ //
  IDelphiConference = interface(IInvokable)
  ['{CA9CBB04-5E57-2FE7-BDC3-2983BD99B74D}']
    function  GetNomeCliente(const AIdCliente: Integer): string; stdcall;
    function  GetCliente(const AIdCliente: Integer): TCliente; stdcall;
    function  GetIntervaloClientes(const AIdInicial: Integer; const AIdFinal: Integer): string; stdcall;
  end;

function GetIDelphiConference(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IDelphiConference;


implementation
  uses System.SysUtils;

function GetIDelphiConference(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IDelphiConference;
const
  defWSDL = 'http://localhost:8080/wsdl/IDelphiConference';
  defURL  = 'http://localhost:8080/soap/IDelphiConference';
  defSvc  = 'IDelphiConferenceservice';
  defPrt  = 'IDelphiConferencePort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IDelphiConference);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  { IDelphiConference }
  InvRegistry.RegisterInterface(TypeInfo(IDelphiConference), 'urn:untDelphiConferenceIntf-IDelphiConference', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IDelphiConference), 'urn:untDelphiConferenceIntf-IDelphiConference#%operationName%');
  RemClassRegistry.RegisterXSClass(TCliente, 'urn:untDelphiConferenceIntf', 'TCliente');

end.