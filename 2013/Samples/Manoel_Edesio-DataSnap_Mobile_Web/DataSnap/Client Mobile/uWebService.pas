// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://edesoftsa.no-ip.biz:4000/servicedc/wEBAPPDC.EXE/wsdl/IDC
//  >Import : http://edesoftsa.no-ip.biz:4000/servicedc/wEBAPPDC.EXE/wsdl/IDC>0
// Encoding : utf-8
// Version  : 1.0
// (30/10/2013 20:59:55 - - $Rev: 56641 $)
// ************************************************************************ //

unit uWebService;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]

  TCliente             = class;                 { "urn:uClasses"[GblCplx] }



  // ************************************************************************ //
  // XML       : TCliente, global, <complexType>
  // Namespace : urn:uClasses
  // ************************************************************************ //
  TCliente = class(TRemotable)
  private
    FId: Integer;
    FNome: string;
    FCidade: string;
    FEstado: string;
    FEndereco: string;
    FTelefone: string;
  published
    property Id:       Integer  read FId write FId;
    property Nome:     string   read FNome write FNome;
    property Cidade:   string   read FCidade write FCidade;
    property Estado:   string   read FEstado write FEstado;
    property Endereco: string   read FEndereco write FEndereco;
    property Telefone: string   read FTelefone write FTelefone;
  end;


  // ************************************************************************ //
  // Namespace : urn:DCIntf-IDC
  // soapAction: urn:DCIntf-IDC#Getcliente
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : IDCbinding
  // service   : IDCservice
  // port      : IDCPort
  // URL       : http://edesoftsa.no-ip.biz:4000/servicedc/wEBAPPDC.EXE/soap/IDC
  // ************************************************************************ //
  IDC = interface(IInvokable)
  ['{2387A10D-F1B8-9393-8444-4ECECD33CD96}']
    function  Getcliente(const Acliente: Integer): TCliente; stdcall;
  end;

function GetIDC(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IDC;


implementation
  uses SysUtils;

function GetIDC(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IDC;
const
  defWSDL = 'http://edesoftsa.no-ip.biz:4000/servicedc/wEBAPPDC.EXE/wsdl/IDC';
  defURL  = 'http://edesoftsa.no-ip.biz:4000/servicedc/wEBAPPDC.EXE/soap/IDC';
  defSvc  = 'IDCservice';
  defPrt  = 'IDCPort';
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
    Result := (RIO as IDC);
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
  { IDC }
  InvRegistry.RegisterInterface(TypeInfo(IDC), 'urn:DCIntf-IDC', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IDC), 'urn:DCIntf-IDC#Getcliente');
  RemClassRegistry.RegisterXSClass(TCliente, 'urn:uClasses', 'TCliente');

end.