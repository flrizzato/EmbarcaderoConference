unit ksSegmentButtonsTest;

interface
uses
  DUnitX.TestFramework, ksSegmentButtons;

type

  [TestFixture]
  TksSegmentButtonsTest = class(TObject)
  private
    FSegmentButtons: TksSegmentButtons;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
  end;

implementation

procedure TksSegmentButtonsTest.Setup;
begin
  FSegmentButtons := TksSegmentButtons.Create(nil);
end;

procedure TksSegmentButtonsTest.TearDown;
begin
  FSegmentButtons.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TksSegmentButtonsTest);
end.
