// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://www.webservicex.com/globalweather.asmx?wsdl
//  >Import : http://www.webservicex.com/globalweather.asmx?wsdl>0
// Encoding : utf-8
// Version  : 1.0
// (07/10/2017 17:03:17 - - $Rev: 86412 $)
// ************************************************************************ //

unit globalweather;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]


  string_         =  type string;      { "http://www.webserviceX.NET"[GblElm] }

  // ************************************************************************ //
  // Namespace : http://www.webserviceX.NET
  // soapAction: http://www.webserviceX.NET/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : GlobalWeatherSoap
  // service   : GlobalWeather
  // port      : GlobalWeatherSoap
  // URL       : http://www.webservicex.com/globalweather.asmx
  // ************************************************************************ //
  GlobalWeatherSoap = interface(IInvokable)
  ['{8091B155-5793-08E1-8C8C-B170D069C2CB}']
    function  GetWeather(const CityName: string; const CountryName: string): string; stdcall;
    function  GetCitiesByCountry(const CountryName: string): string; stdcall;
  end;


  // ************************************************************************ //
  // Namespace : http://www.webserviceX.NET
  // style     : ????
  // use       : ????
  // binding   : GlobalWeatherHttpGet
  // service   : GlobalWeather
  // port      : GlobalWeatherHttpGet
  // ************************************************************************ //
  GlobalWeatherHttpGet = interface(IInvokable)
  ['{4F891054-31E4-F916-805B-2705ED0C70F9}']
    function  GetWeather(const CityName: string; const CountryName: string): string_; stdcall;
    function  GetCitiesByCountry(const CountryName: string): string_; stdcall;
  end;


  // ************************************************************************ //
  // Namespace : http://www.webserviceX.NET
  // style     : ????
  // use       : ????
  // binding   : GlobalWeatherHttpPost
  // service   : GlobalWeather
  // port      : GlobalWeatherHttpPost
  // ************************************************************************ //
  GlobalWeatherHttpPost = interface(IInvokable)
  ['{F2DF5EC7-AD1F-1E69-9EF4-109B3992260C}']
    function  GetWeather(const CityName: string; const CountryName: string): string_; stdcall;
    function  GetCitiesByCountry(const CountryName: string): string_; stdcall;
  end;

function GetGlobalWeatherSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): GlobalWeatherSoap;
function GetGlobalWeatherHttpGet(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): GlobalWeatherHttpGet;
function GetGlobalWeatherHttpPost(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): GlobalWeatherHttpPost;


implementation
  uses System.SysUtils;

function GetGlobalWeatherSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): GlobalWeatherSoap;
const
  defWSDL = 'http://www.webservicex.com/globalweather.asmx?wsdl';
  defURL  = 'http://www.webservicex.com/globalweather.asmx';
  defSvc  = 'GlobalWeather';
  defPrt  = 'GlobalWeatherSoap';
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
    Result := (RIO as GlobalWeatherSoap);
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


function GetGlobalWeatherHttpGet(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): GlobalWeatherHttpGet;
const
  defWSDL = 'http://www.webservicex.com/globalweather.asmx?wsdl';
  defURL  = '';
  defSvc  = 'GlobalWeather';
  defPrt  = 'GlobalWeatherHttpGet';
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
    Result := (RIO as GlobalWeatherHttpGet);
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


function GetGlobalWeatherHttpPost(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): GlobalWeatherHttpPost;
const
  defWSDL = 'http://www.webservicex.com/globalweather.asmx?wsdl';
  defURL  = '';
  defSvc  = 'GlobalWeather';
  defPrt  = 'GlobalWeatherHttpPost';
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
    Result := (RIO as GlobalWeatherHttpPost);
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
  { GlobalWeatherSoap }
  InvRegistry.RegisterInterface(TypeInfo(GlobalWeatherSoap), 'http://www.webserviceX.NET', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(GlobalWeatherSoap), 'http://www.webserviceX.NET/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(GlobalWeatherSoap), ioDocument);
  { GlobalWeatherSoap.GetWeather }
  InvRegistry.RegisterMethodInfo(TypeInfo(GlobalWeatherSoap), 'GetWeather', '',
                                 '[ReturnName="GetWeatherResult"]', IS_OPTN);
  { GlobalWeatherSoap.GetCitiesByCountry }
  InvRegistry.RegisterMethodInfo(TypeInfo(GlobalWeatherSoap), 'GetCitiesByCountry', '',
                                 '[ReturnName="GetCitiesByCountryResult"]', IS_OPTN);
  { GlobalWeatherHttpGet }
  InvRegistry.RegisterInterface(TypeInfo(GlobalWeatherHttpGet), 'http://www.webserviceX.NET', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(GlobalWeatherHttpGet), '');
  { GlobalWeatherHttpPost }
  InvRegistry.RegisterInterface(TypeInfo(GlobalWeatherHttpPost), 'http://www.webserviceX.NET', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(GlobalWeatherHttpPost), '');
  RemClassRegistry.RegisterXSInfo(TypeInfo(string_), 'http://www.webserviceX.NET', 'string_', 'string');

end.