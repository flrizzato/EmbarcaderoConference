unit Lib.Data.Helpers;
interface
uses Data.DB, System.JSON;

type
  TDataset2JSONHelper = class helper for TDataset
  public
    function CurrentRowAsJSON: TJSONObject;
    function AllRowsAsJSONArray: TJSONArray;
  end;

implementation

{ TDataset2JSONHelper }
function TDataset2JSONHelper.CurrentRowAsJSON: TJSONObject;
var
  AField: TField;
begin
  result:= TJSONObject.Create;
  for AField in Self.Fields do
    result.AddPair(AField.FieldName, AField.AsString);
end;

function TDataset2JSONHelper.AllRowsAsJSONArray: TJSONArray;
begin
  result:= TJSONArray.Create;
  Self.First;
  while not Self.EOF do
  begin
    result.Add(CurrentRowAsJSON);
    Self.Next;
  end;
end;


end.
