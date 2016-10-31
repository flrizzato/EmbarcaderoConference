unit uOSVersionUtils;

interface

uses
  System.SysUtils;

function OSArchitectureToStr(const a: TOSVersion.TArchitecture): string;
function OSPlatformToStr(const p: TOSVersion.TPlatform): string;

implementation

function OSArchitectureToStr(const a: TOSVersion.TArchitecture): string;
begin
  case a of
    arIntelX86:
      Result := 'IntelX86';

    arIntelX64:
      Result := 'IntelX64';

    else
      Result := 'UNKNOWN OS architecture';
  end;
end;

function OSPlatformToStr(const p: TOSVersion.TPlatform): string;
begin
  case p of
    pfWindows:
      Result := 'Windows';

    pfMacOS:
      Result := 'MacOS';

    else
      Result := 'UNKNOWN OS Platform';
  end;
end;

end.
