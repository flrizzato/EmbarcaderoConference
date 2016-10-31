unit MotoG;

interface

implementation

uses

  system.Devices, system.Types, system.SysUtils;

const
  ViewName = '289212518DCD427E987F178CBFCEF2EE'; // The name of the view.

  {
    Add this after DevicePresets in
      Embarcadero\BDS\17.0\DevicePresets.xml

    Sample:
    C:\Users\Administrator\AppData\Roaming\Embarcadero\BDS\17.0\DevicePresets.xml

    <MobileDevice>
	<UserData>True</UserData>
	<Name>GearLive</Name>
    <Displayname>GearLive</Displayname>
	<FormFactor>8</FormFactor>
	<DevicePlatform Default="False">3</DevicePlatform>
    <Portrait Enabled="True" Width="213" Height="213" Top="227" Left="313" StatusbarHeight="0" StatusBarPos="0" Artwork="C:\DC2015\NewsIDE\GearLive.png" />
    <UpsideDown Enabled="False" Width="213" Height="213" Top="0" Left="0" StatusbarHeight="0" StatusBarPos="0" Artwork="" />
    <LandscapeLeft Enabled="False" Width="213" Height="213" Top="0" Left="0" StatusbarHeight="0" StatusBarPos="0" Artwork="" />
    <LandscapeRight Enabled="False" Width="213" Height="213" Top="0" Left="0" StatusbarHeight="0" StatusBarPos="0" Artwork="" />
    </MobileDevice>
  }

initialization

// The GearLive is 320x320 phyiscal and 213x213 logical with 278 PPI
TDeviceinfo.AddDevice(TDeviceinfo.TDeviceClass.Tablet, ViewName,
  TSize.Create(320, 320),
  TSize.Create(213, 213),
  TOSVersion.TPlatform.pfAndroid,
  278,
  True);

finalization

TDeviceinfo.RemoveDevice(ViewName);
// To unregister the view after unistalling the package.

end.
