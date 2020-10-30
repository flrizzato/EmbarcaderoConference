{****************************************************************************
 * Desenvolvidog por Carlos Henrique Cantu (c) 2017                         *
 * -------------------------------------------------------------------------*
 * www.firebase.com.br                                                      *
 * www.FirebirdDevelopersDay.com.br                                         *
 ****************************************************************************}
unit uGeoCode;

interface

uses IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, System.JSON, IdURI;

type
  TGeoCode = class(TObject)
  private
    idHTTP: TidHTTP;
  public
    Latitude: double;
    Longitude: double;
    LastStatus: string;
    APIKey: string;
    constructor Create;
    destructor Destroy;
    function DoGeocode(Endereco:string): boolean;
  end;

implementation

{ TGeoCode }

uses System.SysUtils;

constructor TGeoCode.Create;
begin
  inherited;
  idHTTP := TIdHTTP.Create;
  idHTTP.ConnectTimeout := 3000;
  idHTTP.ReadTimeout := 5000;
  idHTTP.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'; // Chrome
end;

destructor TGeoCode.Destroy;
begin
  idHTTP.Free;
  inherited;
end;

function TGeoCode.DoGeocode(Endereco: string): boolean;
var
  url: string;
  JObj, location, geometry: TJSONObject;
begin
  Result := false;
  try
    if APIKey <> '' then
      url := TIdURI.URLEncode('https://maps.googleapis.com/maps/api/geocode/json?address=' + Endereco) + '&key=' + APIKey
    else
      url := TIdURI.URLEncode('http://maps.google.com/maps/api/geocode/json?address=' + Endereco);
    JObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(idHTTP.Get(url)), 0) as TJSONObject;
    try
      LastStatus := JObj.GetValue('status').Value;
      if LastStatus = 'OK' then
      begin
        geometry := (((JObj.GetValue('results') as TJSONArray).Get(0) as TJSONObject).GetValue('geometry') as TJSONObject);
        location := geometry.GetValue('location') as TJSONObject;
        Longitude := StrToFloat(location.GetValue('lng').Value);
        Latitude := StrToFloat(location.GetValue('lat').Value);
        Result := true;
      end;
    finally
      JObj.Free;
    end;
  except // Não deixa gerar exceção para o usuario.
  end;
end;

end.
