unit uGoogleTranslateClass;

interface

uses  msxml, Activex, HTTPApp, Variants, SysUtils, StrUtils, JSON,
  System.TypInfo, System.Classes, Vcl.AxCtrls, Winapi.MMSystem;

type
  TGoogleLanguages=
    (Autodetect,Afrikaans,Albanian,Arabic,Basque,Belarusian,Bulgarian,Catalan,Chinese,Chinese_Traditional,
    Croatian,Czech,Danish,Dutch,English,Estonian,Filipino,Finnish,French,Galician,German,Greek,
    Haitian_Creole,Hebrew,Hindi,Hungarian,Icelandic,Indonesian,Irish,Italian,Japanese,Latvian,
    Lithuanian,Macedonian,Malay,Maltese,Norwegian,Persian,Polish,Portuguese,Romanian,Russian,
    Serbian,Slovak,Slovenian,Spanish,Swahili,Swedish,Thai,Turkish,Ukrainian,Vietnamese,Welsh,Yiddish);

  TGoogleLanguagesHelper = record helper for TGoogleLanguages
    function Name: string;
    function Codigo: string;
  end;

  TTranslate = class
  public
    class function Translate(const Text:string;Source,Dest:TGoogleLanguages):string;
    class function GerarMp3(const Text: string; Source:TGoogleLanguages): string;
  end;

const
  GoogleLanguagesArr : array[TGoogleLanguages] of string =
  ( 'Autodetect','af','sq','ar','eu','be','bg','ca','zh-CN','zh-TW','hr','cs','da','nl','en','et','tl','fi','fr','gl',
    'de','el','ht','iw','hi','hu','is','id','ga','it','ja','lv','lt','mk','ms','mt','no','fa','pl','pt',
    'ro','ru','sr','sk','sl','es','sw','sv','th','tr','uk','vi','cy','yi');

  GoogleLanguageApiKey   ='AIzaSyCSYmNRajprjh82dBiDPlZS1vbK0VfsNWE';
  GoogleTranslateUrl     ='https://www.googleapis.com/language/translate/v2?key=%s&q=%s&source=%s&target=%s';
  GoogleTranslateUrlAuto ='https://www.googleapis.com/language/translate/v2?key=%s&target=%s&q=%s';
  GoogleTranslateTTSUrl = 'https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&q=%s&tl=%s';


implementation

{ TTranslate }

class function TTranslate.Translate(const Text: string; Source, Dest: TGoogleLanguages): string;
var
  XMLHTTPRequest: IXMLHTTPRequest;
  EncodedRequest: string;
  json          : TJSONObject;
  jPair         : TJSONPair;
  jValue        : TJSONValue;
  Response      : string;
begin
  Result:='';
  if Source=Autodetect then
    EncodedRequest:=Format(GoogleTranslateUrlAuto,[GoogleLanguageApiKey,Dest.Codigo,HTTPEncode(Text)])
  else
    EncodedRequest:=Format(GoogleTranslateUrl,[GoogleLanguageApiKey,HTTPEncode(Text),Source.Codigo,Dest.Codigo]);

  XMLHTTPRequest := CoXMLHTTP.Create;
  XMLHTTPRequest.open('GET', EncodedRequest, False, EmptyParam, EmptyParam);
  XMLHTTPRequest.send('');
  Response:=XMLHTTPRequest.ResponseText;

  if Response<>'' then
  begin
      json    := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Response),0) as TJSONObject; //create a TJSONObject instance
    try
      jPair   := json.Get(0);
      if jPair.JsonString.value='error' then //if error in response
        Result := Format('Error Code %s message %s',[TJSONObject(jPair.JsonValue).Get(1).JsonValue.Value,TJSONObject(jPair.JsonValue).Get(2).JsonValue.Value])
      else //all ok, show the response,
      begin
        jValue := TJSONArray(TJSONObject(jPair.JsonValue).Get(0).JsonValue).Get(0);
        Result := TJSONObject(jValue).Get(0).JsonValue.Value;
      end;
    finally
       json.Free;
    end;

    Result:=HTMLDecode(Result);
  end;
end;


class function TTranslate.GerarMp3(const Text: string; Source:TGoogleLanguages): string;
var
  lXMLHTTPRequest: IXMLHTTPRequest;
  lEncodedRequest: string;
  ljson          : TJSONObject;
  ljPair         : TJSONPair;
  ljValue        : TJSONValue;
  lResponse      : string;
  lMemoryStream: TMemoryStream;
  lStream: IStream;
  lOleStream: TOleStream;
begin
  Result:='';
  lEncodedRequest:=Format(GoogleTranslateTTSUrl,[HTTPEncode(Text),GoogleLanguagesArr[Source]]);

  lXMLHTTPRequest := CoXMLHTTP.Create;
  lXMLHTTPRequest.open('GET', lEncodedRequest, False, EmptyParam, EmptyParam);
  lXMLHTTPRequest.send('');

  if Supports(lXMLHTTPRequest.ResponseStream,IStream,lStream) then
  begin
    lOleStream := TOleStream.Create(lStream);
    try
      lOleStream.Position := 0;
      lMemoryStream := TMemoryStream.Create;
      try
        lMemoryStream.CopyFrom(lOleStream, lOleStream.Size);
        lMemoryStream.Position := 0;
        lMemoryStream.SaveToFile('Teste.mp3');
      finally
        lMemoryStream.Free;
      end;
    finally
      lOleStream.Free;
    end;
  end;
end;

{ TGoogleLanguagesHelper }

function TGoogleLanguagesHelper.Name: string;
begin
  Result := GetEnumName(TypeInfo(TGoogleLanguages),integer(self));
end;

function TGoogleLanguagesHelper.Codigo: string;
begin
  Result := GoogleLanguagesArr[Self];
end;



end.
