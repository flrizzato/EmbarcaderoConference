unit uMukaConsoleLogger;

interface

uses
  //DUnitX.Loggers.Console,
  //DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework, Vcl.Dialogs;


type
  TRefProcExecuteTest = reference to procedure(const threadId: TThreadID; const Test: ITestInfo);
  TRefProcLog = reference to procedure(const logType : TLogLevel; const msg : string);
  TRefProcTestingStarts = reference to procedure (const threadId: TThreadID; testCount, testActiveCount : Cardinal);

  TMukaConsoleLogger = class(TInterfacedObject, ITestLogger)
  private
    FRefProcExecuteTest: TRefProcExecuteTest;
    FRefProcLog: TRefProcLog;
    FRefProcTestingStarts: TRefProcTestingStarts;
  protected
    procedure OnTestingStarts(const threadId: TThreadID; testCount, testActiveCount : Cardinal);
    procedure OnStartTestFixture(const threadId: TThreadID; const fixture: ITestFixtureInfo);
    procedure OnSetupFixture(const threadId: TThreadID; const fixture: ITestFixtureInfo);
    procedure OnEndSetupFixture(const threadId: TThreadID; const fixture: ITestFixtureInfo);
    procedure OnBeginTest(const threadId: TThreadID; const Test: ITestInfo);
    procedure OnSetupTest(const threadId: TThreadID; const Test: ITestInfo);
    procedure OnEndSetupTest(const threadId: TThreadID; const Test: ITestInfo);
    procedure OnExecuteTest(const threadId: TThreadID; const Test: ITestInfo);
    procedure OnTestMemoryLeak(const threadId : TThreadID; const Test: ITestResult);
    procedure OnTestIgnored(const threadId: TThreadID; const  AIgnored: ITestResult);
    procedure OnTestError(const threadId: TThreadID; const Error: ITestError);
    procedure OnTestFailure(const threadId: TThreadID; const Failure: ITestError);
    procedure OnTestSuccess(const threadId: TThreadID; const Test: ITestResult);
    procedure OnLog(const logType : TLogLevel; const msg : string);
    procedure OnTeardownTest(const threadId: TThreadID; const Test: ITestInfo);
    procedure OnEndTeardownTest(const threadId: TThreadID; const Test: ITestInfo);
    procedure OnEndTest(const threadId: TThreadID; const Test: ITestResult);
    procedure OnTearDownFixture(const threadId: TThreadID; const fixture: ITestFixtureInfo);
    procedure OnEndTearDownFixture(const threadId: TThreadID; const fixture: ITestFixtureInfo);
    procedure OnEndTestFixture(const threadId: TThreadID; const results: IFixtureResult);
    procedure OnTestingEnds(const RunResults: IRunResults);
  public
    procedure ExecuteTest(pRefProcExecuteTest :TRefProcExecuteTest);
    procedure Log(pRefProcLog :TRefProcLog);
    procedure TestingStarts(pRefProcTestingStarts: TRefProcTestingStarts);
    constructor Create(const quietMode : boolean = false);
    destructor Destroy;override;
  end;


implementation

{ TMukaConsoleLogger }

constructor TMukaConsoleLogger.Create(const quietMode: boolean);
begin

end;

destructor TMukaConsoleLogger.Destroy;
begin

  inherited;
end;

procedure TMukaConsoleLogger.OnBeginTest(const threadId: TThreadID;
  const Test: ITestInfo);
begin

end;

procedure TMukaConsoleLogger.OnEndSetupFixture(const threadId: TThreadID;
  const fixture: ITestFixtureInfo);
begin

end;

procedure TMukaConsoleLogger.OnEndSetupTest(const threadId: TThreadID;
  const Test: ITestInfo);
begin

end;

procedure TMukaConsoleLogger.OnEndTearDownFixture(const threadId: TThreadID;
  const fixture: ITestFixtureInfo);
begin

end;

procedure TMukaConsoleLogger.OnEndTeardownTest(const threadId: TThreadID;
  const Test: ITestInfo);
begin

end;

procedure TMukaConsoleLogger.OnEndTest(const threadId: TThreadID;
  const Test: ITestResult);
begin

end;

procedure TMukaConsoleLogger.OnEndTestFixture(const threadId: TThreadID;
  const results: IFixtureResult);
begin

end;

procedure TMukaConsoleLogger.ExecuteTest(pRefProcExecuteTest: TRefProcExecuteTest);
begin
  FRefProcExecuteTest := pRefProcExecuteTest;
end;

procedure TMukaConsoleLogger.Log(pRefProcLog: TRefProcLog);
begin
  FRefProcLog := pRefProcLog;
end;

procedure TMukaConsoleLogger.OnExecuteTest(const threadId: TThreadID;
  const Test: ITestInfo);
begin
  FRefProcExecuteTest(threadId,Test);
end;

procedure TMukaConsoleLogger.OnLog(const logType: TLogLevel; const msg: string);
begin
  FRefProcLog(logType, msg);
end;

procedure TMukaConsoleLogger.OnSetupFixture(const threadId: TThreadID;
  const fixture: ITestFixtureInfo);
begin

end;

procedure TMukaConsoleLogger.OnSetupTest(const threadId: TThreadID;
  const Test: ITestInfo);
begin

end;

procedure TMukaConsoleLogger.OnStartTestFixture(const threadId: TThreadID;
  const fixture: ITestFixtureInfo);
begin

end;

procedure TMukaConsoleLogger.OnTearDownFixture(const threadId: TThreadID;
  const fixture: ITestFixtureInfo);
begin

end;

procedure TMukaConsoleLogger.OnTeardownTest(const threadId: TThreadID;
  const Test: ITestInfo);
begin

end;

procedure TMukaConsoleLogger.OnTestError(const threadId: TThreadID;
  const Error: ITestError);
begin

end;

procedure TMukaConsoleLogger.OnTestFailure(const threadId: TThreadID;
  const Failure: ITestError);
begin

end;

procedure TMukaConsoleLogger.OnTestIgnored(const threadId: TThreadID;
  const AIgnored: ITestResult);
begin

end;

procedure TMukaConsoleLogger.OnTestingEnds(const RunResults: IRunResults);
begin

end;

procedure TMukaConsoleLogger.OnTestingStarts(const threadId: TThreadID;
  testCount, testActiveCount: Cardinal);
begin
  FRefProcTestingStarts(threadId,testCount, testActiveCount);
end;

procedure TMukaConsoleLogger.OnTestMemoryLeak(const threadId: TThreadID;
  const Test: ITestResult);
begin

end;

procedure TMukaConsoleLogger.OnTestSuccess(const threadId: TThreadID;
  const Test: ITestResult);
begin

end;

procedure TMukaConsoleLogger.TestingStarts(
  pRefProcTestingStarts: TRefProcTestingStarts);
begin
  FRefProcTestingStarts := pRefProcTestingStarts;
end;

end.
