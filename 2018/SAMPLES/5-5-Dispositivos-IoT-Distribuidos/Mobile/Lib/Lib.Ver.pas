unit Lib.Ver;
interface
uses
 {$IFDEF MSWINDOWS}
 {$IFDEF FIREMONKEY}FMX.Forms{$ELSE}VCL.Forms{$ENDIF},
 Winapi.Windows, Winapi.Messages,
 {$ENDIF}
 System.SysUtils
{$IFDEF ANDROID}
 ,FMX.Helpers.Android, Androidapi.Helpers, Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText, Androidapi.JNI.Net,
  Androidapi.JNI.JavaTypes, Androidapi.JNI.PlayServices
{$ENDIF}
{$IFDEF IOS}
  , iOSapi.Foundation, Macapi.ObjectiveC, Macapi.Helpers
{$ENDIF}
 ;
type
  TAppVer = class
  private
    {$IFDEF MSWINDOWS}
    class function GetFileInfo(const FName: string; const InfoType: array of string; Default:string): string;
    {$ENDIF}
  public
    class function GetVerName: string;
    //class function GetVerCode: integer;
  end;

implementation

{ TFileVer }
{class function TAppVer.GetVerCode: integer;
begin

end;}

class function TAppVer.GetVerName: string;
{$IFDEF ANDROID}
var
  PKName: JString;
{$ENDIF}
{$IFDEF IOS}
var
  AppNameKey: Pointer;
  AppBundle: NSBundle;
  NSAppName: NSString;
{$ENDIF}
begin
  {$IFDEF ANDROID}
  PKName:= TAndroidHelper.Activity.getPackageName;
  result:= JStringToString(TAndroidHelper.Activity.getPackageManager.getPackageInfo(PKName, 0).versionName);
  {$ENDIF}
  {$IFDEF IOS}
  AppBundle:= TNSBundle.Wrap(TNSBundle.OCClass.mainBundle);
  AppNameKey:= (StrToNSSTR('CFBundleVersion') as ILocalObject).GetObjectID;
  NSAppName:= TNSString.Wrap(AppBundle.infoDictionary.objectForKey(AppNameKey));
  result:= UTF8ToString(NSAppName.UTF8String);
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  result:= ExtractFilePath(GetModuleName(HInstance));
  result:= result.Substring(result.IndexOf(':') - 1);
  result:= GetFileInfo(result, ['FileVersion'], '');
  {$ENDIF}
end;

{$IFDEF MSWINDOWS}
class function TAppVer.GetFileInfo(const FName: string; const InfoType: array of string; Default:string): string;
type
  TLangCodePage = record
                    wLanguage,
                    wCodePage: Word;
                   end;
  PLangCodePage = ^TLangCodePage;
const
  CodePage      = $04E4;  // Multilingual
  Languages     : array[1..5] of WORD = ($0416,$0409,$0809,$040C,$080A);
var                                     // BR    US    UK    FR    ES
  i,j           : integer;
  PVerInfo      : Pointer;
  iVerInfo      : DWORD;
  iVerTrans     : UINT;
  PVerTrans     : PLangCodePage;
  Dummy         : DWORD;

  function VerQueryInfo(const Info:string;dwLang,dwCodePage:WORD;var Value:string):boolean;
  var
    QueryInfo : string;
    iVerValue : UINT;
    PVerValue : Pointer;
  begin
    QueryInfo:=Format('\StringFileInfo\%0.4x%0.4x\%s',[dwLang,dwCodePage,Info]);
    Result:=VerQueryValue(PVerInfo,PChar(QueryInfo),PVerValue,iVerValue);
    if Result then SetString(Value,PChar(PVerValue),iVerValue-1);
  end;

begin
  Result:=Default;
  if Length(FName)=0 then exit;

  iVerInfo:=GetFileVersionInfoSize(PChar(FName),Dummy);
  if iVerInfo>0 then
  try
    GetMem(PVerInfo,iVerInfo);
    try
      if GetFileVersionInfo(PChar(FName),0,iVerInfo,PVerInfo) then
        if VerQueryValue(PVerInfo,'\VarFileInfo\Translation', Pointer(PVerTrans), iVerTrans) then
        begin
          for i:=low(InfoType) to High(InfoType) do
            if VerQueryInfo(InfoType[i], PVerTrans.wLanguage, PVerTrans.wCodePage, Result) then
              Break;
        end
        else
        begin
          for j:=low(Languages) to High(Languages) do
            for i:=low(InfoType) to High(InfoType) do
              if VerQueryInfo(InfoType[i] ,Languages[j], CodePage, Result) then
                Break;
        end;
   finally
      FreeMem(PVerInfo,iVerInfo);
    end;
  except
    On E:Exception do
      Result:=E.Message;
  end;
end;
{$ENDIF}

end.
