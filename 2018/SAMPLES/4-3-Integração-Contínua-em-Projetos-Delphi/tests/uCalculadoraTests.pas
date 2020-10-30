unit uCalculadoraTests;

interface
uses
  DUnitX.TestFramework, uCalculadora;

type

  [TestFixture]
  TCalculadoraTests = class(TObject)
  private
    FCalculadora: TCalculadora;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    
    [Test]
    procedure TestSomar;

    [Test]
    procedure TestSubtrair;

    [Test]
    procedure TestMultiplicar;

    [Test]
    [TestCase('TestDividir','1,2,0.5')]
    // [TestCase('TestDividirPorZero','12,0,0')]
    procedure TestDividir(const AValue1, AValue2 : Integer; const AValue3 :
        Extended);
  end;

implementation

procedure TCalculadoraTests.Setup;
begin
  FCalculadora := TCalculadora.Create;
end;

procedure TCalculadoraTests.TearDown;
begin
  FCalculadora.Free;
end;


procedure TCalculadoraTests.TestDividir(const AValue1, AValue2 : Integer; const AValue3 : Extended);
begin
  Assert.AreEqual(AValue3, FCalculadora.Dividir(AValue1, AValue2));
end;

procedure TCalculadoraTests.TestMultiplicar;
begin
  Assert.AreEqual(12, FCalculadora.Multiplicar(3, 4));
end;

procedure TCalculadoraTests.TestSomar;
begin
  Assert.AreEqual(2, FCalculadora.Somar(1, 1));
end;

procedure TCalculadoraTests.TestSubtrair;
begin
  Assert.AreEqual(10, FCalculadora.Subtrair(15, 5));
end;

initialization
  TDUnitX.RegisterTestFixture(TCalculadoraTests);
end.
