unit uIR;

interface

type
  IMinhaInterface = interface
    ['{ABCDE207-8AFF-42F8-8547-E3193E20AC33}']

    function GetTexto: string;
  end;

  TRecordQualquer = record
    P1, P2, P3, P4: Pointer;

    class function Create: TRecordQualquer; static;
  end;

function Testar: string;

implementation

{$region 'Detalhes'}
{ TRecordQualquer }

function ARC(Self: Pointer): Integer; stdcall;
begin
  Result := -1;
end;

class function TRecordQualquer.Create: TRecordQualquer;
begin
  Result.P1 := nil;
  Result.P2 := @ARC;
  Result.P3 := @ARC;
end;

{$endregion}

function GetTexto(Sender: Pointer): string;
begin
  Result := 'Embarcadero Conference 2018';
end;

function Testar: string;
var
  lInterface: IMinhaInterface;
  lRecord: TRecordQualquer;
  lPointer: Pointer;
begin
  lRecord := TRecordQualquer.Create;

  lRecord.P4 := @GetTexto;

  lPointer := @lRecord;

  lInterface := IMinhaInterface(@lPointer);

  Result := lInterface.GetTexto;
end;



end.
