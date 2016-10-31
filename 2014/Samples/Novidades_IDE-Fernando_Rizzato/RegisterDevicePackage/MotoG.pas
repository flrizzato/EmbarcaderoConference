unit MotoG;

interface

implementation

uses

  system.Devices, system.Types, system.SysUtils;

const
  ViewName = 'GearLive'; // The name of the view.

  {
    Add this after MobileDevices in
      Embarcadero\BDS\15.0\MobileDevices.xml

    Sample:
    C:\Users\Administrador\AppData\Roaming\Embarcadero\BDS\15.0\MobileDevices.xml

    <MobileDevice>
    <Displayname>GearLive</Displayname>
    <Name>GearLive</Name>
    <DevicePlatform>3</DevicePlatform>
    <FormFactor>2</FormFactor>
    <Portrait Enabled="True" Width="213" Height="213" Top="227" Left="313" StatusbarHeight="0" StatusBarPos="0" Artwork="C:\Users\jim\Documents\Embarcadero\Studio\HelloFireUI\GearLive.png" />
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
