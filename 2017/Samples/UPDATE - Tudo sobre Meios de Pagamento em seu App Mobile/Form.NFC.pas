unit Form.NFC;

interface

// JNI NFC import demo
// Note - REQUIRES - PROJECT OPTIONS - USES PERMISSIONS - NFC

///  https://stackoverflow.com/questions/24650883/firemonkey-android-nfc-adapter
///  https://forums.embarcadero.com/thread.jspa?threadID=97574

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  {$IFDEF ANDROID}
  Androidapi.Helpers,
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.GraphicsContentViewText,
  FMX.Helpers.Android,
  {$ENDIF}
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs;

type
  TfrmNFC = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  {$IFDEF ANDROID}
 /////////////////////////// NfcAdapter /////////////////////////////////
  JNfcManager = interface;
  JNfcAdapter = interface;

  JNfcAdapterClass = interface(JObjectClass)
  ['{634258AC-7931-4E38-97E6-48DBF688A288}']
    {Property methods}
    function _ACTION_TAG_DISCOVERED: JString; cdecl;
    function _EXTRA_ID: JString; cdecl;
    function _EXTRA_NDEF_MESSAGES: JString; cdecl;
    function _EXTRA_TAG: JString; cdecl;
    {Properties}
    property ACTION_TAG_DISCOVERED: JString read _ACTION_TAG_DISCOVERED;
    property EXTRA_ID: JString read _EXTRA_ID;
    property EXTRA_NDEF_MESSAGES: JString read _EXTRA_NDEF_MESSAGES;
    property EXTRA_TAG: JString read _EXTRA_TAG;
  end;

  [JavaSignature('android/nfc/NfcAdapter')]
  JNfcAdapter = interface(JObject)
  ['{364D8F3F-23AE-4C28-A261-E30C0893B24C}']
    //Return true if this NFC Adapter has any features enabled
    function isEnabled: Boolean; cdecl;
  end;

  TJNfcAdapter = class(TJavaGenericImport<JNfcAdapterClass, JNfcAdapter>) end;

  /////////////////////////// NfcManager /////////////////////////////////

  JNfcManagerClass = interface(JObjectClass)
  ['{812481E1-F491-47D2-AC1F-4C5AB509532B}']
  end;

  [JavaSignature('android/nfc/NfcManager')]
  JNfcManager = interface(JObject)
  ['{04B707EC-966A-4E4F-85DC-F003B7C9ACE3}']
    {Methods}
    function getDefaultAdapter: JNfcAdapter; cdecl;
  end;

  TJNfcManager = class(TJavaGenericImport<JNfcManagerClass, JNfcManager>) end;

function HasNfc: Boolean;
function IsNfcEnabled: Boolean;
  {$ENDIF}

var
  frmNFC: TfrmNFC;

implementation

{$R *.fmx}

{$IFDEF ANDROID}
function GetNfcManager: JNfcManager;
var
  ConnectivityServiceNative: JObject;
begin
  ConnectivityServiceNative := SharedActivityContext.getSystemService(TJContext.JavaClass.NFC_SERVICE);
  if not Assigned(ConnectivityServiceNative) then
    raise Exception.Create('Could not locate Nfc Service');
  Result := TJNfcManager.Wrap((ConnectivityServiceNative as ILocalObject).GetObjectID);
  if not Assigned(Result) then
    raise Exception.Create('Could not access Nfc Manager');
end;

function HasNfc: Boolean;
var
  NfcManager: JNfcManager;
  NfcAdapter: JNfcAdapter;
begin
  NfcManager := GetNfcManager;
  NfcAdapter := NfcManager.getDefaultAdapter;
  Result := Assigned(NfcAdapter);
end;

function IsNfcEnabled: Boolean;
var
  NfcManager: JNfcManager;
  NfcAdapter: JNfcAdapter;
begin
  NfcManager := GetNfcManager;
  NfcAdapter := NfcManager.getDefaultAdapter;
  Result := Assigned(NfcAdapter)and NfcAdapter.isEnabled;
end;
{$ENDIF}

end.
