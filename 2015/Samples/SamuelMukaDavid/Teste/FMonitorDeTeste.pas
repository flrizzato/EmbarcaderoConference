unit FMonitorDeTeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DUnitX.TestFramework,
  DUnitX.Loggers.Xml.NUnit, uMukaConsoleLogger, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    ProgressBar1: TProgressBar;
    Panel1: TPanel;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ConfigurarMukaConsoleLogger(pMukaConsoleLogger: TMukaConsoleLogger);
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
begin
  //TDUnitX.Options.Include :='Categoria' ;
  //Check command line options, will exit if invalid
  TDUnitX.CheckCommandLine;
  //Create the test runner
  runner := TDUnitX.CreateRunner;
  //Tell the runner to use RTTI to find Fixtures
  runner.UseRTTI := True;
  //tell the runner how we will log things
  //Log to the console window
  logger := TMukaConsoleLogger.Create(true);

  ConfigurarMukaConsoleLogger(TMukaConsoleLogger(logger));

  runner.AddLogger(logger);
  //Generate an NUnit compatible XML File
  nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
  runner.AddLogger(nunitLogger);
  runner.FailsOnNoAsserts := False; //When true, Assertions must be made during tests;
  //Run tests
  results := runner.Execute;
  if not results.AllPassed then
    System.ExitCode := EXIT_ERRORS;
end;

procedure TForm2.ConfigurarMukaConsoleLogger(pMukaConsoleLogger: TMukaConsoleLogger);
begin
  pMukaConsoleLogger.ExecuteTest(procedure (const threadId: TThreadID; const Test: ITestInfo)
                                         begin
                                           memo1.Lines.Add('');
                                           memo1.Lines.Add(Test.Name);
                                           ProgressBar1.StepIt;
                                         end);

  pMukaConsoleLogger.Log(procedure (const logType : TLogLevel; const msg : string)
                                         begin
                                           memo1.Lines.Add('Log: '+msg);
                                         end);

  pMukaConsoleLogger.TestingStarts(procedure (const threadId: TThreadID; testCount, testActiveCount : Cardinal)
                                         begin
                                           ProgressBar1.Position := 0;
                                           ProgressBar1.Max := testCount;
                                         end);


end;

end.
