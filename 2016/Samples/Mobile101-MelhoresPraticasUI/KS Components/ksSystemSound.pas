unit ksSystemSound;

interface

{$I ksComponents.inc}

uses System.Classes, ksTypes;

const
  libAudioToolbox = '/System/Library/Frameworks/AudioToolbox.framework/AudioToolbox';


type

  TksSystemSound = class(TInterfacedObject, IksSystemSound)
  public
    procedure Play(ASound: TksSound); overload;
    procedure Play(ASoundIndex: integer); overload;
  end;

implementation

uses Types
{$IFDEF ANDROID}
    ,androidapi.jni.media, FMX.Helpers.Android, androidapi.jni.JavaTypes, Androidapi.JNI.GraphicsContentViewText,Androidapi.JNIBridge,
    androidapi.helpers
  {$ENDIF}
;
  {$IFDEF IOS}

  procedure AudioServicesPlaySystemSound( inSystemSoundID: UInt32 ); cdecl; external libAudioToolbox name 'AudioServicesPlaySystemSound';
  procedure AudioServicesPlayAlertSound( inSystemSoundID: UInt32 ); cdecl; external libAudioToolbox name 'AudioServicesPlayAlertSound';

  {$ENDIF}

 
procedure TksSystemSound.Play(ASound: TksSound);
var
  AId: integer;
begin
  AId := -1;
  {$IFDEF IOS}
  case ASound of
    ksMailNew: AId := 1000;
    ksMailSent: AId := 1001;
    ksVoiceMail: AId := 1002;
    ksMessageReceived: AId := 1003;
    ksMessageSent: AId := 1004;
    ksBeep: AId := 1052;
    ksCameraShutter: AId := 1108;
  end;


  {$ENDIF}

  {$IFDEF ANDROID}
  case ASound of
    ksBeep: AId := 6;
    ksCameraShutter: AId := 8;
  end;
  {$ENDIF}

  if AId = -1 then
    Exit;
  Play(AId);
end;

procedure TksSystemSound.Play(ASoundIndex: integer);
{$IFDEF ANDROID}
var
  AAudioMgr : JAudioManager;

{$ENDIF}
begin
  {$IFDEF IOS}
  AudioServicesPlaySystemSound(ASoundIndex);
  {$ENDIF}
  {$IFDEF ANDROID}
  AAudioMgr := TJAudioManager.Wrap((TAndroidHelper.Activity.getSystemService(TJContext.JavaClass.AUDIO_SERVICE) as ILocalObject).GetObjectID);
  AAudioMgr.playSoundEffect(ASoundIndex);

  {$ENDIF}
end;

end.
