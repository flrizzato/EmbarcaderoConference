unit uMainView;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.TimeSpan, System.Diagnostics,
  Vcl.Graphics, Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  PerformanceDiagnostics.Interfaces, PerformanceDiagnostics;

type
  TMyClass = class
  public
    procedure Execute; virtual;
  end;

  TMainView = class(TForm)
    PanelButtons: TPanel;
    ButtonPerformanceDiagnostics: TButton;
    MemoContent: TMemo;
    ButtonDateVariables: TButton;
    ButtonGetTickCount: TButton;
    ButtonStopWatchTimeSpan: TButton;
    procedure ButtonPerformanceDiagnosticsClick(Sender: TObject);
    procedure ButtonStopWatchTimeSpanClick(Sender: TObject);
    procedure ButtonDateVariablesClick(Sender: TObject);
    procedure ButtonGetTickCountClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

procedure TMainView.ButtonDateVariablesClick(Sender: TObject);
var
  ANow: TDateTime;
  AMyClass: TMyClass;
begin
  AMyClass := TMyClass.Create;
  try
    ANow := Now;
    AMyClass.Execute;
  finally
    AMyClass.Free;
  end;
  MemoContent.Lines.Add(Format('DateVariables: %s ', [FormatDateTime('hh:nn:ss.zzz', Now - ANow)]));
end;

procedure TMainView.ButtonGetTickCountClick(Sender: TObject);
var
  ATickInit, ATickCount: Int64;
  AMyClass: TMyClass;
begin
  AMyClass := TMyClass.Create;
  try
    ATickInit := GetTickCount;
    AMyClass.Execute;
  finally
    AMyClass.Free;
  end;
  ATickCount := (GetTickCount - ATickInit);
  MemoContent.Lines.Add(Format('GeetTickCount: %f seconds', [(ATickCount/1000)]));
end;
procedure TMainView.ButtonPerformanceDiagnosticsClick(Sender: TObject);
var
  APerformance: IPerformanceDiagnostics;
  AMyClass: TMyClass;
begin
  AMyClass := TMyClass.Create;
  try
    APerformance := TPerformanceDiagnostics.New(AMyClass).Add('Execute');
    AMyClass.Execute;
  finally
    AMyClass.Free;
  end;
  MemoContent.Lines.Add(Format('PerformanceDiagnostic4Delphi: %f seconds', [APerformance.GetTotalSeconds]));
end;

{ TMinhaClass }

procedure TMyClass.Execute;
var
  I, Aux: Integer;
begin
  for I := 0 to 9999999999 do
    Aux := Trunc(I/2);
end;

procedure TMainView.ButtonStopWatchTimeSpanClick(Sender: TObject);
var
  AStopWatch: TStopwatch; //Cronômetro
  ATimeSpan: TTimeSpan; //Intervalo de Tempo
  AMyClass: TMyClass;
begin
  AMyClass := TMyClass.Create;
  try
    AStopWatch := TStopwatch.StartNew;
    AMyClass.Execute;
    AStopWatch.Stop;
    ATimeSpan := AStopWatch.Elapsed;
  finally
    AMyClass.Free;
  end;
  MemoContent.Lines.Add(Format('TStopWatch and TTimeSpan: %f seconds', [ATimeSpan.TotalSeconds]));
end;

end.
