unit Unit2;

interface

type
  TUtils = class
    class function GerarNomeArquivo: string; static;
    class function GetRowId(ARowId: string): string; static;
  end;

implementation

uses System.SysUtils;

class function TUtils.GerarNomeArquivo: string;
var
  guid: TGUID;
  sGuid: string;
begin
  guid := guid.NewGuid;
  sGuid := GUIDToString(guid.NewGuid);
  sGuid := StringReplace(sGuid, '{', '', [rfReplaceAll]);
  sGuid := StringReplace(sGuid, '}', '', [rfReplaceAll]);
  sGuid := StringReplace(sGuid, '-', '', [rfReplaceAll]);
  Result := sGuid;
end;

class function TUtils.GetRowId(ARowId: string): string;
var
  rowId: string;
begin
  rowId := ARowId;
  rowId := StringReplace(rowId, 'itemName(): ', '', [rfReplaceAll]);
  Result := Trim(rowId);
end;

end.
