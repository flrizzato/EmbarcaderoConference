unit Unit2;

interface

type
  TUtils = class
    class function GenerateFileName: string; static;
  end;

implementation

uses System.SysUtils;

class function TUtils.GenerateFileName: string;
var
  guid: TGUID;
  sGuid: string;
begin
  guid := guid.NewGuid;
  sGuid := GUIDToString(guid.NewGuid);
  sGuid := StringReplace(sGuid, '{', '', [rfReplaceAll]);
  sGuid := StringReplace(sGuid, '}', '', [rfReplaceAll]);
  sGuid := StringReplace(sGuid, '-', '', [rfReplaceAll]);
  Result := sGuid + '.jpg';
end;

end.
