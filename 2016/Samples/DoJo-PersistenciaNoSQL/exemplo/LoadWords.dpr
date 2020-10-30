program LoadWords;

{$APPTYPE CONSOLE}

{$R *.res}


uses
  System.SysUtils, Redis.Client, Redis.Commons, Redis.NetLib.Indy, System.Classes,
  System.Diagnostics;

procedure Main;
var
  lReader: TStreamReader;
  lPieces: TArray<string>;
  lRedis: IRedisClient;
  lWord: string;
  lSubWord: string;
  lWordLength: Integer;
  lCharsCount: Integer;
  lAns: string;
  iPosBar:integer;
begin
  write('Do you really want to load all the words (y/N)?');
  Readln(lAns);
  if lAns.Trim.ToUpper <> 'Y' then
  begin
    WriteLn('bye bye');
    Halt(1);
  end;

lReader := TStreamReader.Create(TFileStream.Create('pt-BR.dic', fmOpenRead,
    fmShareExclusive), TEncoding.UTF8);

  try
    lRedis := NewRedisClient('newton-mbp');
    lRedis.DEL(['words']);
    while not lReader.EndOfStream do
    begin
      lWord := lReader.ReadLine;
      iPosBar := Pos('/',lWord);
      if iPosBar > 0 then
        lWord := Copy(lWord,1,Pos('/',lWord)-1);

      if Trim(lWord) = '' then
        writeln(iPosBar.ToString);

      lWordLength := length(lWord);
      lCharsCount := 1;
      lSubWord := lWord.Substring(0, lCharsCount);
      while lCharsCount <= lWordLength do
      begin
        lRedis.ZADD('words', 0, lSubWord);
        Inc(lCharsCount);
        lSubWord := lWord.Substring(0, lCharsCount);
      end;
      lRedis.ZADD('words', 0, lWord + '*');
      WriteLn(lWord);
    end;
  finally
    lReader.Free;
  end;
end;

var
  lSW: TStopwatch;

begin
  try
    lSW := TStopwatch.StartNew;
    Main;
    WriteLn(lSW.Elapsed.TotalMinutes);
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end;

  // if DebugHook <> 0 then
  begin
    write('Press return to continue...');
    Readln;
  end;

end.
